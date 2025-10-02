build_ical <- function(schedule, url_site) {
  dtstamp <- calendar::ic_char_datetime(
    lubridate::now("UTC"),
    zulu = TRUE
  )

  schedule |>
    mutate(
      rnum = row_number(),
      start_time_jst = lubridate::ymd_hm(
        paste0(date, " 13:20"),
        tz = "Asia/Tokyo"
      ),
      start_time = lubridate::with_tz(start_time_jst, "UTC"),
      summary = glue::glue("Macro IV: {rnum}. {title}"),
    ) |>
    group_by(rnum) |>
    tidyr::nest() |>
    mutate(
      ical = purrr::map(
        data,
        ~ calendar::ic_event(
          start_time = .$start_time,
          end_time = 1.5,
          summary = .$summary,
          more_properties = TRUE,
          event_properties = list(
            LOCATION = "六甲台本館203",
            DESCRIPTION = glue::glue("{url_site}/lecture/{.$id}"),
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

build_schedule <- function(files) {
  purrr::map(files, \(x) {
    yaml <- rmarkdown::yaml_front_matter(x)
    tibble(
      id = tools::file_path_sans_ext(basename(x)),
      title = yaml$title,
      date = yaml$date,
      type = basename(dirname(x)),
    )
  }) |>
    purrr::list_rbind() |>
    filter(stringr::str_sub(id, 1, 1) == "0") |>
    add_row(id = "", title = "まとめ", date = "2026-01-26") |>
    arrange(date)
}


ic_write2 <- function(ical, file, ...) {
  dir.create(dirname(file), showWarnings = FALSE, recursive = TRUE)
  calendar::ic_write(ical, file, ...)
  return(file)
}
