# assume this file is called from vscode workspace
source("./tools/tools.R")
args <- paste(".", get_output_dir(), "-x", "rm -rf {}")
base::system2(command = "fd", args = args)
