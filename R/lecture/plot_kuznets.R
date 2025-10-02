plot_tfr <- function(data, path) {
  ggplot(data, aes(x = PERIOD, y = JPN)) +
    geom_line() +
    labs(x = NULL, y = NULL, caption = "Data: Human Fertility Database") +
    theme_proj(size = 20) +
    theme(panel.grid.major.x = element_blank())

  ggsave(path, width = 6, height = 3.708)

  return(path)
}

plot_ccf <- function(data, path) {
  ggplot(data, aes(x = COHORT, y = JPN)) +
    geom_line() +
    labs(
      x = "Birth Cohort",
      y = NULL,
      caption = "Data: Human Fertility Database"
    ) +
    theme_proj(size = 20) +
    theme(panel.grid.major.x = element_blank())

  ggsave(path, width = 6, height = 3.708)

  return(path)
}

plot_share_nmarried <- function(data, path) {
  share_nmarried <- data |>
    mutate(is_nmarried = marriage4 == "Never-married") |>
    filter(age_bin5 %in% c("45-49", "50-54")) |>
    summarize(
      share_nmarried = weighted.mean(is_nmarried, n),
      .by = c(gender, year)
    ) |>
    arrange(year, gender)

  share_nmarried |>
    filter(year >= 1980) |>
    ggplot(aes(x = year, y = share_nmarried, color = gender, shape = gender)) +
    geom_point(size = 3) +
    geom_line() +
    scale_y_continuous(labels = scales::percent) +
    scale_color_manual(values = c(color_base, color_accent)) +
    coord_cartesian(ylim = c(0.0, NA)) +
    labs(
      x = NULL,
      y = NULL,
      caption = "Data: Japanese Census"
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


plot_age_firstmarriage <- function(data, path) {
  data |>
    filter(!is.na(age)) |>
    ggplot(aes(x = year, y = age, color = gender, shape = gender)) +
    geom_point(size = 3) +
    geom_path() +
    scale_color_manual(values = c(color_base, color_accent)) +
    labs(x = NULL, y = NULL, caption = "Data: World Bank") +
    theme_proj(size = 20) +
    theme(
      panel.grid.major.x = element_blank(),
      legend.position = "inside",
      legend.position.inside = c(0.9, 0.15)
    )
  ggsave(path, width = 6, height = 3.708)
  return(path)
}

plot_hhsize <- function(data, path) {
  ggplot(data, aes(x = year, y = hhsize)) +
    geom_point() +
    geom_line() +
    labs(x = NULL, y = NULL, caption = "Data: Japanese Census") +
    theme_proj(size = 20) +
    theme(panel.grid.major.x = element_blank())
  ggsave(path, width = 6, height = 3.708)
  return(path)
}
