# 🚀 Setup Instructions: Running Python Shiny Apps

Follow the steps below to set up and run your Shiny for Python app using a Conda environment in Terminal or Visual Studio Code.

---

## 🔧 Steps
### 1. Clone the repository from github

```bash
git clone https://github.com/your-org/your-repo-name.git
```

### 2. Open Terminal

> You can open the terminal or command propmt in your laptops.

### 3. Navigate to the folder containing `environment.yml` file

```bash
cd /path/to/your/yml_file
```


### 4. Create a new Conda environment from the `environment.yml` file

For windows systems, you might have to open the anaconda prompt to make the environment

```bash
conda env create -f environment.yml
```

This will create a new environment named `shiny_env` (or whatever name is specified in the file).

### 5. Navigate to your shiny app folder
```bash
cd /path/to/your/shiny_app
```

### 6. Activate the environment

```bash
conda activate shiny_env
```

### 7. Run your Shiny app

Replace `app.py` with your actual script name if it's different.

```bash
python -m shiny run --reload app.py
```

> The app will start running locally on http://127.0.0.1:<port>.
> Open this link in your browser to interact with the app.


#### OR

Open your vscode and ensure that you have the Shiny extension installed.
Navigate to your shiny app folder and run the code.


---

