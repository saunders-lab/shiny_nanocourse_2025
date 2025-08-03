# Import required libraries
from shiny import App, render, ui
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import shinyswatch  # For applying Bootstrap-based themes

# Define the UI
app_ui = ui.page_fluid(  # Use a fluid layout that stretches across the browser window
    ui.h2("Exercise 2"),  # Title of the app

    ui.navset_tab(  # Create a tabbed layout with three tabs
        
        # ---------- Tab 1: Histogram ----------
        ui.nav_panel(
            "Histogram",
            ui.layout_sidebar(  # Sidebar layout for this tab
                ui.sidebar(
                    # Slider input to select the number of bins for the histogram
                    ui.input_slider("bins", "Enter number of bins for histogram:", 2, 100, 10)
                ),
                # Main panel showing the histogram plot
                ui.output_plot("hist")
            )
        ),

        # ---------- Tab 2: Print ----------
        ui.nav_panel(
            "Print",
            ui.layout_sidebar(
                ui.sidebar(
                    # Radio buttons to select a number
                    ui.input_radio_buttons("num", "Select number to print", choices=[1, 5, 10], selected=1)
                ),
                # Main panel showing the selected number
                ui.output_text_verbatim("print_text")
            )
        ),

        # ---------- Tab 3: Data ----------
        ui.nav_panel(
            "Data",
            ui.layout_sidebar(
                ui.sidebar(
                    # Dropdown to select one of seaborn's built-in datasets
                    ui.input_select("data", "Select dataset", choices=sns.get_dataset_names(), selected="iris")
                ),
                # Main panel showing the first few rows of the selected dataset
                ui.output_data_frame("table")
            )
        )
    ),

    # Optional: Apply a theme from shinyswatch (e.g. dark-themed "cyborg")
    theme=shinyswatch.theme.cyborg
)

# Define the server logic
def server(input, output, session):
    # Render the histogram based on the selected number of bins
    @render.plot
    def hist():
        data = sns.load_dataset("mpg")["mpg"]  # Use 'mpg' column from seaborn's 'mpg' dataset
        plt.hist(data, bins=input.bins(), color="darkblue")
        plt.title("Histogram of fuel efficiency in cars")
        plt.xlabel("Miles per gallon")
        plt.ylabel("Frequency")

    # Display the selected number from the radio buttons
    @render.text
    def print_text():
        return f"Selected number: {input.num()}"

    # Load and display the first 5 rows of the selected dataset
    @render.data_frame
    def table():
        try:
            df = sns.load_dataset(input.data())  # Load selected dataset from seaborn
            return df.head()
        except:
            # Return error message as a fallback if dataset load fails
            return pd.DataFrame({"Error": ["Dataset could not be loaded."]})

# Combine UI and server into the final Shiny App
app = App(app_ui, server)
