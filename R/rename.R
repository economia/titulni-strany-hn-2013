soubory  <- list.files("..", recursive=T)

soubory  <- soubory[grepl("pdf", soubory)]

for (i in soubory) {
  file.rename(paste("../", i, sep=""), paste("../", substr(i,1,3), substr(i,1,2), substr(i,4,5), ".pdf", sep=""))
}