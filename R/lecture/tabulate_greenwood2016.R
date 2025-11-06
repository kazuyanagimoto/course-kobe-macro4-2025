tabulate_greenwood2016_smm <- function(path) {
  tibble(
    par = c(
      "$ w_(1) $",
      "$ phi.alt $",
      "$ eta_(f) $",
      "$ eta_(m) $"
    ),
    par2005 = c(1.81, 0.59, 66.45, 55.75),
    par1960 = c(1.04, 0.40, 134.97, 69.86),
    target = c(
      "Skill premium of college",
      "Female relative earnings",
      "Share of college, females",
      "Share of college, males"
    ),
    `2005` = c(2.02, 0.64, 0.332, 0.318),
    `1960` = c(1.55, 0.45, 0.072, 0.125)
  ) |>
    `colnames<-`(c("", "2005", "(1960)", "Target", "2005", "(1960)")) |>
    tinytable::tt(width = c(0.1, 0.1, 0.1, 0.3, 0.1, 0.1)) |>
    tinytable::group_tt(j = list("Parameter" = 2:3, "Data Target" = 5:6)) |>
    tinytable::save_tt(path, overwrite = TRUE)

  return(path)
}
