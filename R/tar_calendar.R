calendar <- tar_plan(
  tar_files(
    files,
    c(
      list.files("slides", pattern = "\\.qmd$", full.names = TRUE),
      list.files("lecture", pattern = "\\.qmd$", full.names = TRUE)
    )
  ),
  tar_target(qmd, readLines(files), pattern = map(files)),
  tar_target(
    schedule_raw,
    {
      qmd
      yaml <- rmarkdown::yaml_front_matter(files)
      tibble(
        id = tools::file_path_sans_ext(basename(files)),
        title = yaml$title,
        date = yaml$date,
        type = basename(dirname(files)),
      )
    },
    pattern = map(files)
  ),
  schedule = build_schedule(schedule_raw, url_site),
  tar_file(
    schedule_csv,
    {
      path <- here_rel("static", "schedule.csv")
      readr::write_csv(schedule, path)
      path
    }
  ),
  tar_file(
    schedule_ics,
    {
      ical <- build_ical(schedule, url_site)
      ic_write2(ical, here_rel("schedule.ics"))
    }
  )
)

build_schedule <- function(schedule_raw, url_site) {
  schedule_raw |>
    filter(stringr::str_sub(id, 1, 1) == "0") |>
    add_row(id = "", title = "まとめ", date = "2026-01-26") |>
    arrange(date) |>
    mutate(
      rnum = row_number(),
      start_jst = lubridate::ymd_hm(
        paste0(date, " 13:20"),
        tz = "Asia/Tokyo"
      ),
      start = lubridate::with_tz(start_jst, "UTC"),
      end = start + lubridate::minutes(90),
      summary = glue::glue("Macro IV: {rnum}. {title}"),
      location = "六甲台本館230",
      description = glue::glue("{url_site}/lecture/{id}")
    ) |>
    select(-c(start_jst))
}


build_ical <- function(schedule, url_site) {
  dtstamp <- calendar::ic_char_datetime(
    lubridate::now("UTC"),
    zulu = TRUE
  )

  schedule |>
    group_by(rnum) |>
    tidyr::nest() |>
    mutate(
      ical = purrr::map(
        data,
        ~ calendar::ic_event(
          start_time = .$start,
          end_time = .$end,
          summary = .$summary,
          more_properties = TRUE,
          event_properties = list(
            LOCATION = .$location,
            DESCRIPTION = .$description,
            DTSTAMP = dtstamp
          )
        )
      )
    ) |>
    ungroup() |>
    select(-c(rnum, data)) |>
    tidyr::unnest(ical) |>
    calendar::ical()
}

ic_write2 <- function(ical, file, ...) {
  dir.create(dirname(file), showWarnings = FALSE, recursive = TRUE)
  calendar::ic_write(ical, file, ...)
  return(file)
}
