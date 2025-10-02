#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#set page(width: auto, height: auto, margin: .5cm)

#let xbar = 0.5
#let color_base = rgb("#107895")
#let theta1 = 2.0
#let theta2 = 0.5
#let e(x, theta, xbar: xbar) = {
  if x < xbar {
    return calc.pow(x, 1+theta)
  } else {
    return calc.pow(xbar, theta) * x
  }
}

#let e_nl(x) = e(x, theta1)
#let e_l(x) = e(x, theta2)

#cetz.canvas(length: 5cm, {
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(axis-style: "school-book", x-label: $h$, y-label: $e_1(h)$,
            size: (2, 1), x-tick-step: none, y-tick-step: none, {
    plot.add(e_nl, domain: (0., 0.75), style: (stroke: color_base))
    plot.add-vline(xbar, min: 0, max: e_nl(xbar), style: (stroke: (dash: "dashed" , paint: gray)))
    plot.annotate({
      content((xbar, -0.02), [ $ overline(h) $])
    })
    
  })

})