# Import necessary modules
from shiny import App, render, ui           # Shiny components for building the web app
import pandas as pd                         # For data manipulation
import matplotlib.pyplot as plt             # For plotting
import seaborn as sns                       # For accessing built-in datasets and aesthetics

# Define the User Interface
app_ui = ui.page_fluid(  # Use a fluid layout for a responsive page

    # Input widgets
    ui.input_slider("bins", "Enter number of bins for histogram:", 2, 100, 10),
    # Slider to choose number of bins for histogram (min: 2, max: 100, default: 10)

    ui.input_radio_buttons("num", "Select number to print", choices=[1, 5, 10], selected=1),
    # Radio buttons to choose a number to display

    ui.input_select("data", "Select dataset", choices=sns.get_dataset_names(), selected="iris"),
    # Dropdown to choose a built-in seaborn dataset

    # Output areas
    ui.output_plot("hist"),           # Where the histogram will be shown
    ui.output_text_verbatim("print"), # Where the selected number will be printed
    ui.output_data_frame("summary")   # Where the top rows of the selected dataset will be displayed
)

# Define the Server Logic
def server(input, output, session):

    # Render the histogram plot
    @render.plot
    def hist():
        data = sns.load_dataset("mpg")["mpg"]  # Load the 'mpg' column from the 'mpg' dataset
        bins = input.bins()  # Get the number of bins from slider input
        plt.hist(data, bins=bins, color="darkblue")  # Create the histogram
        plt.title("Histogram of fuel efficiency in cars")
        plt.xlabel("Miles per gallon")
        plt.ylabel("Frequency")

    # Render the selected number from the radio buttons
    @render.text
    def print():
        return f"Selected number {input.num()}"  # Display the selected number as text

    # Render the data table showing first 5 rows of selected dataset
    @render.data_frame
    def summary():
        data = pd.DataFrame(sns.load_dataset(input.data()))  # Load selected dataset as DataFrame
        return data.head()  # Show first 5 rows

# Combine UI and server to create the app
app = App(app_ui, server)
