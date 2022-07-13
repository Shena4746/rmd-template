# this script assumes that it is called from ${workspaceFolder}.
# if you call it from elsewhere, set the appropriate path to the tools.R.
# then get_vscode_workspace() finds the absolute path of ${workspaceFolder}.
library(magrittr)
source("./tools/tools.R")

# create output directory if it does not exists
if (get_output_dir() %>% length() == 0) {
    stop("No rendered results found. Run bookdown::render_book() first.")
}

get_scr_dir() %>% setwd()
bookdown::serve_book(
    dir = ".",
    output_dir = get_output_dir(),
    preview = TRUE,
    in_session = FALSE
)
