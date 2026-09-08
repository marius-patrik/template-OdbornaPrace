// ─────────────────────────────────────────────────────────────
//  Šablona pro středoškolskou odbornou práci / SOČ.
//  Generická — veškerý obsah přichází přes argument `meta`.
// ─────────────────────────────────────────────────────────────

#let nadpis-bez-cisla(text-nadpisu) = {
  heading(numbering: none, outlined: true, text-nadpisu)
}

// Titulní list dle zvyklostí českých středních škol.
#let titulni-list(meta, logo: none) = {
  set align(center)
  set page(numbering: none)

  v(1.5cm)

  // Logo je nepovinné — šablona jej nedodává, doplňte jej ve vlastní práci.
  if logo != none {
    block(image(logo, height: 2.2cm))
    v(0.6cm)
  }

  text(size: 14pt, weight: "bold", upper(meta.skola))

  if meta.obor != none {
    v(0.3cm)
    text(size: 12pt, meta.obor)
  }

  v(3.5cm)

  if meta.soc-obor != none {
    text(size: 12pt, style: "italic")[
      Středoškolská odborná činnost \
      Obor č. #meta.soc-obor
    ]
    v(1.2cm)
  }

  text(size: 20pt, weight: "bold", meta.nazev)

  if meta.podnazev != none {
    v(0.4cm)
    text(size: 14pt, meta.podnazev)
  }

  v(0.8cm)
  line(length: 45%, stroke: 0.5pt)

  v(1fr)

  set align(left)
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.8cm,
    row-gutter: 0.45cm,
    [*Autor:*], meta.autor,
    ..if meta.vedouci != none { ([*Vedoucí práce:*], meta.vedouci) } else { () },
    ..if meta.konzultant != none { ([*Konzultant:*], meta.konzultant) } else { () },
    ..if meta.oponent != none { ([*Oponent:*], meta.oponent) } else { () },
  )

  v(0.9cm)
  set align(center)
  text(size: 12pt)[#meta.mesto, #meta.rok]

  pagebreak()
}

// Prohlášení o samostatném vypracování — vyžadováno prakticky vždy.
#let prohlaseni(meta) = {
  nadpis-bez-cisla[Prohlášení]

  [
    Prohlašuji, že jsem svou práci s názvem „#meta.nazev“ vypracoval/a
    samostatně, pod odborným vedením #meta.vedouci, a použil/a jsem pouze
    prameny a literaturu uvedené v seznamu použité literatury.

    Prohlašuji, že tištěná verze a elektronická verze práce jsou shodné.
    Nemám závažný důvod proti zpřístupňování této práce v souladu se
    zákonem č. 121/2000 Sb., o právu autorském, ve znění pozdějších předpisů.
  ]

  v(2.5cm)
  grid(
    columns: (1fr, 1fr),
    align(left)[V #meta.mesto dne #h(2cm)],
    align(center)[
      #line(length: 6cm, stroke: 0.5pt)
      #meta.autor
    ],
  )

  pagebreak()
}

#let podekovani-strana(meta) = {
  if meta.podekovani == none { return }
  nadpis-bez-cisla[Poděkování]
  meta.podekovani
  pagebreak()
}

// Anotace CZ + EN s klíčovými slovy.
#let anotace-strana(meta) = {
  nadpis-bez-cisla[Anotace]
  meta.anotace
  v(0.5cm)
  [*Klíčová slova:* #meta.klicova-slova.join(", ")]

  v(1.2cm)

  nadpis-bez-cisla[Abstract]
  meta.abstract
  v(0.5cm)
  [*Keywords:* #meta.keywords.join(", ")]

  pagebreak()
}

// Hlavní šablona. Použití:  #show: odborna-prace.with(meta: meta)
#let odborna-prace(
  meta: (:),
  // Cesta k logu školy, např. "/img/logo.png". `none` = bez loga.
  logo: none,
  pismo: "New Computer Modern",
  velikost: 12pt,
  radkovani: 1.5,
  bibliografie: "/bib/references.bib",
  bib-styl: "iso-690-numeric",
  body,
) = {
  set document(title: meta.nazev, author: meta.autor)

  set page(
    paper: "a4",
    // Levý okraj je širší kvůli vazbě — běžný požadavek škol.
    margin: (left: 3.5cm, right: 2cm, top: 2.5cm, bottom: 2.5cm),
  )

  set text(font: pismo, size: velikost, lang: "cs", hyphenate: true)
  set par(justify: true, leading: radkovani * 0.45em)
  set heading(numbering: "1.1")

  // Číslované nadpisy s rozumnými rozestupy.
  // Novou stranu vynucují pouze číslované kapitoly; nečíslované nadpisy
  // přední části si stránkování řídí samy.
  show heading.where(level: 1): it => {
    if it.numbering != none { pagebreak(weak: true) }
    block(above: 0em, below: 1.2em, text(size: 17pt, weight: "bold", it))
  }
  show heading.where(level: 2): it => {
    block(above: 1.6em, below: 0.9em, text(size: 14pt, weight: "bold", it))
  }
  show heading.where(level: 3): it => {
    block(above: 1.3em, below: 0.7em, text(size: 12pt, weight: "bold", it))
  }

  show figure.caption: set text(size: 10pt)
  show raw: set text(font: "DejaVu Sans Mono", size: 9.5pt)
  show link: set text(fill: rgb("#0b4f9e"))
  set table(stroke: 0.5pt)

  // ── Přední část ──────────────────────────────────────────
  titulni-list(meta, logo: logo)

  // Titulní list se počítá, ale nečísluje.
  set page(numbering: "1")
  counter(page).update(2)

  prohlaseni(meta)
  podekovani-strana(meta)
  anotace-strana(meta)

  outline(title: "Obsah", depth: 3, indent: auto)
  pagebreak()

  // ── Vlastní text ─────────────────────────────────────────
  body

  // ── Zadní část ───────────────────────────────────────────
  if bibliografie != none {
    pagebreak(weak: true)
    bibliography(
      bibliografie,
      style: bib-styl,
      title: "Seznam použité literatury",
    )
  }
}

// Přílohy: číslované A, B, C… a vedené v obsahu.
#let prilohy(body) = {
  pagebreak(weak: true)
  counter(heading).update(0)
  set heading(numbering: "A.1")
  nadpis-bez-cisla[Přílohy]
  body
}
