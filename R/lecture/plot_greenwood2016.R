plot_greenwood2016_educ <- function(path) {
  data <- tibble(
    gender = rep(c("Women", "Men"), 4),
    lbl = rep(
      factor(
        c(
          "Benchmark (1960)",
          "Benchmark (2005)",
          "Fix p (2005)",
          "Fix w & φ (2005)"
        ),
        levels = c(
          "Benchmark (1960)",
          "Fix p (2005)",
          "Fix w & φ (2005)",
          "Benchmark (2005)"
        )
      ),
      each = 2
    ),
    value = c(0.074, 0.129, 0.334, 0.317, 0.275, 0.348, 0.220, 0.194)
  )
  ggplot(data, aes(x = lbl, y = value, fill = gender, alpha = lbl)) +
    geom_col(position = "dodge") +
    facet_wrap(~gender) +
    scale_y_continuous(labels = scales::percent) +
    scale_fill_manual(values = c(color_base, color_accent2)) +
    scale_alpha_manual(
      values = c(1.0, 0.7, 0.7, 1.0),
    ) +
    labs(
      x = NULL,
      y = NULL,
      title = "Share of College-educated",
      caption = "Made by Yanagimoto from Table 6-8 in Greenwood et al. (2016)"
    ) +
    theme_proj(size = 20) +
    theme(
      panel.grid.major.x = element_blank(),
      legend.position = "none",
      axis.text.x = element_text(size = 12)
    )
  ggsave(path, width = 12, height = 3.708)
  return(path)
}

plot_greenwood2016_single <- function(path) {
  data <- tibble(
    lbl = factor(
      c(
        "Benchmark (1960)",
        "Benchmark (2005)",
        "Fix p (2005)",
        "Fix w and φ (2005)"
      ),
      levels = c(
        "Benchmark (1960)",
        "Fix p (2005)",
        "Fix w and φ (2005)",
        "Benchmark (2005)"
      )
    ),
    value = c(0.151, 0.284, 0.221, 0.255)
  )

  ggplot(data, aes(x = lbl, y = value, alpha = lbl)) +
    geom_col(position = "dodge", fill = color_base) +
    scale_y_continuous(labels = scales::percent) +
    scale_fill_manual(values = c(color_base, color_accent2)) +
    scale_alpha_manual(
      values = c(1.0, 0.7, 0.7, 1.0),
    ) +
    labs(
      x = NULL,
      y = NULL,
      caption = "Made by Yanagimoto from Table 6-8 in Greenwood et al. (2016)"
    ) +
    theme_proj(size = 20) +
    theme(
      panel.grid.major.x = element_blank(),
      legend.position = "none",
      axis.text.x = element_text(size = 12)
    )
  ggsave(path, width = 6, height = 3.708)
  return(path)
}

plot_greenwood2016_particip <- function(path) {
  data <- tibble(
    lbl = factor(
      c(
        "Benchmark (1960)",
        "Benchmark (2005)",
        "Fix p (2005)",
        "Fix w and φ (2005)"
      ),
      levels = c(
        "Benchmark (1960)",
        "Fix p (2005)",
        "Fix w and φ (2005)",
        "Benchmark (2005)"
      )
    ),
    value = c(0.315, 0.745, 0.262, 0.640)
  )

  ggplot(data, aes(x = lbl, y = value, alpha = lbl)) +
    geom_col(position = "dodge", fill = color_accent) +
    scale_y_continuous(labels = scales::percent) +
    scale_alpha_manual(
      values = c(1.0, 0.7, 0.7, 1.0),
    ) +
    labs(
      x = NULL,
      y = NULL,
      caption = "Made by Yanagimoto from Table 6-8 in Greenwood et al. (2016)"
    ) +
    theme_proj(size = 20) +
    theme(
      panel.grid.major.x = element_blank(),
      legend.position = "none",
      axis.text.x = element_text(size = 12)
    )
  ggsave(path, width = 6, height = 3.708)
  return(path)
}

plot_greenwood2016_corr <- function(path) {
  data <- tibble(
    lbl = factor(
      c(
        "Benchmark (1960)",
        "Benchmark (2005)",
        "Fix p (2005)",
        "Fix w and φ (2005)"
      ),
      levels = c(
        "Benchmark (1960)",
        "Fix p (2005)",
        "Fix w and φ (2005)",
        "Benchmark (2005)"
      )
    ),
    value = c(0.403, 0.526, 0.441, 0.356)
  )
  ggplot(data, aes(x = lbl, y = value, alpha = lbl)) +
    geom_col(position = "dodge", fill = color_base) +
    scale_y_continuous(labels = scales::percent) +
    scale_alpha_manual(
      values = c(1.0, 0.7, 0.7, 1.0),
    ) +
    labs(
      x = NULL,
      y = NULL,
      caption = "Made by Yanagimoto from Table 6-8 in Greenwood et al. (2016)"
    ) +
    theme_proj(size = 20) +
    theme(
      panel.grid.major.x = element_blank(),
      legend.position = "none",
      axis.text.x = element_text(size = 12)
    )
  ggsave(path, width = 6, height = 3.708)
  return(path)
}

plot_greenwood2016_gini <- function(path) {
  data <- tibble(
    lbl = factor(
      c(
        "Benchmark (1960)",
        "Benchmark (2005)",
        "Fix p (2005)",
        "Fix w and φ (2005)"
      ),
      levels = c(
        "Benchmark (1960)",
        "Fix p (2005)",
        "Fix w and φ (2005)",
        "Benchmark (2005)"
      )
    ),
    value = c(0.307, 0.366, 0.366, 0.333)
  )

  ggplot(data, aes(x = lbl, y = value, alpha = lbl)) +
    geom_col(position = "dodge", fill = color_accent) +
    scale_y_continuous(labels = scales::percent) +
    scale_alpha_manual(
      values = c(1.0, 0.7, 0.7, 1.0),
    ) +
    labs(
      x = NULL,
      y = NULL,
      caption = "Made by Yanagimoto from Table 6-8 in Greenwood et al. (2016)"
    ) +
    theme_proj(size = 20) +
    theme(
      panel.grid.major.x = element_blank(),
      legend.position = "none",
      axis.text.x = element_text(size = 12)
    )
  ggsave(path, width = 6, height = 3.708)
  return(path)
}
