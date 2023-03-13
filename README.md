Facescrape.R
============

Dette er et R-skript som er skrevet i flere omganger, til bruk i journalistisk research.

Det er ikke noe *smart* innhold her: Facebook har effektivt stengt de fleste muligheter for å skrape innhold direkte.

Så for å få dette skriptet til å funke, må man gjøre følgende:

- Lag en mappe *fbbilder* i mappen der skriptet ligger.
- I mappen lager du en tom fil, *tekst.txt*.
- Finn et bilde på Facebook, høyreklikk og lagre det i mappen *fbbilder*.
- Åpne likes-listen i bildet. Skroll til bunnen. Trykk <CTRL+A+C>.
- Lim inn alt innhold i *tekst.txt*: <CTRL-A-V>.
- Kjør skriptet.
- Det inneholder én funksjon, *fb()*. Funksjonen tar to argumenter, antall_likes og dato.
- Kjør funksjonen ved å skrive kommando på formen *fb(antall_likes,dato)*. antall_likes er tallet som er oppgitt på bildet. Dato er dato for opplasting. Bruk formen "YYYY-MM-DD". (Du kan bruke hvilket datoformat som helst, men dette fungerer sømløst med Excel.)

Hvis alt fungerer, skal nå følgende skje:
- En mappe opprettes med navn *FB-PROFILNAVN*.
- Bildet får nytt navn på formen <FB-PROFILNAVN_INDEKS.jpg> og flyttes til profilmappen.
- Inne i mappen dannes en csv- og en tekstfil med identisk innhold: Navn på bilde, dato for opplasting og navn på dem som har likt det.
- En mappe med kommentarer fra bildet lages også om den ikke finnes fra før. Inneholder .txt-filer.
- Filen med suffiks *_freq.xlsx* teller opp hvor mange den enkelte av profileierens venner som har likt bilder. Maks antall = antall nedlastede bilder.
