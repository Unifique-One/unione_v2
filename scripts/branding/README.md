# Nextcloud branding scripts — UNIFIQUE ONE

Scripts that apply and verify the UNIFIQUE ONE identity inside the Nextcloud
container. Visual values come from `/opt/unione/pt/unione.md` and the branding
scope from `/opt/unione/pt/domain.md`.

## Files

| File | Purpose |
| --- | --- |
| `apply-nextcloud-branding.sh` | Idempotent application of theming, apps, default app and CSS staging. Writes `apply.log`. |
| `verify-nextcloud.sh` | Read-only check of container state, `occ status`, theming values, enabled apps and default app. |
| `apply.log` | Append-only action log created by the apply script (timestamped INFO/WARN lines plus raw command output). |

## Assumptions

* The Nextcloud container is named `unione-nextcloud` and is running.
* `/opt/unione/branding` is mounted **read-only** into the container at `/mnt/branding`.
* `php occ` is available in the container and is executed as `www-data`:
  `podman exec -u www-data unione-nextcloud php occ ...`.
* The scripts are executed on the host, where `podman` is available.

## Usage

```bash
bash /opt/unione/scripts/branding/apply-nextcloud-branding.sh
bash /opt/unione/scripts/branding/verify-nextcloud.sh
```

`verify-nextcloud.sh` prints `Result: PASS` (exit 0) or `Result: FAIL` (exit 1).

## What the apply script does

1. Verifies the container is running; aborts with a warning if it is not.
2. Sets these `theming` app values via `occ config:app:set theming <key> --value=...`,
   skipping writes when the value is already correct:
   * `name` = `UNIFIQUE ONE`
   * `slogan` = `Plataforma corporativa unificada`
   * `logo` = `/mnt/branding/assets/logos/unifique-one-light.svg`
   * `favicon` = `/mnt/branding/assets/favicons/favicon-32x32-01e518e661.png`
   * `icon` = `/mnt/branding/assets/favicons/apple-touch-icon-c435f4f4da.png`
   * `color` = `#212492`
   * `font` = `Plus Jakarta Sans`
   * `background` = `/mnt/branding/assets/images/login-background.svg` — **optional**:
     skipped with a warning when the asset is absent in the container.

   The favicon/icon files are the official assets downloaded from
   `https://unifique.com.br/` by `scripts/branding/fetch-official-icons.py` and stored in
   `/opt/unione/branding/assets/favicons/`; `favicon.svg` is a legacy fallback only.

3. Enables these apps individually with `occ app:enable`, in order:
   `files`, `photos`, `calendar`, `contacts`, `talk`, `deck`, `notes`, `tasks`,
   `forms`, `whiteboard`, `office`, `mail`, `assistant`.
   Already-enabled apps are left untouched. A missing/unsupported app produces a
   warning and the loop continues; it does **not** abort the run.
4. Sets the default app with `occ config:system:set defaultapp --value=files`.
5. If `/mnt/branding/themes/*.css` contains at least one file, copies those files
   into the documented staging directory
   `/var/www/html/custom_apps/unifique-theme/css` **inside the container**.
   If no CSS is present, the step is skipped with a warning. Nextcloud core is
   never edited.

The script never removes legal notices, license texts, security warnings or
technical credits.

## Idempotency and safety notes

* Theming values and `defaultapp` are read first and only written when different.
* `app:enable` is only attempted for apps not already listed as enabled.
* Re-running is safe: the outcome does not depend on how many times it ran.
* All changes use supported `occ` configuration; no database or core file is
  edited directly. No Docker/Podman image is rebuilt or replaced.
* The CSS copy is additive (`cp -f` into the staging directory); nothing is
  deleted from the source read-only mount.

## Caveats

* Copying CSS into the staging directory **does not by itself activate** a
  Nextcloud theme. A proper custom theme app (with `appinfo/info.xml` and a
  registration hook for its stylesheets) is required for those files to be
  loaded; this script deliberately limits itself to safe staging and does not
  fabricate a theme app. Do not place overrides in Nextcloud core.
* App availability depends on the installed Nextcloud edition/version and which
  apps are shipped or downloaded. Warnings in `apply.log` identify anything that
  could not be enabled; `verify-nextcloud.sh` reports the resulting state.
* The background image is optional. If the asset is missing, the login
  background stays at its previous value and a warning is logged.
* Some commercial apps (for example Office/Assistant integrations) may require
  separate licensing or additional setup beyond `occ app:enable`.
* The verification script is read-only and does not write to `apply.log`.
* These scripts do not touch Cloudflare, DNS, tunnels, or any external service.
