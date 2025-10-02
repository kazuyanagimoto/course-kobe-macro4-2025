#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let f(x) = calc.pow(x, 2) - 2
#let xopt = calc.sqrt(2)
#let a0 = 0.2
#let b0 = 1.8
#let a1 = (a0 + b0) / 2
#let b1 = (a1 + b0) / 2
#let color_base = rgb("#107895")

#cetz.canvas(length: 3cm, {
  import cetz.draw: *
  import cetz-plot: *


  plot.plot(axis-style: "school-book",
            size: (2, 1), x-tick-step: none, y-tick-step: none, {
    plot.add(f, domain: (0., 2.2), style: (stroke: color_base))

    // Newton's method
    plot.annotate({
      content((xopt - 0.05, 0.5), [ $ x^* $])
      content((a0, 0.4), [$ a_0 $])
      content((a0, f(a0) - 0.5), [$ f(a_0) $])
      content((b0, -0.5), [$ b_0 $])
      content((b0, f(b0) + 1.2), [$ f(b_0) $])
      content((a1, 0.4), [$ a_1 $])
      content((a1, f(a1) - 0.8), [$ f(a_1) $])
    })

    for x in (a0, b0, a1) {
      plot.annotate(circle((x, f(x)), radius: (0.02, 0.1), fill: gray))
      plot.add-vline(x, min: calc.min(0., f(x)), max: calc.max(0., f(x)),
                     style: (stroke: (dash: "dashed" , paint: gray)))
    }
  })
})