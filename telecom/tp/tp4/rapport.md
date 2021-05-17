---
# pandoc -s rapport.md -o rapport.pdf --template eisvogel --listings
title: "Rapport - TP3 : Etude de l’impact du bruit dans la chaine de transmission"
subtitle: "Première année - Département Sciences du Numérique"
author: "[Julien Blanchon](mailto:julien.blanchon@etu.toulouse-inp.fr)"
date: "25 Avril 2020"
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

# Chaine de référence

1. Donnez le TEB théorique de la chaine implantée, en expliquant pourquoi vous utilisez l’expression fournie (quelles sont les caractéristiques de la chaine qui font que cette expression est la bonne) :

Le $TEB$ théorique est $Q \left( \sqrt{\frac{2 E_{b}}{N_{0}}} \right)$ car la chaine de référence est:

- avec un *filtre mise en forme* et de *réception*, *rectangulaires* de dureé Ts et de hauteur 1
- avec *mapping binaire* à *moyenne nulle* et de symbole *independants* et *équiprobables*
- avec un *bruit blanc* et *gaussien*, de DSP $\frac{N_0}{2}$

Donc respecte Nyquist, $TEB=Q\left(\frac{g\left(t_{0}\right)}{\sigma_{w}}\right)=Q\left(\frac{T_S}{\sigma_{w}}\right)$ et $\sigma_{\omega} = \frac{N_0 Ts}{2}$ ainsi $TEB = Q \left( \sqrt{\frac{2 E_{b}}{N_{0}}} \right)$


2. Donnez les tracés superposés sur une même figure du TEB simulé et du TEB théorique afin de valider le bon fonctionnement de votre chaine de référence.

![Tracé en log du TEB simulé et théorique de la chaine de référence](figures/ChaineRefTEBEbN0.png)

# Première chaine à étudier, implanter et comparer à la chaine de référence

## Implantation de la chaine sans bruit

1. Utilisez le tracé du diagramme de l’oeil en sortie du filtre de réception sur la durée $T$ ($N$ échantillons) pour proposer des instants d’échantilllonnage $t_0 + m T_s$, en expliquant votre choix.

![Diagramme de l'oeil en sortie du filtre de réception de la chaine 1](figures/Chaine1OeilSansBruit.png)

L'instant optimal d'echantillonage est donc $2$ pour ne pas avoir d'interférence entre symboles.

2. Proposez le seuil optimal à utiliser ici pour la décision en expliquant votre choix.

Le seuil optimal avec comme mapping $a_k \in \left\{ -1, 1 \right\}$ est logiquement $0 = \frac{(+g(t_0)) + (-g(t_0))}{2}$ car on aura $z_m = a_m g(t_0)$, et donc logiquement localisée en $-g(t_0)$ et $+g(t_0)$.

![Distribution de $z_m$](figures/chaine1_distribution.png)


## Implantation de la chaine avec bruit

1. Donnez les tracés superposés sur une même figure du TEB simulé et du TEB théorique afin de valider le bon fonctionnement de votre chaine.

![Tracé en log du TEB simulé et théorique de la chaine de 1](figures/Chaine1TEBEbN0.png)

2. Comparez la chaine de transmission implantée ici à la chaine de transmission de référence en termes d’efficacité en puissance. La chaine éventuellement la plus efficace en puissance devra être identifiée, en expliquant ce qui la rend plus efficace si c’est le cas (vous vous appuierez, pour cela, sur les tracés réalisés durant les TPs et les études réalisées en cours et TD).

![Tracé en log du TEB simulé et théorique de la chaine de 1 et la chaine de référence](figures/ComparaisonChaineRefEt1TEB.png)

*Efficacité en puissance de la transmission* : SNR(Eb/N0) par bit nécessaire à l’entrée du récepteur pour atteindre le TEB souhaité

La chaine de référence est plus efficasse car pour la chaine 1 le critere de filtrage adapté n’est pas respecté ainsi le SNR aux instants de décision n’est donc pas maximisé et logiquement le TEB pour un $\frac{E_b}{N_0}$ est grand. Ainsi pour atteindre un TEB donnée il faut une plus grand $\frac{E_b}{N_0}$ avec la chaine 1 que la chaine de référence donc l'efficacité spectral de la chaine de référrence est plus performante.
En l'occurence les deux chaines correspondent aux exercice 1 et 2 du TD3.

3. Comparez la chaine de transmission implantée ici à la chaine de transmission de référence en termes d’efficacité spectrale. La chaine éventuellement la plus efficace spectralement devra être identifiée, en expliquant ce qui la rend plus efficace si c’est le cas (vous vous appuierez, pour cela, sur les tracés réalisés durant les TPs et les études réalisées en cours et TD).

*Efficacité spectrale de la transmission* : Bande B nécessaire pour passer le débit Rb souhaité 

L'efficacité spectrale dépend de $\frac{log_{2}(M)}{k}$ avec $M$ l'ordre de modulation et $k$ est fonction du filtre de mise en forme. Ainsi la chaine de référence et la chaine 1 ont la même efficacité spectrale car elles ont le même $M$ et le même filtre de mise en forme.

# Deuxième chaine à étudier, implanter et comparer à la chaine de référence

## Implantation de la chaine sans bruit

1. Utilisez le tracé du diagramme de l’oeil en sortie du filtre de réception sur la durée $T$ ($N$ échantillons) pour proposer des instants d’échantilllonnage $t_0 + m T_s$, en expliquant votre choix.

![Diagramme de l'oeil en sortie du filtre de réception de la chaine 2](figures/Chaine2OeilSansBruit.png)

L'instant optimal d'echantillonage est donc $8$ pour ne pas avoir d'interférence entre symboles.

2. Proposez les seuils optimaux à utiliser ici pour la décision en expliquant votre choix.

Les seuils optimaux sont $-16$, $0$ et $+16$ (qui sépare donc $\mathbb{R}$ en $4$).

Car on aura $z_m = a_m g(t_0)$, et donc logiquement localisée en $-3g(t_0)$, $-g(t_0)$, $g(t_0)$, $3g(t_0)$.

Avec $g(t_0) = g(8) = 8$ avec $g = conv(h1, hr1)$. Ainsi le point médiant entre $\pm 24$ et $\pm 8$ est $\pm 16$ et entre $-8$ et $+8$, $0$.

## Implantation de la chaine avec bruit

1. Donnez les tracés superposés sur une même figure du TES simulé et du TES théorique donné dans l'énoncé : $T E S=\frac{3}{2} Q\left(\sqrt{\frac{4}{5} \frac{E_{b}}{N_{0}}}\right) .$ La similitude ou différence obtenue entre le TES simulé et le TES théorique donné devra être expliquée.

![Tracé en log du TES simulé et théorique de la chaine de 2](figures/Chaine2TESEbN0.png)

Les deux courbes correspondent bien cependant pour cela on à du prendre un nombre de bit ($N$) élevé pour rendre l'erreur $\epsilon^{2}=\frac{\sigma_{T E B}^{2}}{m_{T E B}^{2}}=\frac{1-p}{N p} \simeq \frac{1}{N p}$ plus faible.

2. Donnez les tracés superposés sur une même figure du TEB obtenu par simulation sur la chaine implantée et du TEB théorique suivant :
$$
T E B=\frac{3}{4} Q\left(\sqrt{\frac{4}{5} \frac{E_{b}}{N_{0}}}\right)
$$
La similitude ou différence obtenue devra être expliquée. La chaine éventuellement la plus efficace en puissance devra être identifiée, en expliquant ce qui la rend plus efficace si c'est le cas.

![Tracé en log du TEB simulé et théorique de la chaine de 2](figures/Chaine2TEBEbN0.png)

Étrangement les deux courbes ne correspondaient absolument pas, cependant j'ai remarqué que le problème venait du coéfficient $\frac{3}{4}$.

Cela est surement du au fait que le chaine 2 ne respecte pas le *mapping de gray*, ainsi le calcul théorique avec le coéfficient $\frac{3}{4}$ n'est plus valide.

3. Comparez la chaine de transmission simulée ici à la chaine de référence en termes d’efficacité en puissance en expliquant votre réponse (vous vous appuierez, pour cela, sur les tracés réalisés durant les TPs et les études réalisées en cours et TD).

La chaine de référence est plus efficasse car pour la chaine 2 le critere de filtrage adapté n’est pas respecté ainsi le SNR aux instants de décision n’est donc pas maximisé et logiquement le TEB pour un $\frac{E_b}{N_0}$ est grand. Ainsi pour atteindre un TEB donnée il faut une plus grand $\frac{E_b}{N_0}$ avec la chaine 2 que la chaine de référence donc l'efficacité spectral de la chaine de référrence est plus performante

Cela se retrouve comme pour la chaine 1 sur le graph $TEB = f(\frac{E_b}{N_0})$ :

![Tracé en log du TEB simulé et théorique de la chaine de 2 et la chaine de référence](figures/ComparaisonChaineRefEt2TEB.png)

4. Comparez la chaine de transmission simulée ici à la chaine de référence en termes d’efficacité spectrale en expliquant votre réponse (vous vous appuierez, pour cela, sur les tracés réalisés durant les TPs et les études réalisées en cours et TD).

*Efficacité spectrale de la transmission* : Bande B nécessaire pour passer le débit Rb souhaité 

L'efficacité spectrale dépend de $\frac{log_{2}(M)}{k}$ avec $M$ l'ordre de modulation et $k$ est fonction du filtre de mise en forme. La chaine de référence et la chaine 2 ont le même filtre de mise en forme donc le même $k$. Cependant les ordres sont différents, $M=4$ pour la chaine 2 et $M=2$ pour la chaine de référence. Donc la chaine 2 est plus efficace spectralement.