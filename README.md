# ropensci-review-tools (archived)

> [!WARNING]
> This repository is archived and no longer maintained. It used to build the
> documentation site at `ropensci-review-tools.readthedocs.io`, which now
> redirects to [rOpenSci's software peer review page](https://ropensci.org/software-review/).

The site gathered the documentation of the packages in the
[`ropensci-review-tools` organization](https://github.com/ropensci-review-tools),
plus a few pages of maintenance notes. The package documentation was a copy of
each package's own website, and the maintenance notes have moved closer to the
code they describe.

## Where to find the documentation now

### Packages

Each package has its own website, which was always the primary documentation:

- [autotest](https://github.com/mpadge/autotest/)
- [goodpractice](https://docs.ropensci.org/goodpractice/)
- [orgmetrics](https://docs.ropensci.org/orgmetrics/)
- [pkgcheck](https://docs.ropensci.org/pkgcheck/)
- [pkgmatch](https://docs.ropensci.org/pkgmatch/)
- [pkgstats](https://docs.ropensci.org/pkgstats/)
- [repometrics](https://docs.ropensci.org/repometrics/)
- [roreviewapi](https://docs.ropensci.org/roreviewapi/)
- [srr](https://docs.ropensci.org/srr/)

These are documented in their GitHub repositories:
[dashboard](https://github.com/ropensci-review-tools/dashboard),
[mirrors](https://github.com/ropensci-review-tools/mirrors),
[pkgcheck-action](https://github.com/ropensci-review-tools/pkgcheck-action).

### Other pages

| Former page | New location |
|---|---|
| Overview | [Organization profile](https://github.com/ropensci-review-tools) |
| Notes (local testing, Makefiles, pre-commit hooks) | [`MAINTAINING.md`](https://github.com/ropensci-review-tools/.github/blob/main/MAINTAINING.md) in the organization's `.github` repository |
| Debugging | ["Debugging the package check API" vignette](https://docs.ropensci.org/roreviewapi/articles/debugging.html) of roreviewapi |
| Maintenance: ropensci-review-bot | ["Admin setup" vignette](https://docs.ropensci.org/roreviewapi/articles/admin-setup.html) of roreviewapi |
| Maintenance: pkgcheck | ["Controlling which checks are reported"](https://docs.ropensci.org/roreviewapi/articles/admin-setup.html#controlling-which-checks-are-reported) in roreviewapi's "Admin setup" vignette |
| Maintenance: GitHub tokens | [pkgcheck's contributing guide](https://github.com/ropensci-review-tools/pkgcheck/blob/main/CONTRIBUTING.md) |
| Maintenance: pkgstats | [pkgstats' contributing guide](https://github.com/ropensci-review-tools/pkgstats/blob/main/CONTRIBUTING.md) and [`pkgstats-data` vignette](https://docs.ropensci.org/pkgstats/articles/pkgstats-data.html) |
| Badges | [README of the badges repository](https://github.com/ropensci-org/badges) |

## How the site was built

For the record: [`pkgdocs-script.R`](pkgdocs-script.R) converted the README,
Rd files and vignettes of each repository listed in [`packages.md`](packages.md)
to Markdown in the `docs/` folder, and the [`makefile`](makefile) then built the
site with Sphinx (`make` to grab and build, `make clean` to remove the generated
files). Read the Docs built the site from `docs/` as configured in
[`.readthedocs.yaml`](.readthedocs.yaml).
