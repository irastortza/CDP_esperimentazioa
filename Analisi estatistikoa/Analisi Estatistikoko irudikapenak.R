setwd("JARRI ZURE BIDE_IZENA")
library(RVCompare)
library(ggplot2)

IO<-read.csv(file="JARRI FITXATEGIAREN BIDE IZENA",header=FALSE,sep=",",stringsAsFactors=FALSE)
IO2<-read.csv(file="JARRI FITXATEGIAREN BIDE IZENA",header=FALSE,sep=",",stringsAsFactors=FALSE)

#CSV bakoitzak hiru instantzien datuak ditu, horietako bakoitzaren datuekin matrize bana sortu
instantzia1O = matrix(ncol=ncol(IO)-1,nrow=nrow(IO)/3)
instantzia2O = matrix(ncol=ncol(IO)-1,nrow=nrow(IO)/3)
instantzia3O = matrix(ncol=ncol(IO)-1,nrow=nrow(IO)/3)

#Izenburuen bektoreak sortu, zutabeei izena emateko gerora.
bek1 = c()
bek2 = c()
bek3 = c()

#CSVa prozesatu, datuak bildu
for (i in 1:((nrow(IO))/3)-1) { #CSVan instantzien datuak nahastuta daude (instantzien k bakoitzerako informazioa hirukoteka), antolatu egin behar dira.
  a=IO[3*i+1,] #Lehen instantziari dagokion errenkada atzeman
  instantzia1O[i+1,]=as.numeric(a[2:ncol(a)]) #Zenbakizko bektore bihurtu eta instantziaren matrizean txertatu
  bek1 = c(bek1,strsplit(as.character(a[1]),"-")[[1]][1]) #Errenkadaren izena izenburuen bektorean sartu
  a=IO[3*i+2,] #Berdin bigarren instantziari dagozkion datuekin
  instantzia2O[i+1,]=as.numeric(a[2:ncol(a)])
  bek2 = c(bek2,strsplit(as.character(a[1]),"-")[[1]][1])
  a=IO[3*i+3,] #Berdin hirugarren instantziari dagozkion datuekin 
  instantzia3O[i+1,]=as.numeric(a[2:ncol(a)])
  bek3 = c(bek3,strsplit(as.character(a[1]),"-")[[1]][1])
}
#INSTANTZIA BAKOITZAREN BIOLIN GRAFIKOA SORTZEKO. Instantzia bakoitzaren datuen matrizea data-frame egiturakoa bihurtu
instantzia1O <- as.data.frame(t(data.frame(row.names = bek1,instantzia1O)))
instantzia2O <- as.data.frame(t(data.frame(row.names = bek1,instantzia2O)))
instantzia3O <- as.data.frame(t(data.frame(row.names = bek1,instantzia3O)))

umda <- rbind(instantzia1O,instantzia2O,instantzia3O)

#CSV bakoitzak hiru instantzien datuak ditu, horietako bakoitzaren datuekin matrize bana sortu
instantzia1P = matrix(ncol=ncol(IO2)-1,nrow=nrow(IO2)/3)
instantzia2P = matrix(ncol=ncol(IO2)-1,nrow=nrow(IO2)/3)
instantzia3P = matrix(ncol=ncol(IO2)-1,nrow=nrow(IO2)/3)

#Izenburuen bektoreak sortu, zutabeei izena emateko gerora.
bek1 = c()
bek2 = c()
bek3 = c()

#CSVa prozesatu, datuak bildu
for (i in 1:((nrow(IO2))/3)-1) { #CSVan instantzien datuak nahastuta daude (instantzien k bakoitzerako informazioa hirukoteka), antolatu egin behar dira.
  a=IO2[3*i+1,] #Lehen instantziari dagokion errenkada atzeman
  instantzia1P[i+1,]=as.numeric(a[2:ncol(a)]) #Zenbakizko bektore bihurtu eta instantziaren matrizean txertatu
  bek1 = c(bek1,strsplit(as.character(a[1]),"-")[[1]][1]) #Errenkadaren izena izenburuen bektorean sartu
  a=IO2[3*i+2,] #Berdin bigarren instantziari dagozkion datuekin
  instantzia2P[i+1,]=as.numeric(a[2:ncol(a)])
  bek2 = c(bek2,strsplit(as.character(a[1]),"-")[[1]][1])
  a=IO2[3*i+3,] #Berdin hirugarren instantziari dagozkion datuekin 
  instantzia3P[i+1,]=as.numeric(a[2:ncol(a)])
  bek3 = c(bek3,strsplit(as.character(a[1]),"-")[[1]][1])
}
#INSTANTZIA BAKOITZAREN BIOLIN GRAFIKOA SORTZEKO. Instantzia bakoitzaren datuen matrizea data-frame egiturakoa bihurtu
instantzia1P <- as.data.frame(t(data.frame(row.names = bek1,instantzia1P)))
instantzia2P <- as.data.frame(t(data.frame(row.names = bek1,instantzia2P)))
instantzia3P <- as.data.frame(t(data.frame(row.names = bek1,instantzia3P)))

subsim <- rbind(instantzia1P,instantzia2P,instantzia3P)

subsimD <- c(unlist(matrix(subsim)))
umdaD <- c(unlist(matrix(umda)))

#UMDA eta Suberaketa simulatuaren arteko alderaketa

#1. GRAFIKOA
is_minimization <- FALSE
cumulative_difference_plot(umdaD, subsimD,
                           isMinimizationProblem = is_minimization,
                           labelA = "UMDA algoritmoa", labelB = "Suberaketa simulatua", ignoreMinimumLengthCheck = TRUE)



#2. GRAFIKOA
X_A <- subsimD
X_B <- umdaD

dataHist <- data.frame(
  value=c(X_A,X_B),
  type=c(rep("Suberaketa simulatua", length(X_A)), rep("UMDA",  length(X_B)))
)
ggplot(data=dataHist, aes(x=value, fill=type)) +
  geom_histogram(alpha=0.65, position = 'identity', bins = 20) +
  scale_fill_manual(values=c("#1f77b4", "#ff7f0e")) +
  ggplot2::xlab('Helburu-funtzioaren balioa') +
  ggplot2::ylab('Exekuzioak') +
  ggplot2::theme_minimal() +
  labs(fill="")


