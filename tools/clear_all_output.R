# clear cache -> clear outputs -> clear cache
# specifies the file project-root/tools/your-script-in-tools.R
source(rprojroot::is_git_root$make_fix_file()("tools", "clear_cache.R"))
source(rprojroot::is_git_root$make_fix_file()("tools", "tools.R"))
args <- paste(".", get_output_dir(), "-x", "rm -rf {}")
base::system2(command = "fd", args = args)
source(rprojroot::is_git_root$make_fix_file()("tools", "clear_cache.R"))
