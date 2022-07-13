library(magrittr)

is_vscode_workspace <- function(path = getwd()) {
    pattern <- "[a-zA-Z0-9_].code-workspace"
    list.files(path, pattern = pattern) %>%
        {
            length(.) > 0
        }
}

# search recursively. maximum depth of recursion is determined by depth argument.
get_vscode_workspace <- function(path = getwd(), depth = 2, path_init = NULL) {
    if (is_vscode_workspace(path)) {
        # get the absolute path that *.code-workspace designates
        ws_orig <- getwd()
        setwd(path)
        cws_path <- list.files(pattern = "[a-zA-Z0-9_].code-workspace")[1]
        code_workspace <- jsonlite::read_json(cws_path)
        workspace_folder_relative <- code_workspace$folders[[1]]$path
        workspace_folder_abs_path <- normalizePath(workspace_folder_relative)
        setwd(ws_orig)
        return(workspace_folder_abs_path)
    }
    # path_init only used for failure message
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
    # search parent folder
    return(get_vscode_workspace(dirname(path), depth - 1, path_init))
}

get_dir <- function(dir_basename,
                    dir_search = get_vscode_workspace(),
                    except = "") {
    list.dirs(dir_search) %>%
        .[
            (basename(.) == dir_basename) & stringr::str_detect(., except, negate = TRUE)
        ]
}

get_dirconfig <- function(dir_name = "tools",
                          dir_search = get_vscode_workspace()) {
    dir <- get_dir(
        dir_basename = dir_name,
        except = ".history"
    )
    list.files(path = dir, pattern = "dir_config.yml", full.names = TRUE)
}

get_output_dir <- function() {
    config_path <- get_dirconfig()
    conf <- config::get(file = config_path)
    get_dir(
        dir_basename = conf$output_dir_basename,
        dir_search = get_vscode_workspace(),
        except = conf$not_search_here
    )
}

get_scr_dir <- function() {
    config_path <- get_dirconfig()
    conf <- config::get(file = config_path)
    get_dir(
        dir_basename = conf$scr_dir_basename,
        dir_search = get_vscode_workspace(),
        except = conf$not_search_here
    )
}

get_book_filename <- function() {
    files <- list.files(
        path = get_scr_dir(),
        pattern = "_bookdown.yml",
        full.names = TRUE
    )
    yaml::read_yaml(files)$book_filename
}
