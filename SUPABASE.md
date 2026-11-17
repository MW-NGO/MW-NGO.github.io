# The content backend (Supabase)

The public website is static: HTML, CSS and JavaScript on GitHub Pages or Netlify. That is
cheap and fast, but a static site cannot store what your team types into it.

So content lives in **Supabase**, a free hosted database with logins and photo storage.
`admin.html` is the page your team uses. When someone saves there, the public site shows the
change on the next page load — on every phone and computer, with no export, no rebuild and no
GitHub knowledge.

```
editor's phone ──> admin.html ──> Supabase (database + photos)
                                      │
visitor's phone ──> public pages ─────┘  (read-only, published rows only)
```

If Supabase cannot be reached, the public site quietly falls back to the bundled content in
`js/data.js`. A paused project or a bad connection never leaves you with a blank website.

---

## 1. One-time setup (about 10 minutes)

### a. Create the project

1. Go to <https://supabase.com> and sign in (GitHub login is fine).
2. **New project**. Give it a name like `syli-website`.
3. Choose a region near Malawi — **EU (Frankfurt)** or **EU (London)** are reasonable.
4. Save the database password somewhere safe. You will not need it for the website, but you
   will need it if you ever restore a backup.
5. Wait for provisioning to finish (a minute or two).

### b. Create the tables

1. In the left sidebar open **SQL Editor** → **New query**.
2. Open `supabase/schema.sql` from this folder, copy all of it, paste it in, and press **Run**.
3. You should see “Success. No rows returned”.
4. Repeat with `supabase/seed.sql`. This loads the current projects, team and stories so the
   site does not go empty when you switch over.

Running either file again is safe: `schema.sql` is idempotent and `seed.sql` skips rows that
already exist.

### c. Create editor accounts

1. Go to **Authentication → Users → Add user**.
2. Enter the person's email and a password. Turn **Auto Confirm User** on (otherwise they
   cannot sign in until they confirm an email).
3. Repeat for each person who should edit the site.

There is deliberately **no public sign-up** on `admin.html`. An account only exists because
you created it. To remove someone's access, delete or disable their user.

### d. Connect the website

1. Open **Project Settings → API**.
2. Copy **Project URL** and the **anon public** key.
3. Paste them into `js/config.js`:

   ```js
   window.SYLI_CONFIG = {
     supabaseUrl: "https://abcdefghijkl.supabase.co",
     supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....",
     mediaBucket: "media"
   };
   ```

4. Upload/commit the changed file with the rest of the site.

The anon key is **designed to be public**. It only allows what the row-level security rules
permit: read published rows, and write only for signed-in users. It is safe in a public
repository.

> **Never** put the `service_role` key in the website or in `js/config.js`. It bypasses every
> security rule. If it is ever exposed, rotate it in the Supabase dashboard immediately.

### e. Try it

Open `https://your-site/admin.html` (or `http://localhost:8000/admin.html` while testing),
sign in, and add a test project. Reload the public projects page in another tab.

---

## 2. Editing content

`admin.html` has three tabs:

| Tab | What you can do |
| --- | --- |
| **Projects** | Name, status, category, one-sentence summary, full description, highlights, up to any number of photos (first is the cover), “featured”, “published”, position |
| **Team** | Name, role, group (Leadership / Executive / Volunteer / Honorary), studies or work, focus, biography, optional quote, optional public email, photo, featured, published |
| **Stories** | Headline, standfirst, category, byline, date, layout, tags, body, cover photo, featured, published |

Things worth knowing:

- **“Published” off** hides the item from the public site but keeps it in the admin list.
- **“Featured”** puts a project on the home page, a member in the leadership row, or a story
  at the top of the stories page.
- **Position** controls order within the list. Lower numbers come first.
- Photos are resized in the browser (max 1400 px, JPEG quality 0.82) before upload, so a phone
  photo does not eat the free storage.
- Story bodies use simple formatting:
  `## heading`, `> pull quote`, `- list item`, `**bold**`, `*italic*`, `![caption](image-url)`.
- Deleting is permanent. There is no recycle bin on the free plan — export a backup first if
  the content matters (see §6).

### A note on faces and quotes

The admin makes publishing easy, which makes it easy to publish something you should not. Keep
the house rules from the README: ask before publishing someone's photo, and never invent a
quote or a statistic.

---

## 3. What the public site does

- If `js/config.js` is empty, nothing changes: content comes from `js/data.js` and the
  browser-based studios work as before.
- If it is filled in, the database is the **source of truth**. `js/data.js` becomes the
  offline fallback and the seed for a new database.
- The public site only ever asks for `published = true` rows.
- The public “Add a project” and “Write a story” buttons are hidden automatically, because
  editing now happens in the admin page. The browser-studio code stays in the project but is
  dormant.

---

## 4. Security model

| Who | Can read | Can write |
| --- | --- | --- |
| Anyone on the internet (anon key) | published projects, members, stories; files in `media` | nothing |
| Signed-in editor | everything, including hidden rows | projects, members, stories, `media` files |
| `service_role` key | everything | everything — **never goes in the browser** |

Rules live in `supabase/schema.sql`, not in the JavaScript. Even if someone copies the anon
key from the public site, they cannot change or read unpublished content.

Additional advice:

- Use one account per person, not one shared login. When someone leaves, disable their user.
- Do not store private data (safeguarding notes, ID numbers, home addresses, phone numbers
  people did not agree to publish) in these tables. The database is not a case-management
  system.
- Keep the repository public only if you are comfortable with the photos and text being
  downloadable. GitHub Pages on a free account requires a public repository.
- Turn on **Point-in-Time Recovery** only if you later move to a paid plan; on the free plan
  rely on exports.

---

## 5. Free plan limits

Supabase's free tier is generous for a small NGO: roughly 500 MB of database, 1 GB of file
storage, 50,000 monthly active users, and a shared pool of egress. Exact numbers change; check
the current pricing page before promising anything.

Two practical limits matter more than the numbers:

1. **Free projects pause after about a week without activity.** Visitors still get the site
   (it falls back to `js/data.js`), but changes will not appear and the admin will not load
   until someone signs in to Supabase and resumes the project. If the site is actively used,
   this rarely happens; if it goes quiet for months, expect to click “Resume”.
2. **Storage is shared with photo uploads.** Resizing in the admin keeps this small, but a
   hundred full-size phone photos will still add up. Delete old photos you no longer use.

If you outgrow the free plan, the paid tier is per project and modest. Nothing in the website
needs to change.

---

## 6. Backups and moving out

- **Database:** Supabase dashboard → **Database → Backups** (paid plans) or
  **SQL Editor** and run `select * from projects;` etc., then download the CSV from the
  results grid. Repeat for `members` and `articles`.
- **Photos:** **Storage → media**, select the folder, download.
- **A full copy you control:** the seed file in `supabase/seed.sql` already contains the
  starting content, and every row is plain text. A CSV export plus the `media` folder is a
  complete backup.
- **Leaving Supabase:** the data is ordinary Postgres. Export it, import it anywhere, or ask a
  developer to point the site at another backend. Nothing is locked in.
- **A copy of the previous platform:** `js/data.js` still holds the content the site launched
  with. Do not delete it; it is the fallback.

---

## 7. Troubleshooting

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| `admin.html` still shows the setup card | `js/config.js` empty, not saved, or the browser cached the old file | Fill both values, hard-refresh (Ctrl/Cmd+Shift+R) |
| “Invalid login credentials” | User not created, wrong password, or email not confirmed | Authentication → Users; use **Add user** with Auto Confirm |
| “Could not reach Supabase” | No internet, wrong URL, project paused | Check Project Settings → API; resume the project in the dashboard |
| `relation "public.projects" does not exist` | `schema.sql` was not run | Run it in the SQL Editor |
| Photos fail to upload | `media` bucket or its policies missing; not signed in | Re-run `schema.sql`; check you are signed in |
| Saved content does not appear publicly | “Published” unchecked, or a cached page | Tick Published; hard-refresh the public page |
| Public site shows the old content | Supabase fetch failed, so the fallback is in use | Open the browser console; check the project is not paused |
| Two items with the same name | Slugs are unique | The admin appends `-2`; rename one if you prefer |
| Everyone can see hidden rows | You edited policies | Re-run the policy section of `schema.sql` |

---

## 8. What this does *not* do

- It does not send email from the contact form. The form still validates and hands off to
  Messenger (or `mailto:` if you fill in an address). A form service or serverless function is
  a separate, small job.
- It does not give visitors accounts. Only editors sign in.
- It does not replace GitHub Pages or Netlify. Hosting stays free and static; Supabase only
  serves content and photos.
