#import "@preview/mmdr:0.1.0": mermaid

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!




// =============================================================================
// MERMAID DIAGRAM SYNTAX RULES FOR TYPST
// =============================================================================
// When generating Mermaid diagram code for use within the Typst #mermaid()
// plugin (WASM-based renderer), the following rules MUST be followed to avoid
// parser panics and rendering failures:
//
// 1. EDGE LABELS: Never use pipe syntax -->|label|. Always use --label-->
//    with no spaces between the dashes and the label text.
//    WRONG:   A -->|Yes| B
//    CORRECT: A --Yes--> B
//
// 2. DOTTED EDGE LABELS: Never use -.->|label|. Use -. label .-> instead.
//    WRONG:   A -.->|On Failure| B
//    CORRECT: A -. On Failure .-> B
//
// 3. SPECIAL CHARACTERS IN NODE LABELS: If a node label contains hyphens,
//    forward slashes, pipes, or other special characters, wrap the label
//    in escaped quotes.
//    WRONG:   A[PRE-PROD Environment]
//    CORRECT: A[\"PRE-PROD Environment\"]
//    WRONG:   A[Dynamics 365 / Legacy API]
//    CORRECT: A[\"Dynamics 365 / Legacy API\"]
//
// 4. SUBGRAPH TITLES: Apply the same quoting rules to subgraph titles
//    if they contain special characters.
//
// 5. GENERAL PRINCIPLE: The Typst WASM Mermaid renderer is less forgiving
//    than browser-based Mermaid. When in doubt, quote labels and avoid
//    pipe characters entirely. Test diagrams incrementally — if the plugin
//    panics with "wasm unreachable instruction executed", the cause is
//    almost always unescaped special characters or pipe-style edge labels.
// =============================================================================

  #let accent-table(accent: "#c2f0ff", ..arguments) = {
    table(
      fill: (x, y) => {
        if y == 0 {rgb(accent) }        // header row
        else if x == 0 { rgb(accent) }   // first column
      },
      ..arguments
    )
  }
  #let summary-table(row-count,accent: "#c2f0ff", ..args) = {
    table(
      fill: (x, y) => {
          if y == 0 or y == row-count - 1 { rgb(accent) }
        },
        ..args
      )
  }

#let project(
 
  logo: none,
  company-url: "nasstar.com",
  doc-title: "Nasstar (Please Replace)",
  doc-description: "Description",
  publish-date: none,
  publish-version: "0.1",
  doc-author: (),
  version-history: (),
  doc-accent-colour: "#c2f0ff",
  body,
  
) = {
  // Set the document's basic properties.
  set document(author: doc-author.map(a => a.name), title: doc-title)
  set page(
    numbering: "1",
    number-align: center,
    paper: "a4", 
    margin: 0pt,
    background: image("media/image2.jpg", width: 100%, height: 100%)
  )
  set heading(numbering: "1.",)
  show heading.where(level: 1): set block(above: 2em, below: 1em)
  show heading.where(level: 2): set block(above: 1.5em, below: 0.75em)
  show heading.where(level: 3): set block(above: 1em, below: 0.5em)

  
  show raw.where(block: true): it => block(
    fill: luma(180),
    inset: 18pt,
    radius: 7pt,
    width: 100%,
    it,
  )
  
  
  set text(font: "Noto Sans", weight: "light", lang: "en")
  set table(
    fill: (x, y) => {
          if y == 0 { rgb(doc-accent-colour) }          // header row - blue
          else if calc.even(y) { luma(240) }     // odd rows - light grey
        },
    stroke: 0.5pt + luma(200),
    inset: 8pt,
  )
  // limits the text size in a table only
  show table: set text(size: 8pt)

  // and figure captions
  show figure.caption: it => {
    set text(size: 8pt, style: "italic")
    it
    v(12pt)
  }
  

  set list(indent: 1.5em)       // how far nested levels indent
  set list(body-indent: 0.5em)  // space between bullet and text
  set list(marker: ([•], [--], [▸]))  // different markers per level
  

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  
  //v(0.6fr)
  //if logo != none {
  //  align(right, image(logo, width: 26%))
  //}
  place( dx: 0.8in, dy: 0.8in,
    image("media/image1.png", width: 2.5in)
  )
  place(dx: 1in, dy: 7in,
    text(font: "Noto Sans", size: 28pt, weight: "semibold",[#doc-title]  )
  )
  place(dx: 1in, dy: 7.5in,
    text([#doc-description] , weight: "medium", size: 20pt )
  )

  place(dx: 5.5in, dy: 11in,
    text[#strong(text[Version #publish-version]) - #publish-date]
  )


  //text(1.1em, publish-date)
  //v(1.2em, weak: true)
  //text(2em, weight: 700, doc-title)
  // Author information.
  place(dx: 1in, dy: 8.3in,
   
   grid(
      columns: (1fr,) * calc.min(2, doc-author.len()),
      gutter: 1em,
      ..doc-author.map(author => align(start)[
        *#author.name* \
        #author.email \
        #author.affiliation
        ]),
      ),
   
  )
  


  pagebreak()
  
// REST OF DOCUMENT (no background)
set page(
  paper: "a4",
  margin: 2.54cm,   // pick what you want; omitting margin uses Typst defaults
  background: none,
    header: {
      block(width: 100%, inset: (y: 10pt))[
      #grid(
        columns: (auto, 1fr),
        align: (left, right + horizon),
        [],
        {
          text(size: 8pt, weight: "regular")[Version #publish-version - ]
          text(size: 8pt, weight: "light")[#publish-date]
        }
      )
      ]
    },
    footer: {
    let logo = image("media/image7.png")  // swap for your logo file
    let current = context counter(page).display()
    let total = context counter(page).final().first()
    block(width: 100%, inset: (y: -4pt))[
      #line(length: 100%, stroke: 0.5pt + luma(200))
      #v(8pt)
      #grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right + horizon),
        
        // Left: dark sidebar accent (optional, or leave empty)
        logo,
        
        // Centre: logo + text
        {
          set text(fill: luma(120))
          stack(dir: ltr, spacing: 12pt,
  
            stack(spacing: 4pt,
              text(weight: "bold", size: 9pt)[#company-url],
              text(size: 8pt)[#doc-title - #doc-description],
            )
          )
        },
        
        // Right: page number

        text(fill: luma(120), size: 10pt)[Page #current of #total],
      )
    ]
  }
)



  // Main body.
  
  outline(depth: 2, title: "Table of Contents\n\n" )

  pagebreak()

  heading("Version Control", bookmarked: false, numbering: none)

  v(12pt)
  strong[Current Version]

  table(
      columns: (30%, 70%),
      align: (left, left,),
      inset: 10pt,

      stroke: 0.5pt + luma(200),
      table.header([Parameter], [Value]), 
      
      table.hline(), 
      [Current Version], [#publish-version],
      [Release Date], [#publish-date], 
      [Authors], grid(
            gutter: 1em,
            ..doc-author.map(author => align(start)[
                #author.name \
            ]),
        )
      )

  v(12pt)
  strong[Version History]


  // history table
  table(
      columns: (10%, 20%, 25%, 45%),
  
    align: (center, left, left, left),
  
  
  
    table.header(
      [Version], [Date], [Author], [Description of Changes],
    ),
    ..version-history.map(v => (
      [*#v.Ver*],v.date,v.author,v.description     
    )).flatten(),

    
    
  )


  pagebreak()


  
  set par(justify: true, spacing: 12pt)

  body
}