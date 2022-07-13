source("./tools/tools.R") # assume this file is called from vscode workspace

# file name to open in chrome
names <- stringr::str_replace(string = get_book_filename(), pattern = "\\.Rmd", replacement = "\\.html")

# path of the file with that name
path <- list.files(path = get_output_dir(), pattern = names[1], full.names = TRUE)[1]

base::system2("google-chrome", args = path)
