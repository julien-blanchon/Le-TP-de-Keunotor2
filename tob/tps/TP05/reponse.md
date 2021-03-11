---
##### pandoc -s reponse.md -o reponse.pdf
lang: fr-FR
title: TP 05 Tob
subtitle: Héritage comme spécialisation
author: Julien Blanchon
date: 08-02-2020
abstract: |
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
- \lstset{language=Java}
- \usepackage{tcolorbox}
- \usepackage{fullpage}
- \usepackage{color}
- \definecolor{dkgreen}{rgb}{0,0.6,0}
- \definecolor{gray}{rgb}{0.5,0.5,0.5}
- \definecolor{mauve}{rgb}{0.58,0,0.82}
- \lstset{
    frame=tb,
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
- \lstset{
    inputencoding = utf8,
    extendedchars = true,
    literate= {á}{{\'a}}1 
            {à}{{\`a}}1
            {é}{{\'e}}1 
            {è}{{\`e}}1
            {ê}{{\^e}}1
            {í}{{\'i}}1 
            {ó}{{\'o}}1 
            {ú}{{\'u}}1
    }







---

# Exercice 1 :  Comprendre la classe PointNommé

*À partir du texte source de la classe PointNommé, expliquer les différents éléments de cette
classe et dessiner le diagramme de classes UML avec cette classe PointNommé.*


Cette classe est constituée de 3 attributs: `vx`, `vy` et `sonNom`. 

## Nom : 
(Class) **PointNomme**

## Attribut:
- *double* vx
- *double* vy
- *String* sonNom

## Méthode:
- **commande**:
    - *void* setNom(*String* sonNom)
    - *void* afficher()
    - *void* dessiner(*Afficheur* afficheur)
    
- **requête**:
    - *String* getNom()
    
## Constructeur:
- *void* PointNomme(*double* vx, vy, *String* sonNom)

# Exercice 2 : Comprendre la relation d’héritage entre Point et PointNomme
\lstinputlisting{Point.java}[frame=single]

\lstinputlisting{PointNomme.java}[frame=single]

# Exercice 3 : Segments et points nommés

## Peut-on créer un segment à partir d’un point et d’un point nommé ? Comment serait affiché un tel segment ? Justifier les réponses.

Oui (d'aprés le principe de substitution), ainsi il s'afficherais avec PointNomme.afficher() et donc `sonNom : (x, y)`.