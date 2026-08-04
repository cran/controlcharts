## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5
)

## ----setup, include=FALSE-----------------------------------------------------
set.seed(12324)
library(controlcharts)

## ----run_chart----------------------------------------------------------------
# Simulate 24 months of data
dat_run <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  y = rnorm(24, mean = 100, sd = 10)
)

chart_run <- spc(data = dat_run,
                 keys = month,
                 numerators = y,
                 spc_settings = list(chart_type = "run"))

chart_run$static_plot

## ----run_limits---------------------------------------------------------------
knitr::kable(head(chart_run$limits), digits = 2)

## ----i_chart------------------------------------------------------------------
dat_i <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  y = rnorm(24, mean = 50, sd = 5)
)

chart_i <- spc(data = dat_i,
               keys = month,
               numerators = y,
               spc_settings = list(chart_type = "i"))

chart_i$static_plot

## ----i_limits-----------------------------------------------------------------
knitr::kable(head(chart_i$limits), digits = 2)

## ----i_ratio------------------------------------------------------------------
# Example: monitoring average processing time per case
dat_ratio <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  total_time = rpois(24, lambda = 120),
  num_cases = rpois(24, lambda = 25)
)

chart_ratio <- spc(data = dat_ratio,
                   keys = month,
                   numerators = total_time,
                   denominators = num_cases,
                   spc_settings = list(chart_type = "i"))

chart_ratio$static_plot

## ----i_ratio_limits-----------------------------------------------------------
knitr::kable(head(chart_ratio$limits), digits = 2)

## ----im_chart-----------------------------------------------------------------
dat_im <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  y = c(rnorm(20, mean = 50, sd = 5), 75, 78, 72, 71)  # Some outliers
)

chart_im <- spc(data = dat_im,
                keys = month,
                numerators = y,
                spc_settings = list(chart_type = "i_m"))

chart_im$static_plot

## ----imm_chart----------------------------------------------------------------
chart_imm <- spc(data = dat_im,
                 keys = month,
                 numerators = y,
                 spc_settings = list(chart_type = "i_mm"))

chart_imm$static_plot

## ----mr_chart-----------------------------------------------------------------
dat_mr <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  y = rnorm(24, mean = 10, sd = 2)
)

chart_mr <- spc(data = dat_mr,
                keys = month,
                numerators = y,
                spc_settings = list(chart_type = "mr"))

chart_mr$static_plot

## ----p_chart------------------------------------------------------------------
dat_p <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  denominator = sample(80:120, 24, replace = TRUE)
)
dat_p$numerator <- rbinom(24, size = dat_p$denominator, prob = 0.15)

chart_p <- spc(data = dat_p,
               keys = month,
               numerators = numerator,
               denominators = denominator,
               spc_settings = list(chart_type = "p"))

chart_p$static_plot

## ----p_limits-----------------------------------------------------------------
knitr::kable(head(chart_p$limits), digits = 3)

## ----pp_chart-----------------------------------------------------------------
chart_pp <- spc(data = dat_p,
                keys = month,
                numerators = numerator,
                denominators = denominator,
                spc_settings = list(chart_type = "pp"))

chart_pp$static_plot

## ----u_chart------------------------------------------------------------------
dat_u <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  infections = rpois(24, lambda = 8),
  patient_days = sample(200:400, 24, replace = TRUE)
)

chart_u <- spc(data = dat_u,
               keys = month,
               numerators = infections,
               denominators = patient_days,
               spc_settings = list(chart_type = "u", multiplier = 1000))

chart_u$static_plot

## ----u_limits-----------------------------------------------------------------
knitr::kable(head(chart_u$limits), digits = 2)

## ----up_chart-----------------------------------------------------------------
chart_up <- spc(data = dat_u,
                keys = month,
                numerators = infections,
                denominators = patient_days,
                spc_settings = list(chart_type = "up", multiplier = 1000))

chart_up$static_plot

## ----c_chart------------------------------------------------------------------
dat_c <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  defects = rpois(24, lambda = 12)
)

chart_c <- spc(data = dat_c,
               keys = month,
               numerators = defects,
               spc_settings = list(chart_type = "c"))

chart_c$static_plot

## ----c_limits-----------------------------------------------------------------
knitr::kable(head(chart_c$limits), digits = 2)

## ----xbar_chart---------------------------------------------------------------
dat_xbar <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  sample_mean = rnorm(24, mean = 100, sd = 3),
  sample_size = rep(5, 24),
  sample_sd = rchisq(24, df = 4) / 2
)

chart_xbar <- spc(data = dat_xbar,
                  keys = month,
                  numerators = sample_mean,
                  denominators = sample_size,
                  xbar_sds = sample_sd,
                  spc_settings = list(chart_type = "xbar"))

chart_xbar$static_plot

## ----xbar_limits--------------------------------------------------------------
knitr::kable(head(chart_xbar$limits), digits = 2)

## ----s_chart------------------------------------------------------------------
chart_s <- spc(data = dat_xbar,
               keys = month,
               numerators = sample_sd,
               denominators = sample_size,
               spc_settings = list(chart_type = "s"))

chart_s$static_plot

## ----g_chart------------------------------------------------------------------
dat_g <- data.frame(
  event = 1:20,
  opportunities_between = rpois(20, lambda = 15)
)

chart_g <- spc(data = dat_g,
               keys = event,
               numerators = opportunities_between,
               spc_settings = list(chart_type = "g"))

chart_g$static_plot

## ----g_limits-----------------------------------------------------------------
knitr::kable(head(chart_g$limits), digits = 2)

## ----t_chart------------------------------------------------------------------
dat_t <- data.frame(
  event = 1:20,
  days_between = rexp(20, rate = 1 / 30)
)

chart_t <- spc(data = dat_t,
               keys = event,
               numerators = days_between,
               spc_settings = list(chart_type = "t"))

chart_t$static_plot

## ----t_limits-----------------------------------------------------------------
knitr::kable(head(chart_t$limits), digits = 2)

## ----pr_funnel----------------------------------------------------------------
# Simulate complication rates across 10 hospitals
denoms_pr <- sample(100:300, 10)
dat_pr <- data.frame(
  hospital = paste0("Hospital ", LETTERS[1:10]),
  complications = rbinom(10, size = denoms_pr, prob = 0.12),
  procedures = denoms_pr
)

funnel_pr <- funnel(data = dat_pr,
                    keys = hospital,
                    numerators = complications,
                    denominators = procedures,
                    funnel_settings = list(chart_type = "PR"))

funnel_pr$static_plot

## ----pr_limits----------------------------------------------------------------
knitr::kable(funnel_pr$limits, digits = 3)

## ----pr_od_funnel-------------------------------------------------------------
funnel_pr_od <- funnel(data = dat_pr,
                       keys = hospital,
                       numerators = complications,
                       denominators = procedures,
                       funnel_settings = list(chart_type = "PR",
                                              od_adjust = "yes"))

funnel_pr_od$static_plot

## ----pr_od_limits-------------------------------------------------------------
knitr::kable(funnel_pr_od$limits, digits = 3)

## ----sr_funnel----------------------------------------------------------------
# Simulate observed and expected deaths
dat_sr <- data.frame(
  hospital = paste0("Hospital ", LETTERS[1:10]),
  observed_deaths = rpois(10, lambda = sample(30:80, 10)),
  expected_deaths = sample(30:80, 10)
)

funnel_sr <- funnel(data = dat_sr,
                    keys = hospital,
                    numerators = observed_deaths,
                    denominators = expected_deaths,
                    funnel_settings = list(chart_type = "SR"))

funnel_sr$static_plot

## ----sr_limits----------------------------------------------------------------
knitr::kable(funnel_sr$limits, digits = 3)

## ----sr_od_funnel-------------------------------------------------------------
funnel_sr_od <- funnel(data = dat_sr,
                       keys = hospital,
                       numerators = observed_deaths,
                       denominators = expected_deaths,
                       funnel_settings = list(chart_type = "SR",
                                              od_adjust = "yes"))

funnel_sr_od$static_plot

## ----sr_od_limits-------------------------------------------------------------
knitr::kable(funnel_sr_od$limits, digits = 3)

## ----rc_funnel----------------------------------------------------------------
# Simulate infection rates across hospitals
dat_rc <- data.frame(
  hospital = paste0("Hospital ", LETTERS[1:10]),
  infections = rpois(10, lambda = sample(5:20, 10)),
  patient_days = sample(500:2000, 10)
)

funnel_rc <- funnel(data = dat_rc,
                    keys = hospital,
                    numerators = infections,
                    denominators = patient_days,
                    funnel_settings = list(chart_type = "RC",
                                           multiplier = 1000))

funnel_rc$static_plot

## ----rc_limits----------------------------------------------------------------
knitr::kable(funnel_rc$limits, digits = 3)

## ----rc_od_funnel-------------------------------------------------------------
funnel_rc_od <- funnel(data = dat_rc,
                       keys = hospital,
                       numerators = infections,
                       denominators = patient_days,
                       funnel_settings = list(chart_type = "RC",
                                              od_adjust = "yes",
                                              multiplier = 1000))

funnel_rc_od$static_plot

## ----rc_od_limits-------------------------------------------------------------
knitr::kable(funnel_rc_od$limits, digits = 3)

