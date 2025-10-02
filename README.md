# Family Macro Economics <a href='https://kazuyanagimoto.com/course-kobe-macro4-2025/'><img src='static/img/logo.drawio.svg' align="right" height="139" /></a>

[Macro IV • Fall 2025, Kobe University](https://kazuyanagimoto.com/course-kobe-macro4-2025/)<br>
[Kazuharu Yanagimoto](https://kazuyanagimoto.com)

## Build the Course Website

1. Insatall R and Julia
    - For R, I recommend using [rig](https://github.com/r-lib/rig) to install R
    - For Julia, I recommend using [juliaup](https://github.com/JuliaLang/juliaup) to install Julia
1. Install Quarto
    - For MacOS, I use [Homebrew](https://brew.sh/) to install it in MacOS: `brew install --cask quarto` 
    - For Windows, I use winget to install it in Windows: `winget install --id=Posit.Quarto  -e`
1. Clone this repository (or download it as a ZIP file)
1. Set e-Stats API key
    - Get your API key from [e-Stat](https://www.e-stat.go.jp/api/)
    - Create a file named `.Renviron` in the root directory of this repository, and add the following line:
      ```
      ESTAT_APP_ID=your_api_key_here
      ```
1. Install the required packages
    - Run `renv::restore()` in the R console
    - Run `import Pkg; Pkg.activate(".");  Pkg.instantiate()` in the Julia console
1. Run `targets::tar_make()` to build the website
    - If you got an error about Julia, render one of qmd-files with `engine: julia`

## Licenses

**Text**: All text and images are licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/), except for quoted portions.<br>
**Code**: All code is lincensed under the [MIT License](https://mit-license.org).