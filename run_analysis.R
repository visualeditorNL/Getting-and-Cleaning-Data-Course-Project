#here comes my assessment

working_dir <- getwd()
filenames <- list.files(paste0(working_dir,"/UCI HAR Dataset"))
test <- do.call("rbind", lapply(filenames, read.csv, sep = ";", header = TRUE))
