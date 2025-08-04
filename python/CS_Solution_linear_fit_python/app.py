from shiny import App, ui, render, reactive
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

# UI definition
app_ui = ui.page_fluid(
    ui.panel_title("Linear Model Fitting with Shiny"),
    ui.layout_sidebar(
        ui.sidebar(
            ui.input_slider("n_points", "Number of Data Points", min=10, max=200, value=50),
            ui.input_numeric("slope", "True Slope", value=2),
            ui.input_numeric("intercept", "True Intercept", value=5),
            ui.input_numeric("noise_sd", "Noise Standard Deviation", value=1, min=0),
        ),
        ui.h3("Generated Data and Fitted Line"),
        ui.output_plot("data_plot"),
        ui.h3("Model Summary"),
        ui.output_text_verbatim("model_summary")
        )
    )

# Server logic
def server(input, output, session):
    
    @reactive.calc
    def generate_data():
        np.random.seed(42)  # for reproducibility
        x = np.linspace(0, 10, input.n_points())
        y_true = input.slope() * x + input.intercept()
        y_noisy = y_true + np.random.normal(0, input.noise_sd(), input.n_points())
        return pd.DataFrame({'x': x, 'y': y_noisy})

    @render.plot
    def data_plot():
        df = generate_data()
        X = df[['x']]
        y = df['y']

        model = LinearRegression()
        model.fit(X, y)
        y_pred = model.predict(X)

        fig, ax = plt.subplots()
        ax.scatter(df['x'], df['y'], label="Generated Data")
        ax.plot(df['x'], y_pred, color='red', label="Fitted Line")
        ax.set_xlabel("X")
        ax.set_ylabel("Y")
        ax.set_title("Data and Linear Regression Fit")
        ax.legend()
        return fig

    @render.text
    def model_summary():
        df = generate_data()
        X = df[['x']]
        y = df['y']

        model = LinearRegression()
        model.fit(X, y)

        summary_text = f"Fitted Model:\n"
        summary_text += f"  Intercept: {model.intercept_:.2f}\n"
        summary_text += f"  Coefficient (x): {model.coef_[0]:.2f}\n"
        return summary_text

app = App(app_ui, server)