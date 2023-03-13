##Lage struktur av metadata til Facebook-bilder
library(writexl)

fb <- function(antall_likes,dato) {
path <- "fbbilder/"
mappe <- dir("fbbilder")
nytt.bilde <- paste0("fbbilder/",mappe[grep(".jpg", mappe)])

fiks.tegn <- function(i) {
  tekst <- ny.tekst[i]
  tekst <- gsub("Ã¦", "æ", tekst)
  tekst <- gsub("Ã¸", "ø", tekst)
  tekst <- gsub("Ã¥", "å", tekst)
  tekst <- gsub("Ã¶", "ö", tekst)
  tekst <- gsub("Ã¤", "ä", tekst)
  tekst <- gsub("Ã.", "Å", tekst)
  return(tekst)
}

if (file.exists(nytt.bilde) == TRUE){
ny.tekst <- read.delim(paste0(path, "tekst.txt"), header = FALSE)[,1]
innlegg <- grep("Se innlegg", ny.tekst)[1]

if(!is.na(innlegg)){
  navn <- ny.tekst[innlegg + 1]
} else {
  navn <- ny.tekst[2]
}

#navn <- ifelse(navn=="Søk på Facebook", ny.tekst[4], navn)
#navn <- strsplit(navn, ",")[[1]][1]
#dato <- ny.tekst[3]

#Lag ny mappe hvis navn ikke eksisterer
dir.create(file.path(path, navn), showWarnings = FALSE)

#Gi nytt navn til bilde
ny.mappe <- paste0(path,navn)
filer <- dir(ny.mappe)
index <- length(grep(".jpg", filer)) + 1
nytt.bildenavn <- paste0(path,navn, "_", index, ".jpg")
nytt.bildenavn2 <- paste0(navn, "_", index, ".jpg")
file.rename(nytt.bilde, nytt.bildenavn)

#Flytt bildet til ny mappe
file.copy(from = nytt.bildenavn,
          to   = ny.mappe)
file.remove(nytt.bildenavn)

#Lag mappe til kommentarer
kommentarmappe <- paste0(navn, "_kommentarer")
dir.create(file.path(ny.mappe, kommentarmappe), showWarnings = FALSE)

#Hente ut tekst fra fil
start <- length(ny.tekst) - antall_likes + 1
slutt <- length(ny.tekst)
likes <- ny.tekst[start:slutt]
fjern <- grep("Se opprinnelig tekst|Trykk Enter for å publisere|Svar1 år|Mest relevante er valgt", likes)
if (length(fjern) > 0) {
  likes <- likes[-fjern]  
}

df <- data.frame(fil=nytt.bildenavn2, dato = dato, likes = likes)

##Sjekk om data allerede eksisterer. Hvis ikke, lagre data
filnavn <- paste0(path,navn,"/",navn,".csv")
filnavnexcel <- paste0(path,navn,"/",navn,".xlsx")

if (file.exists(filnavn) == TRUE){
  alle.data <- read.csv(filnavn)} else {
     alle.data <- data.frame(fil=character(), likes=character())
  }

alle.data <- rbind(alle.data, df)
write.csv(alle.data, filnavn, row.names = FALSE)
write_xlsx(alle.data, filnavnexcel)

##Lag liste over de som liker mest
freq <- as.data.frame(table(alle.data[,3]))
freq <- freq[order(freq[,2], decreasing=TRUE),]
names(freq) <- c("navn", "antall")
freqfile <- paste0(path,navn,"/",navn,"_freq.xlsx")
write_xlsx(freq, freqfile)

#Lagre fil av kommentarer
kommentarstart <- grep("Kommentarer", ny.tekst)
kommentarer <- ny.tekst[kommentarstart:(start-1)]
kommentarfilnavn <- paste0(path,navn,"/",kommentarmappe, "/",navn, "_", index, ".txt")
write.table(kommentarer, kommentarfilnavn, sep="", row.names = FALSE, col.names = FALSE, fileEncoding = "UTF-8")
} else {
  print("bildefil mangler")
}
}
