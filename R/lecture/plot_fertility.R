plot_fertility_outsource <- function(path) {
  delta = 5.
  wm = 1.
  ps = 0.5
  phi = 1.
  psi = 0.3

  tibble(
    s = rep(c(0.25, 0.75), each = 100),
    wf = rep(seq(0.1, wm, length.out = 100), 2)
  ) |>
    mutate(
      n = (delta / (1 + delta)) *
        (wm + wf) /
        (psi + (s * ps + (1 - s) * wf) * phi),
      lbl_facet = paste0("s = ", s)
    ) |>
    ggplot(aes(x = wf, y = n)) +
    geom_line(color = color_base) +
    facet_wrap(~lbl_facet) +
    labs(
      x = latex2exp::TeX("Female Wage ($w_f$)"),
      y = latex2exp::TeX("Number of Children $n$"),
      caption = latex2exp::TeX(
        "$\\delta = 5$, $w_m = 1$, $p_s = 0.5$, $\\phi = 1$, $\\psi = 0.3$"
      )
    ) +
    theme_proj(size_base = 18) +
    theme(legend.position = "none")

  ggsave(path, width = 6, height = 3.708)
  return(path)
}
