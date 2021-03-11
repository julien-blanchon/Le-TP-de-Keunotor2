---
##### pandoc -s reponse.md -o reponse.pdf
lang: fr-FR
title: TP 06 Tob
subtitle: Héritage comme spécialisation
author: Julien Blanchon
date: 08-02-2020
abstract: blabla
keywords: [tob, java]
output:
pdf_document:
path: reponse.pdf
# include-before: |
#     See these lines
#     Come __before__ the [toc](/dev/null)
toc-title: Table des matières
toc: true
toc_depth: 2
#include-after: |
#    See these lines
#    Come __after__ the [article](/dev/null)
fontsize: 12pt #10, 11 ou 12pt seulement
# Voir https://tug.org/FontCatalogue/ et https://fonts.google.com/ pour les Fonts
# mainfont: "Merriweather"
# sansfont: "Raleway"
# monofont: "IBM Plex Mono"
# mathfont:
documentclass: article #Voir https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Document_classes pour les class et classoption
classoption: [notitlepage, onecolumn, openany]
geometry: [a4paper, bindingoffset=0mm, inner=30mm, outer=30mm, top=30mm, bottom=30mm] # Voir https://ctan.org/pkg/geometry pour les options geometry
# papersize: a4
header-includes:
### Format encodage
- \usepackage[utf8]{inputenc}
- \usepackage[T1]{fontenc}
### Format Code Ada
- \usepackage{listings}  # Package pour les blocks code (https://en.wikibooks.org/wiki/LaTeX/Source_Code_Listings)
- \usepackage{tcolorbox}
- \usepackage{fullpage}
- \usepackage{color}
- \definecolor{dkgreen}{rgb}{0,0.6,0}
- \definecolor{gray}{rgb}{0.5,0.5,0.5}
- \definecolor{mauve}{rgb}{0.58,0,0.82}
- \lstset{
  frame=tb,
  language=Java,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  columns=flexible,
  basicstyle={\small\ttfamily},
  numbers=none,
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{dkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=4
  }






---
\clearpage

# Exercice 1 : Formaliser le schéma
Dans la question 3.2 du TP 5, nous avons défini le schéma comme plusieurs objets (points, points
nommés et segments) qui sont référencés par des variables différentes. Il serait plus logique
et pratique d’avoir une seule variable qui représente le schéma (on l’appellera naturellement
schema). Comme un schéma est constitué d’un nombre variable d’éléments, on peut le représenter par un tableau. Si nous appelons X le type des éléments de ce tableau, nous pouvons alors
écrire le code du listing 1

1. Indiquer à quelles conditions sur `X` les lignes suivantes compilent.
