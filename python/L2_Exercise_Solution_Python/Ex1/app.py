from shiny import App, render, ui
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns



app_ui = ui.page_fluid(

    ui.input_slider("bins", "Enter number of bins for histogram:", 2, 100, 10),
    ui.input_radio_buttons("num", "Select number to print", choices = [1, 5, 10], selected= 1),
    ui.input_select("data", "Select dataset", choices = sns.get_dataset_names(), selected = "iris"),

    ui.output_plot("hist"),
    ui.output_text_verbatim("print"),
    ui.output_data_frame("summary")
)


def server(input, output, session):
    @render.plot
    def hist():
        data = sns.load_dataset("mpg")["mpg"]
        bins = input.bins() # Read  slider input 
        plt.hist(data, bins=bins, color="darkblue")
        plt.title(f"Histogram of fuel efficiency in cars ")
        plt.xlabel("Miles per gallon")
        plt.ylabel("Frequency")
        
    @render.text
    def print():
        return f"Selected number {input.num()}"

    @render.data_frame
    def summary():
        data = pd.DataFrame(sns.load_dataset(input.data()))
        return data.head()


app = App(app_ui, server)
