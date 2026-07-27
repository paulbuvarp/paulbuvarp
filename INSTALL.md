# Installing this version

This replaces everything. Do it in this order.

## 1. Rescue anything you have already edited

If you changed the biography or added real publications, copy those files
somewhere safe first — `content/_index.md` and `data/publications.yaml` are the
likely ones. You will paste the text back afterwards.

## 2. Delete two folders from your repo

In your cloned repo folder, delete:

- the whole `content` folder
- the whole `layouts` folder

Deleting `content` is necessary rather than tidy: the English files have been
renamed from `_index.md` to `_index.en.md`, and copying over the top would leave
the old ones behind, where Hugo would read them as Norwegian.

## 3. Copy this version in

Copy the *contents* of the `paulbuvarp` folder in this zip into your repo folder.
Overwrite when asked. Same trap as before: what is inside the folder, not the
folder itself.

## 4. Check GitHub Desktop

It should show a batch of additions and deletions, including deleted files named
`content/_index.md`, `content/writing.md` and `content/concepts/*.md`, and added
files with `.en.md` and `.no.md` suffixes. That is correct.

## 5. Commit and push

Summary: "Norwegian version, contact, talks". **Commit to main** → **Push origin**.

## 6. Then, in `hugo.yaml`

- `contactUser` — your Cloudflare Email Routing alias
- `formspreeID` — from formspree.io
- `sameAs` — LinkedIn, Facebook, FFI, Scholar, ORCID, Bluesky
- `portrait` — after you have put the file at `static/img/portrait.jpg`

And delete the two `EXAMPLE` entries in `data/talks.yaml`.

See README.md for all of it in detail.
