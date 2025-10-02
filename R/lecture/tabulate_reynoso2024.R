tabulate_reynoso2024_smm <- function(path) {
  tibble(
    par = c(
      "$ w_(1, 2005) = 1.81 $",
      "$ phi_(2005) = 0.59 $",
      "$ eta_(f, 2005) = 66.45 $",
      "$ eta_(m, 2005) = 55.75 $"
    ),
    target = c(
      "Skill premium of college",
      "Female relative earnings",
      "Share of college, females",
      "Share of college, males"
    ),
    `2005` = c(2.02, 0.64, 0.332, 0.318),
    `1960` = c(1.55, 0.45, 0.072, 0.125)
  ) |>
    `colnames<-`(c("Parameter", "Target", "2005", "(1960)")) |>
    tinytable::tt(width = c(0.2, 0.4, 0.1, 0.1)) |>
    tinytable::save_tt(path, overwrite = TRUE)

  return(path)
}
