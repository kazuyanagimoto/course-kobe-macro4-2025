plot_adda2017_wage <- function(path) {
  years = seq(0, 12, by = 0.5)
  tibble(
    occ3 = rep(c("Routine", "Abstract", "Manual"), each = length(years)),
    year = rep(years, 3),
  ) |>
    mutate(
      occ3 = factor(occ3, levels = c("Routine", "Abstract", "Manual")),
      lwage = case_when(
        occ3 == "Routine" ~ 3.39 + 0.1 * year - 0.00382 * year^2,
        occ3 == "Abstract" ~ 3.6 + 0.09 * year - 0.0021 * year^2,
        occ3 == "Manual" ~ 3.32 + 0.123 * year - 0.00463 * year^2,
        .default = NA_real_
      ),
      wage = exp(lwage)
    ) |>
    ggplot(aes(x = year, y = lwage, color = occ3, linetype = occ3)) +
    geom_line(linewidth = 1.5) +
    scale_color_manual(values = c(color_base, color_accent, color_accent2)) +
    labs(
      x = "Years of Experience",
      y = "Log Wage"
    ) +
    theme_proj(size = 20) +
    theme(
      panel.grid.major.x = element_blank(),
      legend.position = "inside",
      legend.position.inside = c(0.9, 0.15)
    )

  ggsave(path, width = 6, height = 3.708)
  return(path)
}
