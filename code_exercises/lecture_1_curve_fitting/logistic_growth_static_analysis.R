# Logistic growth curve fit

# Load packages
library(tidyverse)
library(modelr)

#### Code for App #1 below
# -------------------------

# Write a function to generate logistic curve data with noise
gen_logis <- function(input, Asym = 100, xmid = 12, scal = 3, noise_sd = 5){
  
  # Calcululate logistic curve for inputs from defined parameters
  vals <- Asym/(1+exp((xmid-input)/scal))
  
  # Add gaussian noise with fixed sd
  noisy_vals <- rnorm(n = length(input), mean = vals, sd = noise_sd)
  
  return(noisy_vals)
  
}

# Example: generate a logistic curve with the default values Asymptote = 100, xmid = 12, scale = 3 and noise = 5
# Input is 24 (e.g. 24 hrs)
gen_logis(input = 1:24)

# Generate a noisy logistic dataset in a dataframe (i.e. tibble) with two columns, hrs and cells
# Cells divide and therefore grow exponentially, described well by logistic function
df_cells <- tibble(hrs = 1:24) %>% 
  mutate(cells = gen_logis(hrs))

df_cells

# Plot logistic growth of mock cells
ggplot(df_cells, aes(x = hrs, y = cells)) + 
  geom_point()


#### Code for App #2 below
# -------------------------

# Using nonlinear least squares (nls), fit a self starting logistic model to the data (SSlogis)
mod_logis <- nls(formula = cells~SSlogis(input = hrs, Asym, xmid, scal), data = df_cells)

# Examine parameter estimates and model fit
summary(mod_logis)


# Add best fit predictions of logistic model to original data
df_cells_pred <- df_cells %>% 
  add_predictions(mod_logis)

df_cells_pred

# Plot original data alongside predictions
ggplot(df_cells_pred, aes(x = hrs)) + 
  geom_point(aes(y = cells)) + 
  geom_line(aes(y = pred), color = 'blue', size = 1)

