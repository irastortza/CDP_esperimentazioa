#Programak sortutako CSV bat emanda, biolin motako grafikoekin irudikatuko ditu datuak
library(ggplot2)
library(gridExtra)
library(RVCompare)
library(dplyr)
library(forcats)
library(tidyr)

#Bide-izena zehaztu
setwd("JARRI ZURE CSVen KARPETAREN BIDE-IZENA")

#Hautatu irudikatu nahi den CSVa
IO<-read.csv(file="JARRI FITXATEGIAREN BIDE-IZENA",header=FALSE,sep=",",stringsAsFactors=FALSE)

#CSV bakoitzak hiru instantzien datuak ditu, horietako bakoitzaren datuekin matrize bana sortu
instantzia1 = matrix(ncol=ncol(IO)-1,nrow=nrow(IO)/3)
instantzia2 = matrix(ncol=ncol(IO)-1,nrow=nrow(IO)/3)
instantzia3 = matrix(ncol=ncol(IO)-1,nrow=nrow(IO)/3)

#Izenburuen bektoreak sortu, zutabeei izena emateko gerora.
bek1 = c()
bek2 = c()
bek3 = c()

#CSVa prozesatu, datuak bildu
for (i in 1:((nrow(IO))/3)-1) { #CSVan instantzien datuak nahastuta daude (instantzien k bakoitzerako informazioa hirukoteka), antolatu egin behar dira.
  a=IO[3*i+1,] #Lehen instantziari dagokion errenkada atzeman
  instantzia1[i+1,]=as.numeric(a[2:ncol(a)]) #Zenbakizko bektore bihurtu eta instantziaren matrizean txertatu
  bek1 = c(bek1,strsplit(as.character(a[1]),"-")[[1]][1]) #Errenkadaren izena izenburuen bektorean sartu
  a=IO[3*i+2,] #Berdin bigarren instantziari dagozkion datuekin
  instantzia2[i+1,]=as.numeric(a[2:ncol(a)])
  bek2 = c(bek2,strsplit(as.character(a[1]),"-")[[1]][1])
  a=IO[3*i+3,] #Berdin hirugarren instantziari dagozkion datuekin 
  instantzia3[i+1,]=as.numeric(a[2:ncol(a)])
  bek3 = c(bek3,strsplit(as.character(a[1]),"-")[[1]][1])
}
#INSTANTZIA BAKOITZAREN BIOLIN GRAFIKOA SORTZEKO. Instantzia bakoitzaren datuen matrizea data-frame egiturakoa bihurtu
instantzia1 <- as.data.frame(t(data.frame(row.names = bek1,instantzia1)))
instantzia2 <- as.data.frame(t(data.frame(row.names = bek1,instantzia2)))
instantzia3 <- as.data.frame(t(data.frame(row.names = bek1,instantzia3)))

#BIOLIN BAKOITZEAN INSTANTZIA GUZTIEN EXEKUZIOAK BILDUTA DITUEN GRAFIKOA. K bakoitzerako, instantzia guztien exekuzioak zutabe berean jarri.
instantziaXA = rbind(instantzia1,instantzia2,instantzia3)

#BIOLINAK SORTZEKO EXEKUZIOEN BATEZ BESTEKOAK ERABILTZEN DITUEN GRAFIKOA. K bakoitzeko exekuzio bakoitzean instantzien exekuzioen batez bestekoak kalkulatu.
instantziaX = (instantzia1 + instantzia2 + instantzia3) /3

#Grafikoaren irudikapena
df        <- instantzia1
names(df) <- paste0(bek3) 
plot_df      <- pivot_longer(df, cols = 1:ncol(instantzia1))
plot_df$parKop <- factor(plot_df$name, paste0(bek3))

ggplot(plot_df, aes(parKop, value, fill = parKop)) + geom_violin() + xlab("Partizio kopurua (k)") + ylab("Batez besteko helburu-funtzioaren balioa") + ggtitle("Lehen instantziaren exekuzioak") + theme(plot.title = element_text(hjust = 0.5)) + expand_limits(y=0)

#Grafikoaren irudikapena
df        <- instantzia2
names(df) <- paste0(bek3) 
plot_df      <- pivot_longer(df, cols = 1:ncol(instantzia2))
plot_df$parKop <- factor(plot_df$name, paste0(bek3))

ggplot(plot_df, aes(parKop, value, fill = parKop)) + geom_violin() + xlab("Partizio kopurua (k)") + ylab("Batez besteko helburu-funtzioaren balioa") + ggtitle("Bigarren instantziaren exekuzioak") + theme(plot.title = element_text(hjust = 0.5)) + expand_limits(y=0)

#Grafikoaren irudikapena
df        <- instantzia3
names(df) <- paste0(bek3) 
plot_df      <- pivot_longer(df, cols = 1:ncol(instantzia3))
plot_df$parKop <- factor(plot_df$name, paste0(bek3))

ggplot(plot_df, aes(parKop, value, fill = parKop)) + geom_violin() + xlab("Partizio kopurua (k)") + ylab("Batez besteko helburu-funtzioaren balioa") + ggtitle("Hirugarren instantziaren exekuzioak") + theme(plot.title = element_text(hjust = 0.5)) + expand_limits(y=0)

#Grafikoaren irudikapena
df        <- instantziaXA
names(df) <- paste0(bek3) 
plot_df      <- pivot_longer(df, cols = 1:ncol(instantziaXA))
plot_df$parKop <- factor(plot_df$name, paste0(bek3))

ggplot(plot_df, aes(parKop, value, fill = parKop)) + geom_violin() + xlab("Partizio kopurua (k)") + ylab("Batez besteko helburu-funtzioaren balioa") + ggtitle("Instantzia guztien exekuzioak bilduta") + theme(plot.title = element_text(hjust = 0.5)) + expand_limits(y=0)

#Grafikoaren irudikapena
df        <- instantziaX
names(df) <- paste0(bek3) 
plot_df      <- pivot_longer(df, cols = 1:ncol(instantziaX))
plot_df$parKop <- factor(plot_df$name, paste0(bek3))

ggplot(plot_df, aes(parKop, value, fill = parKop)) + geom_violin() + xlab("Partizio kopurua (k)") + ylab("Batez besteko helburu-funtzioaren balioa") + ggtitle("Instantzien exekuzioen batez bestekoak") + theme(plot.title = element_text(hjust = 0.5)) + expand_limits(y=0)

