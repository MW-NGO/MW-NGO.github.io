# Hosting many NGO websites from one GitHub account

## Current deployment (live)

| What | Value |
| --- | --- |
| GitHub account | `MW-NGO` (personal account) |
| Repository | `MW-NGO/MW-NGO.github.io` — public, branch `main` |
| Pages type | **User site** (the special `<account>.github.io` repository) |
| Public URL | **https://mw-ngo.github.io/** |
| Team sign-in | **https://mw-ngo.github.io/admin.html** |
| Pages source | Deploy from a branch → `main` → `/ (root)` |

Because this account's user-site repository is already taken by SYLI, the site sits at the root
address. Future NGO sites can be added in either of two ways:

1. **A folder in this repository** — put the next site in `mangochi/`, `lilongwe/`, etc. It will
   appear at `https://mw-ngo.github.io/mangochi/`. One repository to push, one deployment to wait
   for, one backup. Simplest while one person maintains everything.
2. **A separate repository per NGO** — e.g. `MW-NGO/mangochi-youth`. It appears at
   `https://mw-ngo.github.io/mangochi-youth/`. Best when an NGO should later take the repository
   with them, or wants its own custom domain.

If the collection grows, the cleanest end state is to move this site into a `salima/` folder and
make the root a small hub page linking to each NGO. Nothing else needs to change: all links in the
site are relative.

**To publish an update to SYLI:** commit in the site folder and push to `main`. Pages rebuilds
automatically in under a minute.

---

Short answer to the general question: **yes.** One GitHub account can host many separate websites for free, because
GitHub Pages is enabled **per repository**, and a free account can have unlimited public
repositories.

There is one small catch: **only one "user site" per account** (`username.github.io`). Every
other site is a "project site" with the repository name in the path
(`username.github.io/repo-name/`). If you want each NGO to have a clean address like
`salimayouth.org`, you point a domain at the project site — that is free and supported.

---

## The four workable patterns

### 1. One repository per NGO (recommended for giving sites away)

```
github.com/your-name/salima-youth-website      → your-name.github.io/salima-youth-website/
github.com/your-name/mangochi-youth-club       → your-name.github.io/mangochi-youth-club/
github.com/your-name/another-ngo               → your-name.github.io/another-ngo/
```

- Free, unlimited public repositories.
- Each NGO can later take the repository with them (transfer it to their own account or
  organisation) without touching the others.
- Each site can have its own custom domain.
- Separate histories, issues, collaborators and permissions.
- This is the pattern used by this folder.

**To add another NGO:** copy this folder, rename it, change `js/data.js`, create a new public
repository, upload, enable Pages. Ten minutes per site.

### 2. One repository, many folders (a "hub" site)

```
ngo-sites/
├─ index.html          ← a simple page linking to each NGO
├─ salima/
├─ mangochi/
└─ another-ngo/
```

With Pages set to the repository root, the sites live at:

```
your-name.github.io/ngo-sites/salima/
your-name.github.io/ngo-sites/mangochi/
```

- One repository to maintain and back up.
- One custom domain for the hub; the individual NGOs get sub-paths, not their own domains unless
  you use a reverse proxy or separate hosting.
- A mistake in one folder can break the deploy for everyone.
- Good for a personal portfolio of give-away projects; less good for organisations that need
  independence.

### 3. One repository, deployed many times (Netlify / Cloudflare Pages)

Keep a single monorepo and connect it to several Netlify or Cloudflare Pages projects, each with
a different **base directory** / build output folder. Each gets its own free subdomain and its own
custom domain.

- Excellent for a shared design system and easy updates.
- Still free at small NGO scale.
- More dashboards to manage than one-repository-per-site.
- Netlify Drop is the fastest route: drag a folder, get a URL, claim it later.

### 4. GitHub Organisation accounts

If the work is bigger than a personal side project, create a free **GitHub Organisation** for the
give-away programme (e.g. `salima-youth-sites`) and keep the repositories there. You can invite
maintainers, and each NGO can be transferred out later. GitHub's free plan includes unlimited
public repositories and Pages for public repositories; private-repository Pages needs a paid plan.

---

## GitHub Pages limits (free)

- **Repository must be public** on a free personal account for Pages to be available. Anything in
  the repository — including old commits — is public.
- **1 GB** published site size (soft limit).
- **100 GB per month** bandwidth (soft limit).
- **10 builds per hour** (soft limit; irrelevant for plain static sites).
- **No server-side code.** No PHP, no database, no email sending, no secret API keys.
- **One custom domain per Pages site.** HTTPS is automatic once DNS is correct.
- **One user site** (`username.github.io`); all other repositories are project sites.

For small NGO sites with a handful of photos and low traffic, these limits are generous.

---

## Step by step: a new NGO site

1. **Prepare the folder.** Duplicate the SYLI folder. Rename it to the NGO's short name.
2. **Replace the content.** Edit `js/data.js` (organisation, contacts, team, projects, stories).
   Replace the photos in `assets/photos/` and the icons in `assets/icons/`. Keep `js/local-content.js`
   empty until there is studio content to publish.
3. **Test locally.** `python -m http.server 8000` and click through every page.
4. **Create the repository.** On GitHub: **New repository** → public → no README (you already have
   one). Name it clearly, e.g. `salima-youth-website`.
5. **Upload.** Either drag the folder contents into the GitHub web uploader, or:
   ```powershell
   git init
   git add .
   git commit -m "Initial SYLI website"
   git branch -M main
   git remote add origin https://github.com/YOUR-NAME/salima-youth-website.git
   git push -u origin main
   ```
6. **Enable Pages.** Settings → Pages → Source: *Deploy from a branch* → Branch `main`, folder
   `/ (root)` → Save.
7. **Visit** `https://YOUR-NAME.github.io/salima-youth-website/`. Add that link to the NGO's
   Facebook page.
8. **Optional custom domain.** Buy/borrow a domain, add it in Settings → Pages → Custom domain,
   create the DNS records GitHub shows, wait for the certificate, then enable *Enforce HTTPS*.
   Add a `CNAME` file with the domain to keep it through redeploys.

### Sharing ownership with the NGO

- **Transfer** the repository to the NGO's own GitHub account or organisation when they are ready
  (Settings → General → Danger Zone → Transfer). The Pages URL changes if the account name changes;
  a custom domain does not.
- Or keep it under your account and add them as a collaborator. Transfer is better for trust and
  continuity.
- Give them a zip of the site and the `syli-content.json` backups as well. Never let a small NGO's
  only copy of their website live in one volunteer's account.

---

## Things to be careful about when giving sites away

1. **Public means public.** Do not commit volunteer ID numbers, private phone numbers, home
   addresses, safeguarding case notes, passwords, or API keys. Use role inboxes, not personal ones.
2. **Free hosting is not a service-level agreement.** GitHub Pages is reliable, but it is not a
   contract. Keep a local copy and a zip backup.
3. **A domain is the only thing that is truly portable.** If the NGO cares about its address, help
   them own the domain (and the registrar account), not you.
4. **Photos and consent.** A public repository can be forked and archived. Only publish photos where
   the people in them have agreed. The studio's photo checklist says this; enforce it.
5. **No fake contact details.** This site hides empty email/phone fields and falls back to Messenger.
   Keep that behaviour rather than inventing an address that nobody reads.
6. **Handover matters more than code.** Write down: who owns the GitHub account, who owns the
   domain, where the photos are, how to add a project, and how to restore a backup. The README is
   written to be that document.

---

## Which pattern should you choose?

| Situation | Use |
| --- | --- |
| A handful of NGOs, each wants independence | **One repository per NGO** |
| A personal portfolio of give-away sites | One repository with folders + hub page |
| Shared design, one maintainer, many sites | Monorepo + Netlify/Cloudflare projects |
| An ongoing programme with helpers | GitHub Organisation + one repo per NGO |

For the Salima site specifically: it already runs as the **user site** of the `MW-NGO` account —
one public repository, `MW-NGO/MW-NGO.github.io`, Pages from `main` / root, at
<https://mw-ngo.github.io/>. Add future NGOs as folders in that repository or as separate
repositories, and point a custom domain at this one when the organisation wants it. That is the
simplest thing that can survive a change of volunteer.
