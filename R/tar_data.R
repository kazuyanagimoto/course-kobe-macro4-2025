data <- tar_plan(
  # Human Fertility Database ---------------------------------------------------
  tar_map(
    values = list(
      name = c("ccf", "tfr"),
      url = sprintf(
        "https://www.humanfertility.org/File/GetDocumentFree/Docs/HFDLite/%s.xlsx",
        c("CCF", "TFR")
      ),
      sheet = c("Completed cohort fertility", "Total fertility rates")
    ),
    names = name,
    tar_target(
      hfd,
      {
        tf <- tempfile()
        download.file(url, tf, mode = "wb")
        readxl::read_excel(tf, sheet, skip = 2, na = "0")
      }
    )
  ),
  # e-Stat ---------------------------------------------------------------------
  estat_pop_marriage = get_estat("0003410382", cdTab = "1060"),
  pop_marriage = clean_estat_pop_marriage(estat_pop_marriage),
  hhsize = get_estat("0003410422", cdTab = "1390", cdCat01 = "110") |>
    select(year = time_code, hhsize = value) |>
    mutate(year = as.integer(stringr::str_sub(year, 1, 4))),
  # World Bank -----------------------------------------------------------------
  age_firstmarriage = WDI::WDI(
    indicator = c("SP.DYN.SMAM.FE", "SP.DYN.SMAM.MA"),
    country = "JPN"
  ) |>
    select(year, Men = SP.DYN.SMAM.MA, Women = SP.DYN.SMAM.FE) |>
    tidyr::pivot_longer(
      cols = c(Men, Women),
      names_to = "gender",
      values_to = "age"
    )
)

get_estat <- function(id_stats, ...) {
  estatapi::estat_getStatsData(
    appId = Sys.getenv("ESTAT_APP_ID"),
    statsDataId = id_stats,
    ...
  )
}

clean_estat_pop_marriage <- function(raw) {
  raw |>
    filter(!grepl("不詳補完値", `時間軸（調査年）`)) |>
    mutate(
      year = as.integer(stringr::str_sub(time_code, 1, 4)),
      gender = recode_factor(cat01_code, `110` = "Men", `120` = "Women"),
      age_bin5 = recode_factor(
        cat02_code,
        `150` = "15-19",
        `160` = "20-24",
        `170` = "25-29",
        `180` = "30-34",
        `190` = "35-39",
        `200` = "40-44",
        `210` = "45-49",
        `220` = "50-54",
        `230` = "55-59",
        `240` = "60-64",
        `250` = "65-69",
        `260` = "70-74",
        `270` = "75-79",
        `280` = "80-84",
        `310` = "85+",
        .default = NA_character_
      ),
      marriage4 = recode_factor(
        cat03_code,
        `110` = "Never-married",
        `120` = "Married",
        `130` = "Widowed",
        `140` = "Divorced",
        .default = NA_character_
      )
    ) |>
    select(year, gender, age_bin5, marriage4, n = value) |>
    tidyr::drop_na()
}
