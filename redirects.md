# Redirects for ropensci-review-tools.readthedocs.io

Create these in the Read the Docs dashboard: project → **Admin → Redirects → Add redirect**, or with [`create_redirects.R`](create_redirects.R), which creates the redirects of sections 2 to 4 through the Read the Docs API:

```r
Sys.setenv (RTD_TOKEN = "xxx")
source ("create_redirects.R")
create_redirects ()             # dry run
create_redirects (apply = TRUE) # create
```

Settings for every redirect below:

- **Type:** Exact redirect
- **Force redirect:** on (otherwise a redirect only applies when the page returns a 404, and all these pages still exist)
- **HTTP status:** 301 (permanent)

The project only has one language and one version, so every page URL starts with `/en/latest/`.

**Order matters:** Read the Docs uses the first redirect that matches, in the order shown in the list. Create them in the order below, so that specific paths come before the generic ones and the catch-all comes last. You can reorder redirects in the dashboard if needed.

`:splat` in a "To URL" is replaced by whatever `*` matched in the "From URL". This sends function pages to the matching pkgdown reference page, and vignette pages to the matching pkgdown article. Pages built from Rd files have the same names as pkgdown reference pages, and vignettes have the same names as pkgdown articles.

## 1. Hand-written pages

| From URL | To URL |
|---|---|
| `/en/latest/overview.html` | `https://github.com/ropensci-review-tools` |
| `/en/latest/debugging/debugging.html` | `https://docs.ropensci.org/roreviewapi/articles/debugging.html` |
| `/en/latest/maintenance/ropensci-review-bot.html` | `https://docs.ropensci.org/roreviewapi/articles/admin-setup.html` |
| `/en/latest/maintenance/pkgcheck.html` | `https://docs.ropensci.org/roreviewapi/articles/admin-setup.html#controlling-which-checks-are-reported` |
| `/en/latest/maintenance/tokens.html` | `https://github.com/ropensci-review-tools/pkgcheck/blob/main/CONTRIBUTING.md` |
| `/en/latest/maintenance/pkgstats.html` | `https://github.com/ropensci-review-tools/pkgstats/blob/main/CONTRIBUTING.md` |
| `/en/latest/badges/badges.html` | `https://github.com/ropensci-org/badges` |

## 2. Packages with a pkgdown website

Three redirects per package: function pages, vignette pages, then everything else in the package's folder (the README-based home page).

I checked every function and vignette page of the old site against the pkgdown sites. All have a matching page, except three functions that no longer exist. These come first and go to the package's reference index:

| From URL | To URL |
|---|---|
| `/en/latest/orgmetrics/functions/orgmetrics_generate_yaml.html` | `https://docs.ropensci.org/orgmetrics/reference/` |
| `/en/latest/pkgcheck/functions/get_gh_token.html` | `https://docs.ropensci.org/pkgcheck/reference/` |
| `/en/latest/pkgcheck/functions/pkgstats_data.html` | `https://docs.ropensci.org/pkgcheck/reference/` |

Then:

| From URL | To URL |
|---|---|
| `/en/latest/goodpractice/functions/*` | `https://docs.ropensci.org/goodpractice/reference/:splat` |
| `/en/latest/goodpractice/vignettes/*` | `https://docs.ropensci.org/goodpractice/articles/:splat` |
| `/en/latest/goodpractice/*` | `https://docs.ropensci.org/goodpractice/` |
| `/en/latest/orgmetrics/functions/*` | `https://docs.ropensci.org/orgmetrics/reference/:splat` |
| `/en/latest/orgmetrics/*` | `https://docs.ropensci.org/orgmetrics/` |
| `/en/latest/pkgcheck/functions/*` | `https://docs.ropensci.org/pkgcheck/reference/:splat` |
| `/en/latest/pkgcheck/vignettes/*` | `https://docs.ropensci.org/pkgcheck/articles/:splat` |
| `/en/latest/pkgcheck/*` | `https://docs.ropensci.org/pkgcheck/` |
| `/en/latest/pkgmatch/functions/*` | `https://docs.ropensci.org/pkgmatch/reference/:splat` |
| `/en/latest/pkgmatch/vignettes/*` | `https://docs.ropensci.org/pkgmatch/articles/:splat` |
| `/en/latest/pkgmatch/*` | `https://docs.ropensci.org/pkgmatch/` |
| `/en/latest/pkgstats/functions/*` | `https://docs.ropensci.org/pkgstats/reference/:splat` |
| `/en/latest/pkgstats/vignettes/*` | `https://docs.ropensci.org/pkgstats/articles/:splat` |
| `/en/latest/pkgstats/*` | `https://docs.ropensci.org/pkgstats/` |
| `/en/latest/repometrics/functions/*` | `https://docs.ropensci.org/repometrics/reference/:splat` |
| `/en/latest/repometrics/vignettes/*` | `https://docs.ropensci.org/repometrics/articles/:splat` |
| `/en/latest/repometrics/*` | `https://docs.ropensci.org/repometrics/` |
| `/en/latest/roreviewapi/functions/*` | `https://docs.ropensci.org/roreviewapi/reference/:splat` |
| `/en/latest/roreviewapi/vignettes/*` | `https://docs.ropensci.org/roreviewapi/articles/:splat` |
| `/en/latest/roreviewapi/*` | `https://docs.ropensci.org/roreviewapi/` |
| `/en/latest/srr/functions/*` | `https://docs.ropensci.org/srr/reference/:splat` |
| `/en/latest/srr/vignettes/*` | `https://docs.ropensci.org/srr/articles/:splat` |
| `/en/latest/srr/*` | `https://docs.ropensci.org/srr/` |

orgmetrics has no vignettes, so it only needs two.

## 3. Packages documented on GitHub

| From URL | To URL |
|---|---|
| `/en/latest/autotest/*` | `https://github.com/mpadge/autotest` |
| `/en/latest/dashboard/*` | `https://github.com/ropensci-review-tools/dashboard` |
| `/en/latest/mirrors/*` | `https://github.com/ropensci-review-tools/mirrors` |
| `/en/latest/pkgcheck-action/*` | `https://github.com/ropensci-review-tools/pkgcheck-action` |

## 4. Catch-all (create last)

| From URL | To URL |
|---|---|
| `/*` | `https://ropensci.org/software-review/` |

This covers the home page (`/` and `/en/latest/`), search, the PDF download and any URL not matched above.

## Shorter alternative

If 38 redirects is too many, the catch-all alone (section 4) is enough: every old URL then lands on ropensci.org/software-review, which links to the packages.

## Checks after creating them

```bash
base=https://ropensci-review-tools.readthedocs.io
for p in /en/latest/srr/srr.html \
         /en/latest/srr/functions/srr_report.html \
         /en/latest/pkgcheck/vignettes/extending-checks.html \
         /en/latest/maintenance/tokens.html \
         /en/latest/dashboard/dashboard.html \
         /en/latest/ \
         /en/latest/does-not-exist.html; do
  printf '%s -> ' "$p"
  curl -s -o /dev/null -w '%{http_code} %{redirect_url}\n' "$base$p"
done
```

Every line should show `301` and the expected target.
