# ==============================================================================
# BIO2105 - Biostatistics
# Formative Assessment 11: Mixed-Design Repeated Measures ANOVA Using R
# Student Name: Patricia Febrada
# Dataset: rats (nlmm package; Box, 1950)
# ==============================================================================

library(nlmm)
library(tidyverse)
library(rstatix)
library(ggpubr)

data("rats", package = "nlmm")

rats <- rats %>%
  mutate(
    id = factor(id),
    trt = factor(
      trt,
      levels = c(1, 2, 3),
      labels = c("Control", "Thiouracil", "Thyroxin")
    ),
    time = factor(
      time,
      levels = 0:4,
      labels = c("Week 0", "Week 1", "Week 2", "Week 3", "Week 4")
    )
  )

str(rats)
dim(rats)
head(rats)
table(rats$trt)

desc_stats <- rats %>%
  group_by(trt, time) %>%
  get_summary_stats(y, type = "mean_sd")
print(desc_stats, n = Inf)

boxplot_fig <- ggboxplot(
  rats,
  x = "time",
  y = "y",
  color = "trt",
  palette = "jco",
  add = "jitter",
  xlab = "Measurement Occasion",
  ylab = "Body Weight (grams)",
  title = "Distribution of Rat Body Weight Across Weeks by Treatment Group"
) +
  theme_minimal()
print(boxplot_fig)

interaction_fig <- rats %>%
  group_by(trt, time) %>%
  summarise(mean_weight = mean(y), .groups = "drop") %>%
  ggplot(aes(x = time, y = mean_weight, color = trt, group = trt)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2.5) +
  labs(
    title = "Mean Body Weight Trajectories Over Time by Treatment Group",
    x = "Measurement Occasion",
    y = "Mean Body Weight (grams)",
    color = "Treatment"
  ) +
  theme_minimal()
print(interaction_fig)

shapiro_res <- rats %>%
  group_by(trt, time) %>%
  shapiro_test(y)
print(shapiro_res, n = Inf)

qq_fig <- ggqqplot(rats, x = "y", ggtheme = theme_minimal()) +
  facet_grid(time ~ trt) +
  labs(title = "Normal Q-Q Plots by Treatment Group and Measurement Occasion")
print(qq_fig)

outliers_res <- rats %>%
  group_by(trt, time) %>%
  identify_outliers(y)
print(outliers_res, n = Inf)

levene_res <- rats %>%
  group_by(time) %>%
  levene_test(y ~ trt)
print(levene_res)

rats_wide <- rats %>%
  pivot_wider(
    id_cols = c(id, trt),
    names_from = time,
    values_from = y,
    names_prefix = "time_"
  )

boxm_res <- box_m(
  rats_wide %>% select(starts_with("time_")),
  rats_wide$trt
)
print(boxm_res)

res.aov <- anova_test(
  data = rats,
  dv = y,
  wid = id,
  between = trt,
  within = time
)
print(res.aov)

anova_table <- get_anova_table(res.aov)
print(anova_table)

simple_trt <- rats %>%
  group_by(time) %>%
  anova_test(dv = y, wid = id, between = trt) %>%
  get_anova_table()
print(simple_trt)

tukey_trt <- rats %>%
  group_by(time) %>%
  tukey_hsd(y ~ trt)
print(tukey_trt, n = Inf)

simple_time <- rats %>%
  group_by(trt) %>%
  anova_test(dv = y, wid = id, within = time) %>%
  get_anova_table()
print(simple_time)

holm_time <- rats %>%
  group_by(trt) %>%
  pairwise_t_test(
    y ~ time,
    paired = TRUE,
    p.adjust.method = "holm"
  )
print(holm_time, n = Inf)
