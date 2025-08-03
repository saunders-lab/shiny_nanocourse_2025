# ────────────────────────────────────────────────────────────────
# Differential-expression Shiny app
# ────────────────────────────────────────────────────────────────
library(shiny)
library(bslib)
library(shinyFeedback)
library(reactlog)
library(ggplot2)
library(dplyr)
library(tibble)
library(DESeq2)
library(apeglm)


reactlog_enable()

# ─────────────── UI ───────────────
ui <-  fluidPage(                             
  tags$div(class = "mb-3",
  tags$h2("DGE Project")),

    navbarPage(
    title = "TABS",
    theme = bs_theme(version = 5, bootswatch = "united"),

    # ======= Tab 1 ─ Samples =======
    tabPanel(
      "Samples",
      sidebarLayout(
        sidebarPanel(
          h3("Import Count Matrix"),
          fileInput(
            "file", "Upload count matrix (CSV / TSV)",
            accept = c(".csv", ".tsv", ".txt")
          ),
          br(),
          uiOutput("condition_assignment_ui"),
          actionButton(
            "submit_conditions",
            "Confirm Sample Conditions",
            class = "btn-success w-100"
          )
        ),
        mainPanel(
          dataTableOutput("counts_dt")   
        )
      )
    ),

    # ======= Tab 2 ─ DE =======
    tabPanel(
      "DE",
      sidebarLayout(
        sidebarPanel(
          actionButton(
            "run_deseq",
            "Run DESeq2",
            class = "btn-primary w-100"
          ),
          hr(),
          sliderInput(
            "Log2Fold",
            "Log2FC range",
            min   = -20,
            max   =  20,
            value = c(-2, 2)
          )
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("Table", dataTableOutput("de_dt")),
            tabPanel("Plots",
                    plotOutput("plot1", click = "plot_click"),
                    verbatimTextOutput("info"),
                    tableOutput("data"))
          )
        )
      )
    )
  )
)

# ─────────────── SERVER ───────────────
server <- function(input, output, session) {

  # ---- 1. Read counts file ----
  uploaded_data <- reactive({
    req(input$file)
    ext   <- tools::file_ext(input$file$name)
    delim <- if (ext %in% c("tsv", "txt")) "\t" else ","
    read.delim(input$file$datapath, sep = delim, check.names = FALSE)
  })

  # ---- 2. Dynamic condition inputs ----
  output$condition_assignment_ui <- renderUI({
    req(uploaded_data())
    sample_names <- colnames(uploaded_data())[-1]   # skip gene column
    tagList(
      h4("Assign a condition to each sample"),
      lapply(seq_along(sample_names), function(i) {
        textInput(
          paste0("condition_", i),
          label = sample_names[i],
          value = "control"
        )
      })
    )
  })

  # ---- 3. Interactive counts table ----
  output$counts_dt <- renderDataTable({
    req(uploaded_data())
    uploaded_data()
  }, options = list(pageLength = 10, scrollX = TRUE))

  # ---- 4. Build metadata after confirmation ----
  user_metadata <- eventReactive(input$submit_conditions, {
    sample_names <- colnames(uploaded_data())[-1]
    conditions   <- sapply(seq_along(sample_names),
                           \(i) input[[paste0("condition_", i)]])
    validate(need(length(unique(conditions)) >= 2,
                  "Please enter at least two distinct conditions."))
    tibble(Sample = sample_names,
           Condition = factor(conditions)) |>
      column_to_rownames("Sample")
  })

  observeEvent(user_metadata(), {
    showNotification("Sample conditions captured – ready to run DESeq2!",
                     type = "message", duration = 6)
  })

  # ---- 5. Run DESeq2 on demand ----
  deseq_result <- eventReactive(input$run_deseq, {
    req(uploaded_data(), user_metadata())
    counts <- uploaded_data() |> column_to_rownames(colnames(uploaded_data())[1])
    counts <- counts[, rownames(user_metadata())]    # align columns

    dds <- DESeqDataSetFromMatrix(countData = counts,
                                  colData   = user_metadata(),
                                  design    = ~ Condition)
    dds <- DESeq(dds)
    res <- lfcShrink(dds, coef = 2, type = "apeglm")

    as.data.frame(res) |> rownames_to_column("Gene")
  })

  observeEvent(deseq_result(), {
    showNotification("DESeq2 run completed!", type = "message")
  })

  # ---- 6. Filter by log2FC slider ----
  selected <- reactive({
    req(deseq_result(), input$Log2Fold)
    deseq_result() |>
      filter(!is.na(padj),
             log2FoldChange >= input$Log2Fold[1],
             log2FoldChange <= input$Log2Fold[2]) |>
      mutate(
        negLog10Padj = -log10(padj),
        significance = if_else(
          padj < 0.05 & abs(log2FoldChange) > 0.9,
          "Significant", "Not significant")
      ) |>
      arrange(desc(log2FoldChange))
  })

  # ---- 7. DE results table ----
  output$de_dt <- renderDataTable({
    req(selected())
    selected()
  }, options = list(pageLength = 25, scrollX = TRUE))

  # ---- 8. Volcano plot ----
  output$plot1 <- renderPlot({
    data  <- selected();               req(nrow(data) > 0)
    up    <- levels(user_metadata()$Condition)[2]  # positive log2FC side
    down  <- levels(user_metadata()$Condition)[1]  # negative log2FC side

   
    ggplot(data, aes(log2FoldChange, negLog10Padj, color = significance)) +
      geom_point(alpha = 0.6, size = 1.5) +
      scale_color_manual(values = c("Significant" = "red",
                                    "Not significant" = "grey")) +
      geom_vline(xintercept = c(-1, 1),  linetype = "dashed") +
      geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
      labs(title = "Volcano plot",
            subtitle = paste("  <-----------", down, "   |   ", up, "----------->"),
           x = "Log2 Fold Change", y = "-log10 padj",
           color = "Significance") +
      theme_minimal()
  }, res = 96)

  # ---- 9. Click-to-inspect gene ----
  output$info <- renderPrint({
    req(input$plot_click)
    cat("Clicked at [",
        round(input$plot_click$x, 2), ", ",
        round(input$plot_click$y, 2), "]", sep = "")
  })

  output$data <- renderTable({
    req(input$plot_click)
    nearPoints(selected(), input$plot_click)[,
               c("Gene", "log2FoldChange", "padj")]
  })
}

# ─────────────── RUN APP ───────────────
shinyApp(ui, server)
