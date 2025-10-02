#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let f(x) = x * (x - 1) * (x - 2) + 1
#let f_line(x, x0, x1) = f(x0) + (f(x1) - f(x0)) / (x1 - x0) * (x - x0)
#let Phi(x) = calc.exp(-calc.pow(x, 2) / 2) / calc.sqrt(2 * calc.pi)

#let x0 = 0.8
#let x1 = 1.2
#let a = 0.2
#let b = 2.5
#let n = 4
#let xs = ()
#for i in range(0, n + 1) {
  xs.push(a + i * (b - a) / n)
}

#let rh = 0.8
#let x_i = 0.
#let x_j = 1.
#let d = 1.

#let color_base = rgb("#107895")

#cetz.canvas(length: 3cm, {
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(axis-style: "left", y-min: 0, x-min: -0.5,
            size: (3, 1), x-tick-step: none, y-tick-step: none, {
    plot.add(Phi, domain: (-1, 3), style: (stroke: color_base))

    let y_xlabel = -0.07
    plot.annotate({
      content((rh * x_i, y_xlabel), [$ rho x_i $])
      content((x_j, y_xlabel), [$ x_j $])
      content((x_j + d / 2, y_xlabel), [$ x_j + d / 2 $])
      content((x_j - d / 2, y_xlabel), [$ x_j - d / 2 $])
    })

    plot.add-vline(rh * x_i,
                   min: calc.min(0., Phi(rh * x_i)),
                   max: calc.max(0., Phi(rh * x_i)),
                   style: (stroke: (dash: "dashed" , paint: gray)))
    plot.add-vline(x_j,
                   min: calc.min(0., Phi(x_j)),
                   max: calc.max(0., Phi(x_j)),
                   style: (stroke: (dash: "dashed" , paint: gray)))
    plot.add-vline(x_j + d / 2,
                   min: calc.min(0., Phi(x_j + d / 2)),
                   max: calc.max(0., Phi(x_j + d / 2)),
                   style: (stroke: (paint: gray)))
    plot.add-vline(x_j - d / 2,
                   min: calc.min(0., Phi(x_j - d / 2)),
                   max: calc.max(0., Phi(x_j - d / 2)),
                   style: (stroke: (paint: gray)))
    
    plot.add-fill-between(domain: (x_j - d / 2, x_j + d / 2), Phi, x => 0)
  })
})