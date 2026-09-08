# template-OdbornaPrace

> Šablona pro **středoškolskou odbornou práci / SOČ** sázenou v [Typstu](https://typst.app).

Kompletní kostra odborné práce: titulní list, prohlášení, poděkování,
anotace v češtině i angličtině, automatický obsah, číslované kapitoly,
křížové odkazy, citace dle ČSN ISO 690 a přílohy.

## Rychlý start

```bash
# 1. Vytvořte si repozitář z této šablony (tlačítko „Use this template“)
# 2. Nainstalujte Typst
brew install typst          # macOS
# 3. Upravte metadata a pusťte živý náhled
$EDITOR metadata.typ
make watch
```

Výsledné PDF vznikne příkazem `make build` v `out/prace.pdf`.

## Struktura

| Cesta | Účel |
| :--- | :--- |
| `metadata.typ` | **Jediný soubor, který je nutné upravit** — název, autor, škola, anotace |
| `main.typ` | Skládá práci dohromady; volitelné úpravy vzhledu |
| `lib/odborna-prace.typ` | Vlastní šablona — titulní list, prohlášení, sazba |
| `kapitoly/*.typ` | Text práce, jeden soubor na kapitolu |
| `bib/references.bib` | Literatura ve formátu BibTeX |
| `img/` | Obrázky |

## Příkazy

| Příkaz | Popis |
| :--- | :--- |
| `make build` | Vysází práci do `out/prace.pdf` |
| `make watch` | Živý náhled — PDF se aktualizuje při uložení |
| `make png` | Vyexportuje jednotlivé strany do `out/pages/` |
| `make check` | Ověří, že práce jde vysázet bez chyb |

## Přizpůsobení požadavkům školy

Školy se v požadavcích liší. Nejčastější úpravy se provádějí v `main.typ`:

```typst
#show: odborna-prace.with(
  meta: meta,
  logo: "/img/logo.png",   // logo školy na titulním listu
  pismo: "Times New Roman", // předepsané písmo
  velikost: 12pt,
  radkovani: 1.5,
  bib-styl: "iso-690-author-date", // citace jméno–datum
)
```

Okraje jsou nastaveny na 3,5 cm vlevo (kvůli vazbě) a 2 cm vpravo;
změníte je v `lib/odborna-prace.typ` v pravidle `set page`.

> **Poznámka:** Šablona záměrně neobsahuje žádné logo ani konkrétní jméno.
> Obojí doplňte až ve vlastní práci vytvořené z této šablony.

## Sazba v CI

Každý push spustí GitHub Actions workflow, který práci vysází a přiloží
PDF jako artefakt — viz `.github/workflows/build.yml`.

## Licence

Šablona je volně k použití. Text vaší práce je vaše dílo.
