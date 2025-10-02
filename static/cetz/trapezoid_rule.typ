#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let f(x) = x * (x - 1) * (x - 2) + 1
#let f_line(x, x0, x1) = f(x0) + (f(x1) - f(x0)) / (x1 - x0) * (x - x0)

#let x0 = 0.8
#let x1 = 1.2
#let a = 0.2
#let b = 2.5
#let n = 4
#let xs = ()
#for i in range(0, n + 1) {
  xs.push(a + i * (b - a) / n)
}

#let color_base = rgb("#107895")

#cetz.canvas(length: 3cm, {
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(axis-style: "school-book",
            size: (2, 1), x-tick-step: none, y-tick-step: none, {
    plot.add(f, domain: (0., 2.6), style: (stroke: color_base))

    plot.annotate({
      content((a + 0.1, -0.5), [$ a = x_0$])
      content((b + 0.05, -0.5), [$ b = x_(#n)$])
    })

    for i in range(0, n) {
      let x0 = xs.at(i)
      let x1 = xs.at(i + 1)
      if i > 0 {
        plot.annotate({
          content((x0, -0.5), [$ x_(#i)$])
        })
      }
      plot.add-vline(x0, min: calc.min(0., f(x0)), max: calc.max(0., f(x0)),
                     style: (stroke: (dash: "dashed" , paint: gray)))
      plot.add(x => f_line(x, x0, x1), domain: (x0, x1), style: (stroke: (paint: black)))

    }

    plot.add-vline(b, min: calc.min(0., f(b)), max: calc.max(0., f(b)),
                   style: (stroke: (dash: "dashed" , paint: gray)))
    
  })
})