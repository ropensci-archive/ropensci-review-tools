# Create the Read the Docs redirects listed in redirects.md (sections 2 to 4).
#
# Usage, in an R console from the root of this repository:
#
#   Sys.setenv (RTD_TOKEN = "...") # or set it in ~/.Renviron
#   source ("create_redirects.R")
#   create_redirects ()               # dry run: prints what would be created
#   create_redirects (apply = TRUE)   # creates the redirects
#
# Redirects whose from_url already exists on the project are skipped. New ones
# get positions after the existing ones, in the order of the file.

project <- "ropensci-review-tools"
api_url <- sprintf ("https://app.readthedocs.org/api/v3/projects/%s/redirects/", project)

rtd_request <- function (url, token) {
    httr2::request (url) |>
        httr2::req_headers (Authorization = paste ("Token", token))
}

existing_redirects <- function (token) {
    out <- list ()
    url <- paste0 (api_url, "?limit=100")
    while (!is.null (url)) {
        page <- rtd_request (url, token) |>
            httr2::req_perform () |>
            httr2::resp_body_json ()
        out <- c (out, page$results)
        url <- page$`next`
    }
    out
}

wanted_redirects <- function (md_path,
                              from = "^## 2\\.",
                              to = "^## Shorter alternative") {
    lines <- readLines (md_path, encoding = "UTF-8")
    start <- grep (from, lines)
    end <- grep (to, lines)
    lines <- lines [seq (start, end)]
    ptn <- "^\\| `([^`]+)` \\| `([^`]+)` \\|$"
    rows <- regmatches (lines, regexec (ptn, lines))
    rows <- rows [lengths (rows) == 3L]
    data.frame (
        from_url = vapply (rows, `[`, character (1L), 2L),
        to_url = vapply (rows, `[`, character (1L), 3L)
    )
}

create_redirects <- function (md_path = "redirects.md",
                              apply = FALSE,
                              token = Sys.getenv ("RTD_TOKEN")) {
    if (!nzchar (token)) {
        stop ("Set RTD_TOKEN (profile settings -> API tokens on readthedocs.org).")
    }

    have <- existing_redirects (token)
    have_from <- vapply (have, function (r) r$from_url %||% NA_character_, character (1L))
    positions <- vapply (have, function (r) as.integer (r$position), integer (1L))
    position <- if (length (positions) > 0L) max (positions) + 1L else 0L
    message (length (have), " existing redirects; new ones start at position ", position, ".")

    wanted <- wanted_redirects (md_path)
    for (i in seq_len (nrow (wanted))) {
        from_url <- wanted$from_url [i]
        to_url <- wanted$to_url [i]
        if (from_url %in% have_from) {
            message ("skip (exists)  ", from_url)
            next
        }
        body <- list (
            type = "exact",
            from_url = from_url,
            to_url = to_url,
            force = TRUE,
            http_status = 301L,
            position = position,
            enabled = TRUE
        )
        if (apply) {
            rtd_request (api_url, token) |>
                httr2::req_body_json (body) |>
                httr2::req_perform ()
            message ("created  [", position, "] ", from_url, " -> ", to_url)
        } else {
            message ("would create [", position, "] ", from_url, " -> ", to_url)
        }
        position <- position + 1L
    }

    if (!apply) {
        message ("\nDry run only. Run create_redirects (apply = TRUE) to create them.")
    }
    invisible (wanted)
}

# Fix the redirects of section 1 ("Hand-written pages"), which were created by
# hand. Existing redirects are matched to section 1 by their "To URL" and
# updated in place (keeping their position) to be exact, forced, 301
# redirects with the "From URL" of redirects.md. Section 1 redirects with no
# match are created at position 0, before all others.
#
#   fix_manual_redirects ()               # dry run
#   fix_manual_redirects (apply = TRUE)   # update/create
fix_manual_redirects <- function (md_path = "redirects.md",
                                  apply = FALSE,
                                  token = Sys.getenv ("RTD_TOKEN")) {
    if (!nzchar (token)) {
        stop ("Set RTD_TOKEN (profile settings -> API tokens on readthedocs.org).")
    }

    wanted <- wanted_redirects (md_path, from = "^## 1\\.", to = "^## 2\\.")
    have <- existing_redirects (token)
    have_to <- vapply (have, function (r) r$to_url %||% NA_character_, character (1L))

    for (i in seq_len (nrow (wanted))) {
        body <- list (
            type = "exact",
            from_url = wanted$from_url [i],
            to_url = wanted$to_url [i],
            force = TRUE,
            http_status = 301L,
            enabled = TRUE
        )
        match <- which (have_to == wanted$to_url [i])
        if (length (match) > 1L) {
            message ("several redirects go to ", wanted$to_url [i], "; fix by hand")
            next
        }
        if (length (match) == 1L) {
            r <- have [[match]]
            body$position <- r$position
            action <- sprintf (
                "update [%s] (was %s, force = %s, from %s)",
                r$position, r$type, r$force, r$from_url %||% NA
            )
            req <- rtd_request (paste0 (api_url, r$pk, "/"), token) |>
                httr2::req_method ("PUT")
        } else {
            body$position <- 0L
            action <- "create [0]"
            req <- rtd_request (api_url, token)
        }
        if (apply) {
            req |> httr2::req_body_json (body) |> httr2::req_perform ()
        }
        message (
            if (apply) "" else "would ", action, "\n    ",
            body$from_url, " -> ", body$to_url
        )
    }

    if (!apply) {
        message ("\nDry run only. Run fix_manual_redirects (apply = TRUE) to apply.")
    }
    invisible (wanted)
}
