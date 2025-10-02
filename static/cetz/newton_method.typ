#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let f(x) = calc.pow(x, 2) - 2
#let df(x) = 2 * x
#let f_line(x, x0) = df(x0) * (x - x0) + f(x0)
#let newton(x) = x - f(x) / df(x)
#let xopt = calc.sqrt(2)
#let x0 = 0.8
#let x1 = newton(x0)
#let color_base = rgb("#107895")
#let color_accent = rgb( "#9a2515")

#cetz.canvas(length: 3cm, {
  import cetz.draw: *
  import cetz-plot: *


  plot.plot(axis-style: "school-book",
            size: (2, 1), x-tick-step: none, y-tick-step: none, {
    plot.add(f, domain: (0., 2), style: (stroke: color_base))

    // Newton's method
    plot.annotate({
      content((xopt - 0.05, 0.5), [ $ x^* $])
      content((x0, 0.4), [$ x_0 $])
      content((-0.3, f(x0)), [$ f(x_0) $])
      content((x1, -0.5), [$ x_1 $])
      content((2, 2.2), [$ f(x) $])
    })
    plot.add-vline(x0, min: calc.min(0., f(x0)), max: calc.max(0., f(x0)),
                   style: (stroke: (dash: "dashed" , paint: gray)))
    plot.add-hline(f(x0), min: 0., max: x0,
                   style: (stroke: (dash: "dashed" , paint: gray)))
    plot.add(x => f_line(x, x0), domain: (0., 2), style: (stroke: color_accent))
    plot.add-vline(x1, min: calc.min(0., f(x1)), max: calc.max(0., f(x1)),
                   style: (stroke: (dash: "dashed" , paint: gray)))
    
  })
})