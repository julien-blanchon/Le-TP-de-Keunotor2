---
# pandoc -s rapport.md -o rapport.pdf --template eisvogel --listings
title: "Rapport - TP2 : Étude de l’interférence entre symbole et du critère de Nyquist"
subtitle: "Première année - Département Sciences du Numérique"
author: "[Julien Blanchon](mailto:julien.blanchon@etu.toulouse-inp.fr)"
date: "20 Mars 2020"
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
lof: false

documentclass: article
...	

# Étude sans canal de propagation : bloc modulateur/démodulateur

1. Expliquez comment sont obtenus les instants optimaux d’échantillonnage (permettant d’échantillonner
sans interférences entre symboles) :

- A partir du tracé de g:

![Réponse impulsionnelle globale de la chaine 1 de transmission en symbole ($/T_{s}$): $g$\label{rep_g1}](figures/Chaine1_g.png)

Pour ne obtenir les instants optimaux d'échantillonage symbole $n_{0}$ il faut échantilloner pour une valeur de $t_0$ ou plutôt de $n_0$
qui ferrais que la réponse centré et normalisé $g^{(t_{0})}$ respecterais le critaire de Nyquist en fréquentielle:
$$\left\{\begin{array}{l}
g\left(t_{0}\right) \neq 0 \\
g\left(t_{0}+p T_{s}\right)=0 \text { for } p \in \mathbb{Z}^{*}
\end{array}\right.$$
Ainsi on prend l'instant maximal de la chaque réponse impulsionnelle (instant sur lequelle on voudrais centrée $g$).
Modulo $N_{s}=8$ on trouve:

Filtre     Bande($-30d_B$)
---------  ----------
*filtre 1*    $2$
*filtre 2*    $1$
---------  ----------


- A partir du tracé du diagramme de l’oeil en sortie du filtre de réception:

![Diagramme de l'oeil de la Chaine 1\label{diag_oeil1}](figures/Chaine1_Oeil.png)
Pour ne obtenir les instants optimaux d'échantillonage symbole $n_{0}$ il faut échantilloner lorsque l'interférence entre symboles est nulle
ou presque nulle pour ainsi respecter le critaire de Nyquist en temporelle:
$$\left\{\begin{array}{l}
\sum_{k} G^{\left(t_{0}\right)}\left(f-\frac{k}{T_{s}}\right)=cte \\
G^{t_{0}}(f)=\operatorname{TF}\left[\frac{g\left(t+t_{0}\right)}{g\left(t_{0}\right)}\right]
\end{array}\right.$$

Pour cela on peu tracer le diagramme de l'oeil du signal en sortie du filtre de réceptions. C'est a dire dire superposé
des tranches de taille *N_{s}* du signal. Ainsi les instants optimaux sont obtenus lorsque toutes les tranches passe par seulement $n$
points avec $n$ le nombre de symboles.
Sur la figure \ref{diag_oeil1} on peut voir que les instants optimaux sont:

Filtre     Bande($-30d_B$)
---------  ----------
*filtre 1*    $2$
*filtre 2*    $1$
---------  ----------

2. Expliquez pourquoi le le taux d’erreur binaire de la transmission n’est plus nul lorqu’on échantillonne à $n0$ + mNs, avec $n0$ = 3.

Il a alors des interférence entre symboles ainsi $z(t_0 + mT_s) ≠ a_mg(t_0)$ donc il est beaucoup plus probable de faire des erreur.

# Étude avec canal de propagation sans bruit

Le crit`ere de Nyquist peut-il être vérifié sur cette chaine de transmission :

- Pour BW = 4000 Hz ?

- Pour BW = 1000 Hz ?

1. Expliquez votre réponse (oui ou non) en utilisant le tracé, sur la même figure, de |H(f)Hr(f)| et de
|Hc(f)|, où H(f) est la réponse en fréquence du filtre de mise en forme, Hr(f) la réponse en fréquence
du filtre de réception et Hc(f) la réponse en fréquence du filtre canal.

2. Expliquez votre réponse (oui ou non) en utilisant le tracé le diagramme de l’oeil à la sortie du filtre de
réception.

## BW = 4000 Hz
$H \times Hr$ seul satisfait le critere de Nyquiste.

![$H1$ pour $BW=4000Hz$](figures/Chaine2_H1_4000.000000.png)
![$H2$ pour $BW=4000Hz$](figures/Chaine2_H2_4000.000000.png)
![$log_{10}(H1)$ pour $BW=4000Hz$](figures/Chaine2_logH1_4000.000000.png)
![$log_{10}(H2)$ pour $BW=4000Hz$](figures/Chaine2_logH2_4000.000000.png)

- Réponse en fréquence:

Pour le **Canal1**: Le support du canal $|Hc|$ c'est trop petit on ne récupere
pas totalement $H \times Hr$. Ne sattisfait pas Nyquiste.
Pour le **Canal2**: Le support du canal $|Hc|$ est suffisamenent grand pour
récupérer entierement $H \times Hr$. Satisfait pas Nyquiste.

- Diagramme de l'oeil:
Pour le **Canal1**: Ne satisfait pas Nyquist (aucun $n0$ valide) : le mieux est
entre 2 et 3.
Pour le **Canal2**: Satisfait presque Nyquist avec entre 1 et 2

## BW = 1000 Hz
$H \times Hr$ seul satisfait le critere de Nyquiste.

![$H1$ pour $BW=1000Hz$](figures/Chaine2_H1_1000.000000.png)
![$H2$ pour $BW=1000Hz$](figures/Chaine2_H2_1000.000000.png)
![$log_{10}(H1)$ pour $BW=1000Hz$](figures/Chaine2_logH1_1000.000000.png)
![$log_{10}(H2)$ pour $BW=1000Hz$](figures/Chaine2_logH2_1000.000000.png)

- Réponse en fréquence:

Pour le Canal1: Le support du canal $|Hc|$ c'est BEAUCOUP trop petit on ne récupere
pas totalement $H \times Hr$. Ne satisfait pas Nyquiste.
Pour le Canal2: Le support du canal $|Hc|$ c'est trop petit on ne récupere
pas totalement $H \times Hr$. Ne satisfait pas Nyquiste.

- Diagramme de l'oeil:

Pour le Canal1: Ne satisfait pas Nyquist (aucun $n0$ valide).

Pour le Canal2: Ne satisfait pas Nyquist (aucun $n0$ valide).
