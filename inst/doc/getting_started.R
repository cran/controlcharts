## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE-----------------------------------------------------
set.seed(12324)

## ----spc----------------------------------------------------------------------
# Simulate 2 years of monthly data
dat <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  y = rnorm(24)
)

knitr::kable(head(dat))

## ----spc_plot-----------------------------------------------------------------
spc_chart <- controlcharts::spc(data = dat,
                                numerators = y,
                                keys = month)

## ----spc_plot_static----------------------------------------------------------
spc_chart$static_plot

## ----spc_plot_html, eval=FALSE------------------------------------------------
# # If you are using an interactive environment, you can display the HTML widget:
# # spc_chart$html_plot

## ----spc_limits---------------------------------------------------------------
# Display the control limits
knitr::kable(head(spc_chart$limits), digits = 2)

## ----funnel-------------------------------------------------------------------
# Simulate proportion data for 10 organisations
denoms <- sample(100:200, 10)
funnel_data <- data.frame(
  organisation = letters[1:10],
  numerators = rbinom(10, size = denoms, prob = 0.2),
  denominators = denoms
)

knitr::kable(funnel_data)

## ----funnel_plot--------------------------------------------------------------
funnel_chart <- controlcharts::funnel(data = funnel_data,
                                      numerators = numerators,
                                      denominators = denominators,
                                      keys = organisation)

## ----funnel_plot_static-------------------------------------------------------
funnel_chart$static_plot

## ----funnel_plot_limits-------------------------------------------------------
knitr::kable(funnel_chart$limits, digits = 2)

