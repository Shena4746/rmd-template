library(magrittr)
source("./tools/tools.R")

vscode_workspace_dir <- get_vscode_workspace()

# dir and file variables
# read config
dir_config_path <- "./tools/dir_config.yml"
conf <- config::get(file = dir_config_path)

output_dir_basename <- conf$output_dir_basename
scr_dir_basename <- conf$scr_dir_basename
not_search_here <- conf$not_search_here
rmd_basename <- conf$rmd_basename

# set work directory for R: ${workspaceFolder}/scr_dir_basename
get_dir(
    dir_basename = scr_dir_basename,
    dir_search = vscode_workspace_dir,
    except = not_search_here
) %>% setwd() # render here

# get full path of output directory
output_dir <- get_dir(
    dir_basename = output_dir_basename,
    dir_search = vscode_workspace_dir,
    except = not_search_here
)

bookdown::render_book(rmd_basename, output_dir = output_dir)
