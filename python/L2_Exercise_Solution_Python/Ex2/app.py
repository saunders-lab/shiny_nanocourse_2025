from shiny import App, render, ui
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import shinyswatch

app_ui = ui.page_fluid(
    ui.h2("Exercise 2"),  # Title of the app

    ui.navset_tab(  # Tab-based layout
        ui.nav_panel(
            "Histogram",
            ui.layout_sidebar(
                ui.sidebar(
                    ui.input_slider("bins", "Enter number of bins for histogram:", 2, 100, 10)
                ),
                
            ui.output_plot("hist")
                
            )
        ),
        ui.nav_panel(
            "Print",
            ui.layout_sidebar(
                ui.sidebar(
                    ui.input_radio_buttons("num", "Select number to print", choices=[1, 5, 10], selected=1)
                ),
                
                ui.output_text_verbatim("print_text")
                
            )
        ),
        ui.nav_panel(
            "Data",
            ui.layout_sidebar(
                ui.sidebar(
                    ui.input_select("data", "Select dataset", choices=sns.get_dataset_names(), selected="iris")
                ),
                
                ui.output_data_frame("table")
                
            )
        )
    ),
    theme=shinyswatch.theme.cyborg  # Applying a theme
)

def server(input, output, session):
    @render.plot
    def hist():
        data = sns.load_dataset("mpg")["mpg"]
        plt.hist(data, bins=input.bins(), color="darkblue")
        plt.title("Histogram of fuel efficiency in cars")
        plt.xlabel("Miles per gallon")
        plt.ylabel("Frequency")

    @render.text
    def print_text():
        return f"Selected number: {input.num()}"

    @render.data_frame
    def table():
        try:
            df = sns.load_dataset(input.data())
            return df.head()
        except:
            return pd.DataFrame({"Error": ["Dataset could not be loaded."]})

app = App(app_ui, server)
