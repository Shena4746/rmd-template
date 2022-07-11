library(magrittr)

is_vscode_workspace <- function(path = getwd()) {
    pattern <- "[a-zA-Z0-9_].code-workspace"
    list.files(path, pattern = pattern) %>%
        {
            length(.) > 0
        }
}

get_vscode_workspace <- function(path = getwd(), depth = 2, path_init = NULL) {
    if (is_vscode_workspace(path)) {
        return(path)
    }
    path_init <- ifelse(path_init %>% is.null(), path, path_init)
    if (depth <= 0) {
        paste0(
            "No workspace file found.\n",
            "The search started: ",
            path_init,
            "\n",
            "And ended: ",
            path
        ) %>% stop()
    }
    return(get_vscode_workspace(dirname(path), depth - 1, path_init))
}

get_dir <- function(dir_basename, dir_search = get_vscode_workspace(), except = "") {
    list.dirs(dir_search) %>% .[(basename(.) == dir_basename) & stringr::str_detect(., except, negate = TRUE)]
}
