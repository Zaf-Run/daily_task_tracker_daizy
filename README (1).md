# Flow: Personal Planner (Supabase + installable app)

Files: index.html, config.js, sw.js, manifest.webmanifest, two icons, schema.sql.

## Setup (about 10 minutes)
1. Create a free project at supabase.com.
2. Open SQL Editor, paste all of schema.sql, run it. This creates the tables and locks each row to its owner.
3. Open Authentication > Providers and keep Email enabled (magic link sign in).
4. Open Project Settings > API. Copy the Project URL and the anon public key into config.js.
5. Upload this whole folder to any HTTPS static host (Netlify, Vercel, Cloudflare Pages, GitHub Pages).
6. Open Authentication > URL Configuration. Set Site URL to your hosted address and add it under Redirect URLs.
7. Visit your site, enter your email, open the link you receive. You are in.

## Install on your phone or laptop
Chrome and Edge: use the install icon in the address bar. iPhone Safari: Share, then Add to Home Screen.

## Moving your data from the earlier version
In the old page, Settings > Export backup. In the new app, Settings > Restore, choose that file. It uploads to your account.

## Notes
Reminders fire while the app is open or running in the background on your device. Fully closed apps need server push, which is not included.
Task categories are the tags on your tasks, so they have no separate table.
Sync is last write wins. Edits made offline upload when you reconnect.
