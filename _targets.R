library(targets)
library(tarchetypes)
suppressPackageStartupMessages(library(dplyr))
library(ggplot2)

options(
  tidyverse.quiet = TRUE,
  dplyr.summarise.inform = FALSE,
  readr.show_col_types = FALSE
)

tar_config_set(
  store = here::here("_targets"),
  script = here::here("_targets.R")
)

#-------------------------------------------------------------------------------
# Utility Functions
#-------------------------------------------------------------------------------

here_rel <- function(...) {
  fs::path_rel(here::here(...))
}

list_files <- function(path, ...) {
  file.path(path, list.files(path, ...))
}

download_file <- function(url, dest_file, ...) {
  dir.create(dirname(dest_file), showWarnings = FALSE, recursive = TRUE)
  download.file(url, dest_file, ...)
  return(dest_file)
}

write_lines <- function(text, file, ...) {
  dir.create(dirname(file), showWarnings = FALSE, recursive = TRUE)
  writeLines(text = text, con = file, ...)
  return(file)
}

#-------------------------------------------------------------------------------
# Main pipeline
#-------------------------------------------------------------------------------

tar_source()

tar_plan(
  # Graphics -------------------------------------------------------------------
  tar_target(
    fns_graphics,
    lst(
      theme_proj,
      color_base,
      color_accent,
    )
  ),
  # Lecture --------------------------------------------------------------------
  image,
  data,
  lecture,
  # Website --------------------------------------------------------------------
  tar_quarto(
    website,
    path = ".",
    quiet = FALSE,
    extra_files = list_files(here_rel("static"), recursive = TRUE)
  ),
)
