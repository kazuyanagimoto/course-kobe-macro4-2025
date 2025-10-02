lecture <- tar_plan(
  # Foundations ----------------------------------------------------------------
  ## Kuznet's facts
  tar_map(
    values = tibble(
      name = c("tfr", "ccf", "share_nmarried", "age_firstmarriage", "hhsize"),
      obj = syms(c(
        "hfd_tfr",
        "hfd_ccf",
        "pop_marriage",
        "age_firstmarriage",
        "hhsize"
      ))
    ) |>
      mutate(
        fn = syms(paste0("plot_", name)),
        path = here_rel("static", "img", "lecture", paste0(name, ".svg"))
      ),
    names = name,
    tar_file(
      fig,
      fn(obj, path)
    )
  ),
  # Marriage -------------------------------------------------------------------
  ## Greenwood et al. (2016)
  tar_map(
    values = tibble(name = c("educ", "single", "particip", "corr", "gini")) |>
      mutate(
        fn = syms(paste0("plot_greenwood2016_", name)),
        path = here_rel(
          "static",
          "img",
          "lecture",
          paste0("greenwood2016_", name, ".svg")
        )
      ),
    names = name,
    tar_file(fig, fn(path))
  ),
  table_reynoso2024_smm = tabulate_reynoso2024_smm(here_rel(
    "static",
    "table",
    "reynoso2024_smm.typ"
  )),
  # Fertility ------------------------------------------------------------------
  fig_fertility_outsource = plot_fertility_outsource(here_rel(
    "static",
    "img",
    "lecture",
    "fertility_outsource.svg"
  )),
  ## Adda et al. (2017)
  fig_adda2017_wage = plot_adda2017_wage(here_rel(
    "static",
    "img",
    "lecture",
    "adda2017_wage.svg"
  ))
)
