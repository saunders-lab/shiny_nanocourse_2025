# Shiny Nanocourse 2025

August 4-5, 2025

UT Southwestern Medical Center, Dept. of Bioinformatics

Instructor: Scott Saunders

TAs: Ermis-Ioannis Michail Delopoulos & Sriya Veerapaneni

  This repository contains lecture and code materials for a two day "nanocourse" on developing Shiny apps. The lectures are available as pdfs in `/lectures` . The code examples are in `/code_examples`. Each example starts with the initial state of a Shiny app file with some instructions as comments, for example `# Add input here {...}`. The corresponding solutions to each example are found in `/code_solutions`. The primary language of instruction is R, but Shiny is now also supported in python. So we have translated the R code examples into python - they are stored in `/python`.

**Schedule**
-----------

Day 1: Shiny core concepts

- Lecture 1: Overview
  - *Code exercise:* [L1_hello_github](/code_exercises/L1_hello_github_app.R)
 
- Lecture 2: User Interface (UI)
  - *Code exercise:* [L2_example_1](/code_exercises/L2_example_1_app.R)
  - *Code exercise:* [L2_example_2](/code_exercises/L2_example_2_app.R)

- Lecture 3: Server
  - *Code exercise:* [L3_example_1](/code_exercises/L3_example_app.R)

- Case study: Curve fitting
  - *Code exercise:* [CS_logistic_1](/code_exercises/CS_logistic_app_1.R)
  - *Code exercise:* [CS_logistic_2](/code_exercises/CS_logistic_app_2.R)

Day 2: Shiny extras and deployment

- Lecture 4: Interactive plotting & extras
  - *Code exercise:* [L4_logistic_files](/code_exercises/L4_logistic_files_app.R)
  - *Code demo:* [L4_plotly_ggiraph_demo](/code_exercises/L4_plotly_ggiraph_demo_app.R)

- Lecture 5: Deployment
  - *Code demo:* Deploy to [shinyapps.io](https://www.shinyapps.io/)
  - *Code demo:* [Shinylive_example](/shinylive)
