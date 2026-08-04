Put spectral.ttf here (or fraunces.ttf) to switch on generated share cards.

Both are free from Google Fonts. Download the family, take the regular weight,
rename it to spectral.ttf, and drop it in this folder. The woff2 files in
static/fonts cannot be used — Hugo's text filter reads TTF and OTF only.

Until one of those files exists, every page falls back to /og-default.png
exactly as before. Nothing breaks; the cards simply do not appear.
