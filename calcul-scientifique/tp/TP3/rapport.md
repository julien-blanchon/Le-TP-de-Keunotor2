---
# pandoc -s rapport.md -o rapport.pdf --template eisvogel --listings
title: "Rapport - TP3 : Classification bay ́esienne"
subtitle: "Première année - Département Sciences du Numérique"
author: "[Julien Blanchon](mailto:julien.blanchon@etu.toulouse-inp.fr)"
date: "4 Mars 2020"
keywords: [matlab]
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

# Classification bay ́esienne

L’objectif est de réaliser un classifieur bayésien permettant de classer les images de trois espèces de
fleurs (ne recopiez pas les images, afin de préserver votre quota). Lancez le script recup_donnees.m,
qui affiche des images de pensées, d’œillets et de chrysanthèmes. Vous constatez que ces images n’ont pas toutes la mˆeme taille.

## Exercice 1 - Calcul de la couleur moyenne d’une image

**Question 1**
 Au regard de cette figure, la couleur moyenne vous semble-t-elle une caractéristique suffisamment discriminante de ces trois espèces de fleurs ?

 Non car Oreillets et Pensée partages un même domaine de $\mathbb{R}^2$.

## Exercice 2 - Estimation de la vraisemblance de chaque esp`ece de fleurs

Rien

## Exercice 3 - Classification d’images de fleurs



