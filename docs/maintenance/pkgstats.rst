
pkgstats
========

Maintenance of `pkgstats` package is now described in the |pkgstats-data vignette|_.
The major maintenance issue is the daily updates of `pkgstats` from all CRAN
and rOpenSci packages. These data are updated automatically on a `GitHub
action <https://github.com/ropensci-review-tools/pkgstats/blob/main/.github/workflows/update.yaml>`__.
It's important to keep an eye on this action, as it will be automatically
suspended after 60 days of inactivity in the repository. The
`vignette <https://docs.ropensci.org/pkgstats/articles/pkgstats-data.html>`__
describes procedures for manually updating the data if and when necessary.

.. |pkgstats-data vignette| replace:: ``pkgstats-data`` vignette
.. _pkgstats-data vignette: https://docs.ropensci.org/pkgstats/articles/pkgstats-data.html

.. admonition:: Check effect of`pkgstats` updates on `pkgcheck`
   :class: tip

    By default 'pkgcheck' imports the current CRAN version of `pkgstats`. The
    effects of any changes to this package must be examined by updating the
    |pkgcheck DESCRIPTION file|_to add

    .. code-block:: text

       Remotes: ropensci-review-tools/pkgstats

    Make sure the GitHub workflows all pass. The dependency is one-way, so it's
    best to first update ``pkgstats`` on CRAN followed by any ``pkgcheck`` updates.

.. |pkgcheck DESCRIPTION file| replace:: ``pkgcheck`` 'DESCRIPTION' file
.. _pkgcheck DESCRIPTION file: https://github.com/ropensci-review-tools/pkgcheck/blob/main/DESCRIPTION
