image <- tar_plan(
  # PDF to SVG -----------------------------------------------------------------
  tar_files(
    pdf,
    list_files(
      here_rel("static", "img", "article"),
      pattern = "\\.pdf$",
      recursive = TRUE
    )
  ),
  tar_file(
    svg_from_pdf,
    {
      svg_file <- gsub("\\.pdf$", ".svg", pdf)
      convert_pdf2svg(pdf, svg_file)
    },
    pattern = map(pdf)
  ),
  # CETZ to SVG ----------------------------------------------------------------
  tar_files_input(
    cetz,
    list_files(
      here_rel("static", "cetz"),
      pattern = "\\.typ$",
      recursive = TRUE
    )
  ),
  tar_file(
    svg_from_cetz,
    {
      svg_file <- gsub("\\.typ$", ".svg", cetz)
      compile_cetz2svg(cetz, svg_file)
    },
    pattern = map(cetz)
  )
)

convert_pdf2svg <- function(pdf_file, svg_file) {
  dir.create(dirname(svg_file), showWarnings = FALSE, recursive = TRUE)
  tryCatch(
    {
      system2("pdf2svg", c(pdf_file, svg_file))
      return(svg_file)
    },
    error = function(e) {
      warning(paste(
        "Failed to convert PDF to SVG:",
        pdf_file,
        "Error:",
        e$message
      ))
      return(NULL)
    }
  )
}

compile_cetz2svg <- function(cetz_file, svg_file) {
  dir.create(dirname(svg_file), showWarnings = FALSE, recursive = TRUE)
  tryCatch(
    {
      system2(
        "quarto",
        c("typst", "compile", "--format", "svg", cetz_file, svg_file)
      )
      return(svg_file)
    },
    error = function(e) {
      warning(paste(
        "Failed to compile CETZ to SVG:",
        cetz_file,
        "Error:",
        e$message
      ))
      return(NULL)
    }
  )
}
