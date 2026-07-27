# paulbuvarp.com

A Hugo site in two languages. No theme, no build dependencies beyond Hugo, no
third-party requests except the contact form. Four self-hosted fonts, 85 KB.

- `paulbuvarp.com` — Norwegian
- `paulbuvarp.com/en/` — English
- **EN / NO** toggle on every page, landing on the same page in the other language

---

## Editing without touching code

You never need to open GitHub to change a word. Three things, once:

1. **GitHub Desktop** — you have this. It is the publish button.
2. **A markdown editor.** [Obsidian](https://obsidian.md) is free, opens a folder
   of `.md` files directly, and shows formatting as you type. Point it at your
   cloned repo folder and the whole site becomes a set of documents.
3. That is it.

The loop: edit in Obsidian → save → GitHub Desktop shows what changed → type a
summary → **Commit to main** → **Push origin**. Live in ninety seconds.

Markdown is three rules: `#` for a heading, `*text*` for italic, blank line
between paragraphs. Everything above the `---` line at the top of a file is
settings; everything below it is prose.

> A hosted CMS with a login page is possible — Sveltia or Decap — but on GitHub
> Pages it needs an OAuth broker running somewhere, which is a moving part that
> will break in eighteen months when you have forgotten it exists. The folder of
> text files will not.

---

## What lives where

| I want to change… | Open this |
|---|---|
| The Norwegian front page | `content/_index.no.md` |
| The English front page | `content/_index.en.md` |
| A publication entry | `data/publications.yaml` |
| An upcoming talk | `data/talks.yaml` |
| The contact page | `content/contact.no.md` / `.en.md` |
| A concept page | `content/concepts/*.no.md` / `*.en.md` |
| Your address, socials, portrait | `hugo.yaml` |

`.no.md` is Norwegian, `.en.md` is English. To translate anything, copy the file
and swap the suffix. Hugo pairs them and the toggle appears by itself.

---

## Setting up contact — do this first

### 1. An address you can throw away

Do not publish your real inbox. In **Cloudflare → your domain → Email → Email
Routing**, enable it, accept the MX records it offers, and create a single
address — `hei@paulbuvarp.com` or `post@paulbuvarp.com` — forwarding to wherever
you actually read mail.

Two advantages. Editors can write to you from their own mail client and attach
things, which is what editors want to do. And if it is ever buried in spam, you
delete the alias and make another; your real address was never exposed.

Then in `hugo.yaml`:

```yaml
  contactUser: "hei"
  contactDomain: "paulbuvarp.com"
```

The page assembles the address in the browser rather than printing it in the
HTML, which stops the low-effort harvesters. Leave `contactUser` empty and the
whole row disappears.

### 2. A form, for people who would rather not open their mail

Sign up at [formspree.io](https://formspree.io), create a form, and it gives you
an ID that looks like `xdorbgpz`. Paste it in:

```yaml
  formspreeID: "xdorbgpz"
```

Free tier is 50 messages a month, which is more than a personal site receives.
Submissions arrive as email. There is a hidden honeypot field already in place,
which removes most bot traffic. Leave the ID empty and the form is simply not
rendered.

### 3. Socials

Fill in the `sameAs` block in `hugo.yaml` — LinkedIn, Facebook, FFI staff page,
Google Scholar, ORCID, Bluesky. These do double duty: they appear on the contact
page and in the footer, and they feed the JSON-LD identity block that tells
Google all these profiles are one person. Delete the rows you have no URL for.

---

## The portrait

Save it as `static/img/portrait.jpg` and switch it on in `hugo.yaml`:

```yaml
  portrait: "/img/portrait.jpg"
  portraitCredit: "Photo: NAME"
  portraitOnHome: false
```

What to supply: **1200 × 1500 px**, portrait orientation, under 300 KB, saved at
about 80% JPEG quality. Head and shoulders, plain or quiet background, looking at
the camera. The site renders it in greyscale, so do not spend effort on colour —
and do check it works in monochrome before committing.

`portraitOnHome: false` is the default and I would leave it there. The front page
works because it is only type; a face competes with the parentheses and the whole
thing gets busier. The contact page is where a reader has already decided they
want to know who you are. Set it to `true` if you disagree — it renders small and
quietly on the left.

---

## Talks

`data/talks.yaml`. One stanza per engagement:

```yaml
- date: "2026-08-13"
  title: "Universities and democratic resilience"
  event: "Arendalsuka"
  city: "Arendal"
  role: "Moderator"
  lang: "no"
  url: ""
```

`date` is the only field that must be right. Anything in the future appears under
*Kommende*; the moment it passes it moves itself to *Tidligere* and drops off the
front page. Nothing needs deleting and nothing goes stale.

Delete the two `EXAMPLE` entries before you push.

---

## Adding a publication

`data/publications.yaml`, one stanza, same session you publish the piece:

```yaml
- title: "Å gå god for"
  venue: "Samtiden"
  year: 2026
  kind: essay          # essay | academic | report | chapter | broadcast
  featured: true       # front page; keep to five or six
  url: ""              # empty renders unlinked, right for paywalls
```

The list is shared between both languages — a Norwegian essay has one title, in
Norwegian, on both. Only the section headings translate.

---

## Two traps

**YAML reads bare `no` as false.** The language key in `hugo.yaml` is written
`"no":` with quotes. Remove them and Hugo silently builds a language called
"false" and mangles the site. Leave the quotes.

**Indentation is meaningful** in `.yaml` files. Two spaces, never a tab. If a
build fails after you edit one, this is why.

---

## Search

Ranking for your name is not competitive; the work is entity consolidation.

1. Fill in `sameAs`. This is the highest-leverage thing on the site.
2. Google Search Console: add the domain, verify by DNS TXT record, submit
   `https://paulbuvarp.com/sitemap.xml`.
3. Ask FFI to link the site from your staff page. A `.no` institutional link is
   the strongest inbound link available to you and costs one email.
4. hreflang tags are already in place on every page, reciprocal and validated,
   with `x-default` pointing at English. This is what lets Google serve the
   Norwegian page to a Norwegian search and the English page to an English one,
   before the click, while keeping both indexed.
5. The concept pages are the long game. Nobody is competing for "tertiær
   oralitet".

---

## Structure

```
hugo.yaml                    config, identity, contact, portrait
data/publications.yaml       writing index, both languages
data/talks.yaml              upcoming and past talks
content/
  _index.no.md / .en.md      front pages
  contact.no.md / .en.md
  talks.no.md / .en.md
  writing.no.md / .en.md
  concepts/                  four concepts, two languages each
  notes/                     empty, deliberately
i18n/no.toml, en.toml        interface words
layouts/                     ten templates, no theme
assets/css/main.css          one stylesheet
static/fonts/                Fraunces + Spectral, subset, self-hosted
static/img/                  portrait goes here
static/robots.txt            a decision about AI crawlers awaits you
```
