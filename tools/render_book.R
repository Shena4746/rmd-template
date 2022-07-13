# this script assumes that it is called from ${workspaceFolder}.
# if you call it from elsewhere, set the appropriate path to the tools.R.
# then get_vscode_workspace() finds the absolute path of ${workspaceFolder}.
library(magrittr)
source("./tools/tools.R")

conf <- config::get(file = get_dirconfig())
# create output directory if it does not exists
if (get_output_dir() %>% length() == 0) {
    dir.create(conf$output_dir_basename)
}
# create empty book file if it does not exist
# get book file path
book_file <- list.files(
    path = get_scr_dir(),
    pattern = get_book_filename(),
    full.names = TRUE
)
if (book_file %>% length() == 0) {
    new_file <- file.path(get_scr_dir(), get_book_filename())
    file.create(new_file)
}

get_scr_dir() %>% setwd() # render here
bookdown::render_book(
    input = conf$rmd_basename,
    output_dir = get_output_dir()
)
