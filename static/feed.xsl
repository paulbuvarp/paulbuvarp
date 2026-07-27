<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name="robots" content="noindex"/>
        <title><xsl:value-of select="/rss/channel/title"/> — RSS</title>
        <style>
          @font-face { font-family: "Spectral"; src: url("/fonts/spectral-regular.woff2") format("woff2"); font-weight: 400; font-style: normal; font-display: swap; }
          @font-face { font-family: "Spectral"; src: url("/fonts/spectral-italic.woff2") format("woff2"); font-weight: 400; font-style: italic; font-display: swap; }
          @font-face { font-family: "Fraunces"; src: url("/fonts/fraunces-display.woff2") format("woff2"); font-weight: 400; font-style: normal; font-display: swap; }
          :root { --paper:#edede7; --ink:#191c19; --rule:#c9c9c0; --muted:#6a6e67; --mark:#2e4b3c; --tint:rgba(46,75,60,.09); }
          @media (prefers-color-scheme: dark) { :root { --paper:#141714; --ink:#e2e3dd; --rule:#35392f; --muted:#9aa094; --mark:#8fb69c; --tint:rgba(143,182,156,.12); } }
          * { box-sizing: border-box; }
          body { margin:0; background:var(--paper); color:var(--ink); font-family:"Spectral",Georgia,serif; font-size:1.1rem; line-height:1.6; -webkit-font-smoothing:antialiased; }
          .wrap { max-width:34rem; margin:0 auto; padding:4rem 1.5rem 5rem; }
          h1 { font-family:"Fraunces",Georgia,serif; font-weight:400; font-size:2rem; line-height:1.24; letter-spacing:.012em; margin:0 0 .5rem; }
          .eyebrow { font-size:.72rem; letter-spacing:.18em; text-transform:uppercase; color:var(--muted); margin:0 0 .35rem; }
          .note { background:var(--tint); border:1px solid var(--rule); border-radius:3px; padding:1rem 1.25rem; font-size:.94rem; color:var(--ink); margin:2rem 0 2.5rem; }
          .note p { margin:0 0 .6rem; }
          .note p:last-child { margin:0; }
          code { font-family:ui-monospace,Menlo,monospace; font-size:.85em; background:var(--paper); border:1px solid var(--rule); border-radius:2px; padding:.1em .4em; word-break:break-all; }
          a { color:var(--mark); text-decoration:none; border-bottom:1px solid var(--rule); }
          a:hover { border-bottom-color:var(--mark); }
          ul { list-style:none; margin:0; padding:0; }
          li { border-top:1px solid var(--rule); padding:1rem 0; }
          .t { font-size:1.05rem; margin:0 0 .2rem; }
          .d { font-size:.86rem; color:var(--muted); margin:0; }
          .date { font-size:.72rem; letter-spacing:.1em; text-transform:uppercase; color:var(--muted); display:block; margin-bottom:.2rem; }
          footer { margin-top:3rem; border-top:1px solid var(--rule); padding-top:1.25rem; font-size:.84rem; color:var(--muted); }
        </style>
      </head>
      <body>
        <div class="wrap">
          <p class="eyebrow">RSS</p>
          <h1><xsl:value-of select="/rss/channel/title"/></h1>

          <div class="note">
            <p>This is a feed. It is meant for a reader application rather than for a browser, which is why it looks like this without a stylesheet.</p>
            <p>To subscribe, copy this address into your reader:</p>
            <p><code><xsl:value-of select="/rss/channel/atom:link/@href"/></code></p>
          </div>

          <ul>
            <xsl:for-each select="/rss/channel/item">
              <li>
                <span class="date"><xsl:value-of select="substring(pubDate, 1, 16)"/></span>
                <p class="t"><a><xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute><xsl:value-of select="title"/></a></p>
                <p class="d"><xsl:value-of select="description"/></p>
              </li>
            </xsl:for-each>
          </ul>

          <footer>
            <a><xsl:attribute name="href"><xsl:value-of select="/rss/channel/link"/></xsl:attribute>
              <xsl:value-of select="/rss/channel/title"/>
            </a>
          </footer>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
