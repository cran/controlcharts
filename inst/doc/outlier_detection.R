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

## ----astronomical_data--------------------------------------------------------
# Create data with some extreme outliers
dat_astro <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  infections = c(rnorm(10, mean = 15, sd = 3),
                 28,  # Astronomical point
                 rnorm(5, mean = 15, sd = 3),
                 6,   # Astronomical point
                 rnorm(7, mean = 15, sd = 3))
)

## ----astronomical_chart-------------------------------------------------------
chart_astro <- spc(data = dat_astro,
                   keys = month,
                   numerators = infections,
                   spc_settings = list(chart_type = "i"),
                   outlier_settings = list(
                     astronomical = TRUE,
                     astronomical_limit = "3 Sigma"
                   ))

chart_astro$static_plot

## ----astronomical_limits------------------------------------------------------
knitr::kable(chart_astro$limits[9:14, ], digits = 2)

## ----astronomical_2sigma------------------------------------------------------
chart_astro_2s <- spc(data = dat_astro,
                      keys = month,
                      numerators = infections,
                      spc_settings = list(chart_type = "i"),
                      outlier_settings = list(
                        astronomical = TRUE,
                        astronomical_limit = "2 Sigma"
                      ))

chart_astro_2s$static_plot

## ----shift_data---------------------------------------------------------------
# Create data with a 6-point shift at the end
dat_shift <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  satisfaction = c(rnorm(18, mean = 75, sd = 5),  # Baseline
                   rnorm(6, mean = 82, sd = 5))   # 6-point shift at end
)

## ----shift_default------------------------------------------------------------
chart_shift <- spc(data = dat_shift,
                   keys = month,
                   numerators = satisfaction,
                   spc_settings = list(chart_type = "i"),
                   outlier_settings = list(
                     shift = TRUE
                   ))

chart_shift$static_plot

## ----shift_limits-------------------------------------------------------------
knitr::kable(tail(chart_shift$limits, 10), digits = 2)

## ----shift_custom-------------------------------------------------------------
chart_shift_6 <- spc(data = dat_shift,
                     keys = month,
                     numerators = satisfaction,
                     spc_settings = list(chart_type = "i"),
                     outlier_settings = list(
                       shift = TRUE,
                       shift_n = 6
                     ))

chart_shift_6$static_plot

## ----trend_data---------------------------------------------------------------
# Create data with a 4-point upward trend at the end
dat_trend <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  wait_time = c(rnorm(20, mean = 30, sd = 3),
                31, 33, 35, 37)  # 4-point increasing trend at end
)

## ----trend_default------------------------------------------------------------
chart_trend <- spc(data = dat_trend,
                   keys = month,
                   numerators = wait_time,
                   spc_settings = list(chart_type = "i"),
                   outlier_settings = list(
                     trend = TRUE
                   ))

chart_trend$static_plot

## ----trend_limits-------------------------------------------------------------
knitr::kable(tail(chart_trend$limits, 10), digits = 2)

## ----trend_custom-------------------------------------------------------------
chart_trend_4 <- spc(data = dat_trend,
                     keys = month,
                     numerators = wait_time,
                     spc_settings = list(chart_type = "i"),
                     outlier_settings = list(
                       trend = TRUE,
                       trend_n = 4
                     ))

chart_trend_4$static_plot

## ----two_in_three_data--------------------------------------------------------
# Create data with 2-in-3 pattern
# With mean=120 and sd=5, 2-sigma limits are approximately 120 ± 10
# So values above 130 or below 110 should exceed 2-sigma
dat_2in3 <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  pressure = c(rnorm(8, mean = 120, sd = 5),
               131, 133, 121,  # 2 out of 3 outside 2-sigma (131 and 133 > 130)
               rnorm(13, mean = 120, sd = 5))
)

## ----two_in_three_basic-------------------------------------------------------
chart_2in3 <- spc(data = dat_2in3,
                  keys = month,
                  numerators = pressure,
                  spc_settings = list(chart_type = "i"),
                  outlier_settings = list(
                    two_in_three = TRUE,
                    two_in_three_limit = "2 Sigma"
                  ))

chart_2in3$static_plot

## ----two_in_three_limits------------------------------------------------------
knitr::kable(head(chart_2in3$limits, 12), digits = 2)

## ----two_in_three_highlight_all-----------------------------------------------
chart_2in3_all <- spc(data = dat_2in3,
                      keys = month,
                      numerators = pressure,
                      spc_settings = list(chart_type = "i"),
                      outlier_settings = list(
                        two_in_three = TRUE,
                        two_in_three_limit = "2 Sigma",
                        two_in_three_highlight_series = TRUE
                      ))

chart_2in3_all$static_plot

## ----improvement_decrease-----------------------------------------------------
# For metrics where lower is better (e.g., infection rates)
dat_infections <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  infections = c(rnorm(16, mean = 10, sd = 1),
                 rnorm(8, mean = 5, sd = 1))  # Improvement (decrease shift)
)

chart_inf <- spc(data = dat_infections,
                 keys = month,
                 numerators = infections,
                 spc_settings = list(chart_type = "i"),
                 outlier_settings = list(
                   shift = TRUE,
                   improvement_direction = "decrease"
                 ))

chart_inf$static_plot

## ----improvement_increase-----------------------------------------------------
# For metrics where higher is better (e.g., hand hygiene compliance)
dat_compliance <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  compliance = c(rnorm(12, mean = 75, sd = 5),
                 rnorm(12, mean = 85, sd = 5))  # Improvement (increase)
)

chart_comp <- spc(data = dat_compliance,
                  keys = month,
                  numerators = compliance,
                  spc_settings = list(chart_type = "i"),
                  outlier_settings = list(
                    shift = TRUE,
                    improvement_direction = "increase"
                  ))

chart_comp$static_plot

## ----flag_type_data-----------------------------------------------------------
# Data with both improvement and deterioration
dat_flag_type <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  infections = c(rnorm(5, mean = 8, sd = 1.5),
                 rnorm(8, mean = 5, sd = 1.5),   # Improvement (decrease)
                 rnorm(11, mean = 10, sd = 1.5))  # Deterioration (increase)
)

## ----flag_both----------------------------------------------------------------
chart_both <- spc(data = dat_flag_type,
                  keys = month,
                  numerators = infections,
                  spc_settings = list(chart_type = "i"),
                  outlier_settings = list(
                    shift = TRUE,
                    improvement_direction = "decrease",
                    process_flag_type = "both"
                  ))

chart_both$static_plot

## ----flag_deterioration_only--------------------------------------------------
chart_det_only <- spc(data = dat_flag_type,
                      keys = month,
                      numerators = infections,
                      spc_settings = list(chart_type = "i"),
                      outlier_settings = list(
                        shift = TRUE,
                        improvement_direction = "decrease",
                        process_flag_type = "deterioration"
                      ))

chart_det_only$static_plot

## ----variation_icons_last_point-----------------------------------------------
# Data with shift ending at the last point
dat_var_last <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  readmissions = c(rnorm(10, mean = 12, sd = 2),
                   rnorm(14, mean = 16, sd = 2))  # Shift at end
)

chart_var_last <- spc(data = dat_var_last,
                      keys = month,
                      numerators = readmissions,
                      spc_settings = list(chart_type = "i"),
                      outlier_settings = list(
                        astronomical = TRUE,
                        shift = TRUE,
                        improvement_direction = "decrease"
                      ),
                      nhs_icon_settings = list(
                        show_variation_icons = TRUE,
                        flag_last_point = TRUE,
                        variation_icons_locations = "Top Right"
                      ))

chart_var_last$static_plot

## ----variation_icons_no_display-----------------------------------------------
# Data with shift in the middle, not at the end
dat_var_middle <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  readmissions = c(rnorm(8, mean = 12, sd = 2),
                   rnorm(8, mean = 16, sd = 2),  # Shift in middle
                   rnorm(8, mean = 12, sd = 2))  # Back to baseline
)

chart_var_middle <- spc(data = dat_var_middle,
                        keys = month,
                        numerators = readmissions,
                        spc_settings = list(chart_type = "i"),
                        outlier_settings = list(
                          astronomical = TRUE,
                          shift = TRUE,
                          improvement_direction = "decrease"
                        ),
                        nhs_icon_settings = list(
                          show_variation_icons = TRUE,
                          flag_last_point = TRUE,
                          variation_icons_locations = "Top Right"
                        ))

chart_var_middle$static_plot

## ----variation_icons_all_points-----------------------------------------------
chart_var_all <- spc(data = dat_var_middle,
                     keys = month,
                     numerators = readmissions,
                     spc_settings = list(chart_type = "i"),
                     outlier_settings = list(
                       astronomical = TRUE,
                       shift = TRUE,
                       improvement_direction = "decrease"
                     ),
                     nhs_icon_settings = list(
                       show_variation_icons = TRUE,
                       flag_last_point = FALSE,
                       variation_icons_locations = "Top Right"
                     ))

chart_var_all$static_plot

## ----variation_icons_placement------------------------------------------------
chart_var_bl <- spc(data = dat_var_last,
                    keys = month,
                    numerators = readmissions,
                    spc_settings = list(chart_type = "i"),
                    outlier_settings = list(
                      astronomical = TRUE,
                      shift = TRUE,
                      improvement_direction = "decrease"
                    ),
                    nhs_icon_settings = list(
                      show_variation_icons = TRUE,
                      variation_icons_locations = "Bottom Left",
                      variation_icons_scaling = 1.2
                    ))

chart_var_bl$static_plot

## ----assurance_pass-----------------------------------------------------------
# Process centered around 95%, target at 90% will be below lower 99% limit
dat_assurance_pass <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  vaccination_rate = rnorm(24, mean = 95, sd = 1)
)

chart_assurance_pass <- spc(data = dat_assurance_pass,
                            keys = month,
                            numerators = vaccination_rate,
                            spc_settings = list(chart_type = "i"),
                            nhs_icon_settings = list(
                              show_assurance_icons = TRUE,
                              assurance_icons_locations = "Top Right"
                            ),
                            line_settings = list(
                              show_alt_target = TRUE,
                              alt_target = 90,
                              colour_alt_target = "#E69F00"
                            ))

chart_assurance_pass$static_plot

## ----assurance_pass_limits----------------------------------------------------
knitr::kable(tail(chart_assurance_pass$limits, 6), digits = 2)

## ----assurance_fail-----------------------------------------------------------
# Process centered around 82%, target at 90% will be above upper 99% limit
dat_assurance_fail <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  vaccination_rate = rnorm(24, mean = 82, sd = 1.5)
)

chart_assurance_fail <- spc(data = dat_assurance_fail,
                            keys = month,
                            numerators = vaccination_rate,
                            spc_settings = list(chart_type = "i"),
                            nhs_icon_settings = list(
                              show_assurance_icons = TRUE,
                              assurance_icons_locations = "Top Right"
                            ),
                            line_settings = list(
                              show_alt_target = TRUE,
                              alt_target = 90,
                              colour_alt_target = "#E69F00"
                            ))

chart_assurance_fail$static_plot

## ----assurance_fail_limits----------------------------------------------------
knitr::kable(tail(chart_assurance_fail$limits, 6), digits = 2)

## ----assurance_variable-------------------------------------------------------
# Process centered around 90%, target at 90% will be within limits
dat_assurance_variable <- data.frame(
  month = seq(as.Date("2024-01-01"), length.out = 24, by = "month"),
  vaccination_rate = rnorm(24, mean = 90, sd = 2)
)

chart_assurance_variable <- spc(data = dat_assurance_variable,
                                keys = month,
                                numerators = vaccination_rate,
                                spc_settings = list(chart_type = "i"),
                                nhs_icon_settings = list(
                                  show_assurance_icons = TRUE,
                                  assurance_icons_locations = "Top Right"
                                ),
                                line_settings = list(
                                  show_alt_target = TRUE,
                                  alt_target = 90,
                                  colour_alt_target = "#E69F00"
                                ))

chart_assurance_variable$static_plot

## ----assurance_variable_limits------------------------------------------------
knitr::kable(tail(chart_assurance_variable$limits, 6), digits = 2)

## ----combined_icons-----------------------------------------------------------
chart_both_icons <- spc(data = dat_assurance_pass,
                        keys = month,
                        numerators = vaccination_rate,
                        spc_settings = list(chart_type = "i"),
                        outlier_settings = list(
                          astronomical = TRUE,
                          shift = TRUE,
                          trend = TRUE,
                          improvement_direction = "increase"
                        ),
                        nhs_icon_settings = list(
                          show_variation_icons = TRUE,
                          show_assurance_icons = TRUE
                        ),
                        line_settings = list(
                          show_alt_target = TRUE,
                          alt_target = 90,
                          colour_alt_target = "#E69F00"
                        ))

chart_both_icons$static_plot

