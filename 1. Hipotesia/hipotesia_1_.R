library(ggplot2)
library(gridExtra)

setwd("C:/Users/USR/OneDrive/Documentos/3. Urtea/BH/CDP")


SA <- c(0.1997948193128971,0.24525373700770237,0.19469231683455862,0.26355390276465585,0.24627736673814582,0.23153196544153273,0.22517815442665715,0.24031023973483817,0.2590805614556275,0.26869602166355366,0.23528781791984812,0.2193232482566848,0.21205903031642725,0.2561275966289972,0.25726822582716236,0.28535310793902274,0.19654257323912333,0.2030258698309242,0.1898596530495626,0.24388211478927224,0.25011969708390774,0.18812662733696417,0.21358349176047817)
UMDA <- c(0.22032583658087787,0.2521226385645969,0.24583233714221325,0.21461012740610025,0.24116438209405616,0.22901416464306917,0.18334483288576026,0.2395014173275441,0.21128219392962366,0.2014130807254707,0.25214367997084725,0.2386539804714169,0.17415852487564373,0.23819291932786502,0.15874758312858428,0.23178099395286939,0.2477256783310049,0.2678895114987046,0.20650625715928067,0.21136905717081106,0.23559172365188175,0.2011467103957958,0.22613503742518548)


if (length(SA) != length(UMDA))
{
  stop("length(SA) != length(UMDA)")
}

n <- length(SA)




# BOXPLOT
pdf("hipotesi1_boxplot.pdf")
boxplot(SA, UMDA, names = c("SA", "UMDA"))
dev.off()



# SIGN TEST (FOR PROBABILITY OF "SA" > "UMDA" or "UMDA" > "SA")

# Measure the number of 'non ties'
n_without_ties <- sum(sign(SA - UMDA) != 0)

# Measure the number of success
n_success <- sum(sign(SA - UMDA) == 1)

binom.test(n_success, n_without_ties, alternative = "two.sided")



# HISTOGRAM
nbins = 20

dataHist <- data.frame(
  value=c(SA,UMDA),
  type=c(rep("Name SA", length(SA)), rep("Name UMDA",  length(UMDA)))
)

fig <- ggplot(data=dataHist, aes(x=value, fill=type)) +
  geom_histogram(alpha=0.65, position = 'identity', bins = nbins) +
  scale_fill_manual(values=c("#1f77b4", "#ff7f0e")) +
  ggplot2::xlab('score') +
  ggplot2::ylab('count') +
  ggplot2::theme_minimal() +
  labs(fill="")
ggsave("hipotesia1_histogram.pdf", plot=fig,  width = 4, height = 2, device="pdf")


# CUMULATIVE DIFFERENCE PLOT

is_minimization <- FALSE
cumulative_difference_plot(SA, UMDA,
                           isMinimizationProblem = is_minimization,
                           labelA = "Name SA", labelB = "Name UMDA", ignoreMinimumLengthCheck = TRUE)