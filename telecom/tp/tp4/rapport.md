---
# pandoc -s rapport.md -o rapport.pdf --template eisvogel --listings
title: "Rapport - TP4 : Introduction aux communications numériques Etude de chaines de transmission sur porteuse"
subtitle: "Première année - Département Sciences du Numérique"
author: "[Julien Blanchon](mailto:julien.blanchon@etu.toulouse-inp.fr)"
date: "17 Mai 2020"
keywords: [telecom, matlab, signal]
lang: "fr-FR"
titlepage: true,
titlepage-rule-color: "360049"
titlepage-rule-height: 13
#titlepage-background: "~/Documents/backgrounds/background3.pdf"
#logo: "figures/inp-enseeiht.png"
#logo-width: 65mm
#page-background: "~/Documents/backgrounds/background1.pdf"

base: . %Base directory for import file

header-left: "\\hspace{1cm}"
header-center: "\\leftmark"
header-right: "Page \\thepage"
footer-left: "\\thetitle"
footer-center: ""
footer-right: "[© Julien Blanchon](mailto:julien.blanchon@etu.toulouse-inp.fr)"

subparagraph: true

output:
pdf_document:
    fontsize: 12pt #30, 11 ou 12pt seulement
    # mainfont: "Roboto"
    # sansfont: "Raleway"
    # monofont: "IBM Plex Mono"
    geometry: [a4paper, bindingoffset=0mm, inner=30mm, outer=30mm, top=30mm, bottom=30mm] # Voir https://ctan.org/pkg/geometry pour les options geometry

toc: true
toc-own-page : true
toc-title: Table des matières
toc_depth: 2
lot: false
lof: true

documentclass: article
...	

# Utilisation de la chaine passe-bas équivalente pour le calcul et l’estimation du taux d’erreur binaire

1. Expliquez les résultats obtenus pour les DSPs du signal modulé sur porteuse et de l’enveloppe complexe associée.

![DSPs du signal modulé sur porteuse et de l'enveloppe complexe associée](figures/DSP_env_complx.png)

La DSP du signal modulé sur porteuse se retrouve dupliquée en $-f_p$ et $+f_p$, tandis que l'enveloppe complexe initial est centrée sur $0$ (bande base).

2. Comparez les TEBs obtenus en implantant la chaine de transmission sur porteuse et la chaine passe-bas équivalente.

![TEB de la chaine de transmission sur porteuse](figures/Chaine2TEB.png)
![TEB de la chaine de transmission passe-bas équivalente](figures/Chaine3TEB.png)

Les deux courbes sont quasiment les mêmes, le fait que l'on soit sur porteuse ou avec le passe-bas équivalent n'importe pas.


# Comparaison de modulations sur fréquence porteuse

1. En utilisant les tracés obtenus pour leurs TEBs, comparez et classez les différentes chaines de transmission en termes d’efficacité en puissance. Expliquez votre classement.

![TEBs des différentes chaines de transmission](figures/ComparaisonTEB.png)

Pour avoir une *TEB* données la chaine de transmission qui nécessite le $\frac{E_b}{N_0}$ le plus faible est la 4-PSK. C'est donc le plus efficace en puissance. Ensuite dans l'ordre on a, la 8-PSK, puis la 4-ASK et enfin la 16-QAM.

2. En utilisant les tracés des densités spectrales de puissance des signaux émis, comparez et classez les différentes chaines de transmission implantées en termes d’efficacité spectrale. Expliquer votre classement.

L'efficacité spectrale est donnée par $\nu = \frac{log_2(M)}{k}$ avec $B = k*Ts$

![DSPs des différentes chaines de transmission](figures/ComparaisonDSP.png)

![DSPs de la 4-ASK](figures/ComparaisonPwelch4ASK.png)
![DSPs de la 4-PSK](figures/ComparaisonPwelch4PSK.png)
![DSPs de la 8-ASK](figures/ComparaisonPwelch8ASK.png)
![DSPs de la 16-QAM](figures/ComparaisonPwelch16QAM.png)
   
| Modulateur    | Bande($-50d_B$)	|
| --------------|:-----------------:|
| *4-ASK*	    | $B_1 = 1000Hz$	|
| *4-PSK*	    | $B_2 = 1000Hz$    |
| *8-PSK*	    | $B_3 = 500Hz$     |
| *16-QAM*	    | $B_3 = 500Hz$     |

Ainsi on a: 

| Modulateur    | Bande($-50d_B$)	| $R_s = \frac{1}{T_s}$| $k$ | $M$ | $\nu$ |
| --------------|:-----------------:|:---------:|:-----:|:-----:|:-----:|
| *4-ASK*	    | $B_1 = 1000Hz$	| $1000Hz$	| $1$   | $4$   | $2$   |
| *4-PSK*	    | $B_2 = 1000Hz$    | $1000Hz$	| $1$   | $4$   | $2$   |
| *8-PSK*	    | $B_3 = 500Hz$     | $666Hz$	| $0.75$| $8$   | $4$   |
| *16-QAM*	    | $B_3 = 500Hz$     | $500Hz$	| $1$	| $16$	| $4$	|

Donc *16-QAM* > *8-PSK* > *4-PSK* > *4-ASK*

(Les calculs semble faux :( !)