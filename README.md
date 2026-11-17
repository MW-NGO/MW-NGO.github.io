# Salima Youth Leadership Initiative — website

A complete, multi-page website for **Salima Youth Leadership Initiative (SYLI)**, a youth-led
community organisation in Salima, Malawi.

It is plain HTML, CSS and JavaScript. No build step, no framework, no monthly bill. You can open
it on a laptop, put it on GitHub Pages, or drag the folder onto Netlify.

There is also an optional free backend so the team can add projects, members and stories from a
phone without touching code — see **[SUPABASE.md](SUPABASE.md)**. Until it is connected, the site
runs entirely from the files in this folder.

> **Together we lead, together we change Salima.**

---

## 1. What is in the box

| Page | File | What it does |
| --- | --- | --- |
| Home | `index.html` | Hero, mission, featured projects, team, latest stories |
| About | `about.html` | Story, mission, vision, values, the challenge, how we work, logo meaning |
| Projects | `projects.html` | All projects, filters, search, project reader, **project studio** |
| Team | `team.html` | Leadership, wider team, filters, full directory, member profiles |
| Stories | `articles.html` | Featured story, categories, article grid, **story studio** |
| Single story | `article.html` | Reading page with four layouts, reading progress, sharing |
| Get involved | `get-involved.html` | Volunteer, mentor, partner, support — each with its own section |
| Contact | `contact.html` | Contact form, Messenger fallback, FAQ |
| Not found | `404.html` | Friendly page for GitHub Pages / Netlify |
| Content studio | `admin.html` | Sign-in page for the team; add and edit projects, members and stories (needs Supabase) |

Everything is responsive: phones, tablets, laptops and large screens.

```
salima-youth-leadership-initiative/
├─ index.html · about.html · projects.html · team.html
├─ articles.html · article.html · get-involved.html · contact.html · 404.html
├─ admin.html            ← team content studio (needs Supabase)
├─ css/
│  ├─ style.css
│  └─ admin.css          ← only loaded by admin.html
├─ js/
│  ├─ config.js          ← your Supabase URL + anon key (empty = offline mode)
│  ├─ backend.js         ← loads Supabase, fetches content, login, uploads
│  ├─ data.js            ← the organisation's content (fallback + seed)
│  ├─ local-content.js   ← content published from the browser studios (optional)
│  ├─ site.js            ← shared behaviour, content store, contact form
│  ├─ projects.js        ← project listing, modal and browser studio
│  ├─ team.js            ← team page
│  ├─ articles.js        ← story listing, studio and single-story renderer
│  └─ admin.js           ← the content studio app
├─ supabase/
│  ├─ schema.sql         ← run once: tables, permissions, photo bucket
│  └─ seed.sql           ← run once: loads the current projects, team and stories
├─ assets/
│  ├─ photos/            ← real photos from the Facebook page
│  └─ icons/             ← emblem, favicon, social preview image
└─ README.md · SUPABASE.md · HOSTING.md · .gitignore
```

---

## 2. Look at it locally

Opening `index.html` by double-clicking works for most things, but a tiny local server is better
(it behaves exactly like the live site).

With Python installed:

```powershell
cd salima-youth-leadership-initiative
python -m http.server 8000
```

Then visit <http://localhost:8000>.

Or use the **Live Server** extension in VS Code: right-click `index.html` → *Open with Live Server*.

---

## 3. Change the content

There are two ways, and you pick one:

| | **With Supabase** (recommended for a team) | **Without a backend** |
| --- | --- | --- |
| Who edits | Anyone you create an account for | Only you, on one browser |
| How | `admin.html`, on any phone or computer | “Add a project” / “Write a story” buttons |
| Where it is saved | Hosted database + photo storage | `localStorage`, then exported and pasted into a file |
| Appears for visitors | Immediately | After you commit the exported file |
| Setup | About 10 minutes, once — [SUPABASE.md](SUPABASE.md) | None |

If `js/config.js` has a project URL and anon key, the site uses Supabase and hides the public
studio buttons. If it is empty, the site runs entirely from `js/data.js` plus the browser studios,
exactly as it did before the backend existed.

### With Supabase — `admin.html`

1. Follow **§1 of [SUPABASE.md](SUPABASE.md)** once: create the project, run
   `supabase/schema.sql` and `supabase/seed.sql`, create an account per editor, paste the URL and
   anon key into `js/config.js`.
2. Open `/admin.html`, sign in, and use the **Projects**, **Team** and **Stories** tabs.
3. For each item: fill in the fields, upload photos (resized automatically), choose whether it is
   **featured** and **published**, then **Save**.

That is the whole workflow. No Git, no exports, no rebuild. Publishing a hidden item is just
ticking “Show on the public site”.

> The anon key in `js/config.js` is meant to be public; row-level security limits it to reading
> published rows. **Never** put the `service_role` key in the website.

### Without a backend — `js/data.js` and the browser studios

This one file holds the organisation's public information:

- `org` — name, tagline, location, **email**, **phone**, WhatsApp, Facebook and Messenger links.
- `mission`, `vision`, `values`, `challenges`, `approach`
- `team` — members, roles, photos, bios, quotes
- `projects` — title, status, summary, description, photos, highlights
- `articles` — stories, categories, layouts and bodies
- `partners` — who the organisation works with

Every list is a normal JavaScript array. Copy an item, paste it at the **top** of the list amounts
to "publish this first", give it a unique `slug`, and save. No build, no command line.

**Photos:** put files in `assets/photos/` and reference them as `"assets/photos/name.jpg"`.
Keep images around 1600 px wide and under ~400 KB where possible. The studios resize uploads
automatically (max 1400 px, JPEG quality 0.82), but files added by hand are not processed.

### Contact details

The Facebook page currently publishes **only Messenger** — no email address or phone number.
The site is therefore built to hide empty contact fields instead of inventing them:

```js
email: "",       // e.g. "hello@salimayouth.org"
phone: "",       // e.g. "+265 999 000 000"
whatsapp: "",    // digits only, e.g. "265999000000"
```

Fill any of them in and it appears automatically in the footer, the contact page and the form
logic. **If email is blank, the contact form validates the message and hands it to Messenger**
(copy the message, open `m.me/...`) rather than pretending to send mail.

> A static site cannot send email by itself. If you want the form to send real email, connect a
> free form service (Formspree, Basin, Getform) or a small serverless function, then replace the
> fallback in `initContactForm()` inside `js/site.js`.

### The browser studios (no-backend mode)

If no Supabase is configured, the Projects page has **Add a project** and the Stories page has
**Write a story**. Both open a guided studio designed for non-technical members:

- **Projects:** four steps — basics, photos (up to 8, drag-and-drop, automatic resizing, choose
  the cover), the story, review. It refuses to publish without a name, a one-sentence summary,
  at least one photo and a real description. Long descriptions and photo strips become
  scrollable instead of stretching the layout.
- **Stories:** headline, standfirst, byline, date, cover photo, tags, body, and four real layouts
  (Feature, Interview, Photo essay, Field note) with a **live preview**. Body formatting is
  deliberately small: `## heading`, `> pull quote`, `- list item`, `**bold**`, `*italic*`,
  `![caption](image)`.
- **Members:** in no-backend mode, edit them in `js/data.js` (name, role, group, photo, bio,
  quote). With Supabase they are edited in `admin.html` like everything else.

**Where studio content lives:** in the browser's `localStorage` (key `syli.content.v1`). It is
visible immediately, but only on that browser and device. That is the honest limitation of a
site with no database.

**To publish studio content for everyone:**

1. In the studio, click **Download all site content** (or **Download backup** on the story studio).
2. Open the downloaded `syli-content.json`.
3. Paste its contents into `js/local-content.js`:

   ```js
   window.SYLI_LOCAL = {
     projects: [ /* paste the "projects" array here */ ],
     articles: [ /* paste the "articles" array here */ ],
     members:  [ /* paste the "members" array here */ ]
   };
   ```

4. Upload/commit the changed `js/local-content.js` with the site.

`js/local-content.js` is loaded before `site.js`; content there behaves like edited `data.js`
content (it is not marked "draft"). Duplicate slugs are ignored, so a browser draft will not
show twice.

**Restore / move a browser:** the studio also has **Restore from a backup**. It replaces the
browser's stored content with the uploaded JSON.

---

## 4. Put it online

Full details, including the "one GitHub account, many NGOs" question, are in
**[HOSTING.md](HOSTING.md)**. The short version:

### GitHub Pages (free)

1. Create a **public** repository, e.g. `salima-youth-website`.
2. Upload the contents of this folder (not the folder itself) to the repository root.
3. Repository **Settings → Pages → Build and deployment**:
   - Source: **Deploy from a branch**
   - Branch: **main**, folder: **/ (root)**
4. Wait a minute. The site appears at:

   `https://YOUR-USERNAME.github.io/salima-youth-website/`

Every page uses relative links, so it works from a subfolder without changes.

### Netlify Drop (free, no account needed to start)

Go to <https://app.netlify.com/drop>, drag this folder onto the page, and you get a live URL.
Claim the site if you want to keep it and rename it.

### Custom domain

Add a `CNAME` file containing the domain (e.g. `salimayouth.org`) or set it in the Pages
settings, then point the domain's DNS at GitHub. HTTPS is automatic once DNS is correct.

### Before going live

- Replace the placeholder-free contact fields with real ones when available.
- Update every page's `<meta property="og:image">` from `assets/icons/og-image.jpg` to a full
  URL (`https://your-domain/assets/icons/og-image.jpg`) so Facebook/WhatsApp show the preview.
- Check the Facebook/Messenger links still point at the right page.
- Read the note in `HOSTING.md` about public repositories and personal data.

---

## 5. House rules (so future-you is not angry)

- **Never invent a statistic, quote or member.** The site is deliberately written to say "we do
  not have a verified figure yet" rather than borrow one.
- **Ask before publishing a face.** The photo checklist in the project studio says this; it also
  applies to stories and the team page.
- **Keep photos small.** Big uploads are resized in the studio, but hand-added files should be
  compressed first.
- **Do not put private information in a public repository.** Public GitHub Pages repositories are
  public, including their history.
- **A browser is not a database.** Without Supabase, two people editing two browsers never merge.
  With Supabase, everyone edits the same hosted records — so use it if more than one person
  publishes.
- **Test on a phone.** The layout is responsive, but real thumbs are the best QA.

---

## 6. If you are handing this to a developer

The content store is in `js/site.js` (`store.projects()` etc.). It returns database rows when
`window.SYLI_BACKEND.active` is true, and the bundled arrays in `js/data.js` otherwise. Pages
subscribe with `SYLI_UI.onContent(fn)` so they re-render if the database answers after first
paint. The schema, permissions and storage bucket are all in `supabase/schema.sql`; there is no
server to run.

---

## 7. Credits

Design and build: made for SYLI, with real content and photos from the organisation's public
Facebook page. Fonts: Poppins, Inter and Fraunces (Google Fonts, open licence). Icons: hand-written
inline SVG. No stock photography, no tracking scripts, no cookies.
