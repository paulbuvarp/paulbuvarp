# Event schema fix, Person @id, and generated share cards

Six files. `layouts/talks.html` is untouched — the Event partial keeps its old
name, so the call on line 2 still works.

    layouts/partials/event-schema.html   replaces
    layouts/partials/schema.html         replaces  (one line added)
    layouts/partials/head.html           replaces  (one line changed)
    layouts/partials/ogimage.html        NEW
    assets/og/base.png                   NEW  (1200x630, paper colour)
    assets/fonts/README.txt              NEW  (instructions, no font included)
    data/talks.yaml                      replaces (one field per entry)

## Part one — the Search Console warnings

`event-schema.html` is rewritten in place rather than replaced by a new file,
so nothing else needs rewiring.

**endDate** is now always present. Single-day talks end the day they start;
`until` still handles multi-day. That was the warning.

**organizer.url** is emitted when an entry has the new `organizerURL` field.
I filled in four and marked them CONFIRM — Nordforsk, UiA, Medietilsynet, Folk
og Forsvar. Three I left blank rather than guess: Fredssentrene, EDDA, and the
Utdanningsforbundet / Norsk Journalistlag pairing, which is two organisations
in one string and wants splitting if you care about it.

**Your organiser fallback is kept.** `or .organizer .event` was the right call
and I had dropped it in my first draft; Sikkerhetsfestivalen correctly comes
out as its own organiser because of it.

**location** now names the city rather than the festival. A festival is not a
place, and the previous markup was asserting you could stand in Arendalsuka.
The festival name is still on the visible page.

**Past talks are now included**, because the page shows them and markup should
describe the page. To go back to upcoming-only, uncomment the two lines near
the top of the partial.

Still deliberately absent: `offers` and `image`, which exist for ticketed
commercial events. `description` appears if an entry carries a `summary`
field. Those three will keep showing as non-critical. Let them.

## Part two — the thing that actually helps

`schema.html` gains `"@id": "https://paulbuvarp.com/#person"`, identical on
both language homepages, and every event now names that identifier as its
performer instead of describing a second, unconnected Person.

Eight Arendalsuka appearances stop being eight name strings for Google to
reconcile and become eight events attached to the entity that already carries
your ORCID, your FFI affiliation and your St Andrews doctorate.

## Part three — share cards

`head.html` previously gave every page on the site the same `og-default.png`,
so your BBC essay and your contact page shared a face in every feed, Slack
unfurl and LinkedIn post. One line now calls `ogimage.html`, which returns:

1. an explicit `image:` from the page's front matter, if set; otherwise
2. a card generated at build time from the page's own title; otherwise
3. `og-default.png`, exactly as before.

The card is your paper colour, the section name in muted caps above, the title
in spruce, the domain at the foot. Titles wrap to a maximum of four lines.
Generated per page and per language, so the Norwegian and English versions of
a page get their own.

**Step 2 needs a font you do not yet have.** Hugo's text filter reads TTF and
OTF, not the woff2 files in `static/fonts`. Download Spectral from Google
Fonts, take the regular weight, rename it `spectral.ttf`, and put it in
`assets/fonts/`. Until then everything falls through to og-default.png and
nothing breaks — which means this is safe to install today and finish later.

## Verified

Built with Hugo 0.148.2 extended against your actual `layouts` folder.

- one JSON-LD block on the talks page, not two
- eight events, valid JSON, all with name, startDate, location, endDate
- performer @id matches the Person @id on both homepages
- blank organizer falls back to the event name
- cards generated per page and per language; long Norwegian titles wrap
- with no font present, every page falls back cleanly to og-default.png

Two bugs found while building, both of which would have reached you:

`.File` is nil on the 404 page and on taxonomy pages, and reaching for
`.File.TranslationBaseName` there kills the entire build, not just that page.
Card filenames now come from the permalink instead.

`strings.Trim` takes its string first, so `.RelPermalink | strings.Trim "/"`
silently reverses the arguments and returns an empty string — every page got
the same card and the build reported no error at all. Written out longhand now.

After deploying, run the talks page through Google's Rich Results Test and
click Validate Fix in the Search Console report. Revalidation takes a couple
of weeks on Google's schedule.
