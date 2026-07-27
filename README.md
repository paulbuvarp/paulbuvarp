# paulbuvarp.com

A Hugo site. No theme submodule, no build dependencies beyond Hugo itself, no
JavaScript, no third-party requests. Four self-hosted fonts, 85 KB total.

---

## Run it locally

```bash
brew install hugo        # macOS
# or: sudo apt install hugo   (needs 0.146+; check with hugo version)

hugo server
```

Open <http://localhost:1313>. Edits reload instantly.

---

## Deploy, in order

The DNS step is the only one you cannot hurry, so start it early.

**1. Repository.** Create a public GitHub repo called `paulbuvarp`. Then, from
this directory:

```bash
git init
git add .
git commit -m "Initial site"
git branch -M main
git remote add origin git@github.com:YOURNAME/paulbuvarp.git
git push -u origin main
```

**2. Pages.** Repo → Settings → Pages → Source: **GitHub Actions**. The workflow
in `.github/workflows/hugo.yml` handles the rest. Watch the Actions tab; the
first build takes about ninety seconds.

**3. DNS in Cloudflare.** For `paulbuvarp.com`:

| Type  | Name | Content                  | Proxy    |
|-------|------|--------------------------|----------|
| A     | `@`  | `185.199.108.153`        | **DNS only** |
| A     | `@`  | `185.199.109.153`        | **DNS only** |
| A     | `@`  | `185.199.110.153`        | **DNS only** |
| A     | `@`  | `185.199.111.153`        | **DNS only** |
| CNAME | `www`| `YOURNAME.github.io`     | **DNS only** |

The grey cloud matters. GitHub cannot issue its Let's Encrypt certificate
through Cloudflare's proxy, and you will lose an evening to this if you leave
the orange cloud on. Once Pages reports HTTPS as active, turn the proxy on if
you want it.

**4. Custom domain.** Settings → Pages → Custom domain → `paulbuvarp.com`. Tick
*Enforce HTTPS* once the certificate appears. `static/CNAME` is already in place.

---

## Before you push: fill these in

- `hugo.yaml` → **`sameAs`**. Every profile URL you have: FFI staff page, Google
  Scholar, ORCID, Bluesky, LinkedIn. This block does more for your search
  visibility than anything else on the site. Blank entries are skipped safely.
- `hugo.yaml` → `email`, if you want one published.
- `data/publications.yaml` → the entries marked `TODO`, and **verify every year
  and title**. I seeded this from what I knew of your work and left every URL
  blank rather than invent one.
- `content/_index.md` → the biography. Read it in your own voice and change what
  is not.

---

## Adding a piece

One stanza in `data/publications.yaml`:

```yaml
- title: "Å gå god for"
  venue: "Samtiden"
  year: 2026
  kind: essay          # essay | academic | report | chapter | broadcast
  featured: true       # homepage; keep to five or six
  url: "https://..."   # empty renders unlinked, which is right for paywalls
  note: "On trust and liability"
```

Commit, push, done in ninety seconds.

**The rule:** you add the entry in the same session you publish the piece, as
the last act of publishing it. Not a task for later. Later is where personal
sites go to die.

---

## Making Google agree that you exist

Ranking for "Paul Buvarp" is not a competitive problem — the name is rare.
The problem is *entity consolidation*: teaching Google that the FFI staff page,
the Scholar profile, the Vagant bylines and this site are one person. That is
what the following do.

1. **Search Console.** Add `paulbuvarp.com`, verify by DNS TXT record in
   Cloudflare, submit `https://paulbuvarp.com/sitemap.xml`. Hugo generates the
   sitemap already.
2. **Fill in `sameAs`.** The JSON-LD `Person` block on the homepage is built
   from it, and the footer links carry `rel="me"`. Both are signals.
3. **Reciprocate.** Ask FFI to link this site from your staff page. A `.no`
   institutional domain is the highest-authority inbound link available to you,
   and it costs one email. Add the URL to your ORCID, your Scholar profile, your
   Bluesky bio, and your contributor note at Vagant.
4. **One name, everywhere.** You appear variously as Paul Buvarp, Paul M. H.
   Buvarp and Paul Magnus Hjertvik Buvarp. Pick one for bylines. The other two
   are declared as `alternateName` in the schema, which is how you get the
   benefit of all three without the dilution.
5. **The concept pages are the long game.** Nobody is competing for "tertiary
   orality". A dated, indexed, definitional page under your own domain is how
   you hold the term while the paper is still in review.

Expect four to eight weeks to rank first for the exact name, and rather longer
for the concepts. There is nothing further to do once the above is in place.

---

## Structure

```
hugo.yaml                    config, identity, sameAs
data/publications.yaml       the only file you edit regularly
content/
  _index.md                  homepage biography
  writing.md                 renders from the data file
  presentasjon.md            Norwegian press presentation
  concepts/                  four definitional pages
  notes/                     empty, deliberately
layouts/                     six templates, no theme
assets/css/main.css          one stylesheet
static/fonts/                Fraunces + Spectral, subset, self-hosted
static/robots.txt            a decision about AI crawlers awaits you
```

---

## Design notes

Palette is bone paper, letterpress ink, and a spruce mark used only for links
and the brackets. Fraunces for display, pinned to a single optical instance;
Spectral for text, at a 34rem measure. Both are self-hosted rather than pulled
from Google's CDN — a German court has held that the CDN's IP logging is an
unlawful transfer under the GDPR, and you should not be leaking your readers to
Mountain View.

The homepage biography sits inside an enormous pair of parentheses. They are
unlabelled: a visitor who does not know the argument sees a typographic frame,
and an editor who does knows exactly what they are looking at. Dark mode is
handled, keyboard focus is visible, reduced motion is respected, and there is no
analytics. If you must have numbers, GoatCounter is cookieless and EU-hosted.
