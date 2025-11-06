#show figure: set block(breakable: true)
#figure( // start preamble figure
  
  kind: "tinytable",
  supplement: "Table", // end preamble figure

block[ // start block

  #let style-dict = (
    // tinytable style-dict after
    "0_0": 0, "0_1": 0, "0_2": 0, "0_3": 0, "0_4": 0, "0_5": 0
  )

  #let style-array = ( 
    // tinytable cell style after
    (align: center,),
  )

  // Helper function to get cell style
  #let get-style(x, y) = {
    let key = str(y) + "_" + str(x)
    if key in style-dict { style-array.at(style-dict.at(key)) } else { none }
  }

  // tinytable align-default-array before
  #let align-default-array = ( left, left, left, left, left, left, ) // tinytable align-default-array here
  #show table.cell: it => {
    if style-array.len() == 0 { return it }
    
    let style = get-style(it.x, it.y)
    if style == none { return it }
    
    let tmp = it
    if ("fontsize" in style) { tmp = text(size: style.fontsize, tmp) }
    if ("color" in style) { tmp = text(fill: style.color, tmp) }
    if ("indent" in style) { tmp = pad(left: style.indent, tmp) }
    if ("underline" in style) { tmp = underline(tmp) }
    if ("italic" in style) { tmp = emph(tmp) }
    if ("bold" in style) { tmp = strong(tmp) }
    if ("mono" in style) { tmp = math.mono(tmp) }
    if ("strikeout" in style) { tmp = strike(tmp) }
    if ("smallcaps" in style) { tmp = smallcaps(tmp) }
    tmp
  }

  #align(center, [

  #table( // tinytable table start
    column-gutter: 5pt,
    columns: (10.00%, 10.00%, 10.00%, 30.00%, 10.00%, 10.00%),
    stroke: none,
    rows: auto,
    align: (x, y) => {
      let style = get-style(x, y)
      if style != none and "align" in style { style.align } else { left }
    },
    fill: (x, y) => {
      let style = get-style(x, y)
      if style != none and "background" in style { style.background }
    },
 table.hline(y: 1, start: 1, end: 3, stroke: 0.05em + black),
 table.hline(y: 1, start: 4, end: 6, stroke: 0.05em + black),
 table.hline(y: 2, start: 0, end: 6, stroke: 0.05em + black),
 table.hline(y: 6, start: 0, end: 6, stroke: 0.1em + black),
 table.hline(y: 0, start: 0, end: 6, stroke: 0.1em + black),
    // tinytable lines before

    // tinytable header start
    table.header(
      repeat: true,
[ ], table.cell(stroke: (bottom: .05em + black), colspan: 2, align: center)[Parameter], [ ], table.cell(stroke: (bottom: .05em + black), colspan: 2, align: center)[Data Target],
[], [2005], [(1960)], [Target], [2005], [(1960)],
    ),
    // tinytable header end

    // tinytable cell content after
[$ w_(1) $], [1.81], [1.04], [Skill premium of college], [2.020], [1.550],
[$ phi.alt $], [0.59], [0.40], [Female relative earnings], [0.640], [0.450],
[$ eta_(f) $], [66.45], [134.97], [Share of college, females], [0.332], [0.072],
[$ eta_(m) $], [55.75], [69.86], [Share of college, males], [0.318], [0.125],

    // tinytable footer after

  ) // end table

  ]) // end align

] // end block
) // end figure
