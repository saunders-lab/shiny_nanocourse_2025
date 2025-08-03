# -----------------------------#
# L3_SHINY EXERCISE  –  PYTHON 
# -----------------------------#

from shiny import App, ui, render, reactive
import numpy as np
import matplotlib.pyplot as plt



# -----------------------  UI  ------------------------------
app_ui = ui.page_fluid(
    # Browser-tab title
    page_title="Lecture3_Exercise",

    # Visible title
    ui.h2("Lecture3_Exercise"),

    ui.layout_sidebar(
        # ── Sidebar ─────────────────────────────────────────
        ui.panel_sidebar(
            ui.input_numeric(
                "n", "Observations",
                value=100, min=10, max=50_000
            ),
            ui.input_slider(
                "bins", "Histogram bins",
                min=1, max=100, value=20
            ),
            ui.input_text(
                "name", "Your name", value=""
            ),
            ui.input_action_button(
                "draw", "Draw / Reshuffle"
            ),
        ),
        # ── Main panel ──────────────────────────────────────
        ui.panel_main(
            ui.output_plot("hist"),
            ui.output_text_verbatim("msg"),
        ),
    ),
)

# --------------------- SERVER ------------------------------
def server(input, output, session):
    # — 1. reactive vector of random values
    @reactive.calc
    def rand():
        return np.random.randn(input.n())  # same length as input.n

    # — 2. reshuffled version, triggered by button
    @reactive.event(input.draw)
    def shuffled():
        values = rand().copy()
        np.random.shuffle(values)
        return values

    # — 3. notify when the length changes
    @reactive.effect
    def _notify_length_change():
        input.n()  # dependency
        ui.notification_show(
            f"New vector length: {input.n()}",
            type="message", duration=2
        )

    # — 4. notify when reshuffled
    @reactive.effect
    @reactive.event(input.draw)
    def _notify_reshuffle():
        ui.notification_show("Values reshuffled!", duration=1)

    # — 5. histogram output
    @output
    @render.plot
    def hist():
        data = shuffled()
        
        bins = np.linspace(data.min(), data.max(), input.bins() + 1)
        fig, ax = plt.subplots()
        ax.hist(data, bins=bins)
        ax.set_title("Histogram of random values")
        ax.set_xlabel("Value")
        return fig

    # — 6. greeting message
    @output
    @render.text
    def msg():
        if input.draw() < 1 or input.name() == "":
            return ""  # suppress until button clicked and name entered
        return (
            f"Hello {input.name()}! "
            f"You chose {input.n()} samples."
        )

# --------------------  RUN APP  -----------------------------
app = App(app_ui, server)