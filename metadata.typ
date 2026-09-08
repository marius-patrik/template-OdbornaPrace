// ─────────────────────────────────────────────────────────────
//  Metadata práce — jediné místo, které je potřeba upravit.
//  Vše ostatní (titulní list, anotace, záhlaví) se odvodí odsud.
// ─────────────────────────────────────────────────────────────

#let meta = (
  nazev: "Název odborné práce",
  podnazev: none,

  autor: "Jméno Příjmení",
  vedouci: "Jméno vedoucího práce",
  oponent: none,
  konzultant: none,

  skola: "Název střední školy",
  mesto: "Město",
  obor: "Název studijního oboru",
  rok: 2026,

  // Obor SOČ (Středoškolská odborná činnost). `none`, pokud nejde o SOČ.
  soc-obor: "18. Informatika",

  // Anotace — 3–5 vět, shrnutí cíle, metody a výsledku.
  anotace: [
    Zde uveďte stručnou anotaci práce v českém jazyce. Popište cíl práce,
    použité metody a nejdůležitější dosažené výsledky. Doporučený rozsah
    je 3 až 5 vět.
  ],
  abstract: [
    Provide a short English abstract here. Describe the aim of the thesis,
    the methods used and the most important results achieved. The
    recommended length is three to five sentences.
  ],

  klicova-slova: ("první", "druhé", "třetí"),
  keywords: ("first", "second", "third"),

  // Poděkování je nepovinné — nastavte na `none` pro vynechání.
  podekovani: [
    Rád bych poděkoval vedoucímu práce za cenné rady a odborné vedení.
  ],
)
