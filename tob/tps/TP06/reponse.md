---
##### pandoc -s reponse.md -o reponse.pdf
lang: fr-FR
title: TP 06 Tob
subtitle: Héritage comme spécialisation
author: Julien Blanchon
date: 08-02-2020
base: . %Base directory for import file
abstract: This is the abstract
keywords: [tob, java]
titlepage: true
titlepage-color: "FFFFFF"
titlepage-text-color: "000000"
titlepage-rule-color: "CCCCCC"
titlepage-rule-height: 4
header-left: "\\hspace{1cm}"
header-center: "\\leftmark"
header-right: "Page \\thepage"
footer-left: "\\thetitle"
footer-center: "This is \\LaTeX{}"
footer-right: "© \\theauthor"
subparagraph: true
output:
  pdf_document:
    fontsize: 12pt #10, 11 ou 12pt seulement
    # mainfont: "Roboto"
    # sansfont: "Raleway"
    # monofont: "IBM Plex Mono"
    geometry: [a4paper, bindingoffset=0mm, inner=30mm, outer=30mm, top=30mm, bottom=30mm] # Voir https://ctan.org/pkg/geometry pour les options geometry
path: reponse.pdf
# include-before: |
#     See these lines
#     Come __before__ the [toc](/dev/null)
toc: true
toc-own-page : true
toc-title: Table des matières
toc_depth: 2
lot: true
lof: true
#include-after: |
#    See these lines
#    Come __after__ the [article](/dev/null)
fontsize: 12pt #10, 11 ou 12pt seulement
# Voir https://tug.org/FontCatalogue/ et https://fonts.google.com/ pour les Fonts

# mathfont:
documentclass: article #Voir https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Document_classes pour les class et classoption
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
  - \usepackage{xcolor}
  - \definecolor{dkgreen}{rgb}{0,0.6,0}
  - \definecolor{gray}{rgb}{0.5,0.5,0.5}
  - \definecolor{mauve}{rgb}{0.58,0,0.82}
  - \lstset{
      frame=single,
      aboveskip=3mm,
      belowskip=3mm,
      showstringspaces=false,
      showspaces=false,
      showtabs=false,
      keepspaces,
      columns=flexible,
      basicstyle={\small\ttfamily},
      numbers=none,
      numberstyle=\tiny\color{gray},
      keywordstyle=\color{blue},
      commentstyle=\color{dkgreen},
      stringstyle=\color{mauve},
      backgroundcolor=\color[RGB]{248,248,248},
      breaklines=true,
      breakatwhitespace=true,
      breakautoindent=true,
      tabsize=2,
      captionpos=b,
      escapeinside={\%*}{*)},
      linewidth=\textwidth,
      basewidth=0.5em
      }
  - \lstset{
      inputencoding = utf8,
      extendedchars = true,
      literate      =      
        {á}{{\'a}}1  {é}{{\'e}}1  {í}{{\'i}}1 {ó}{{\'o}}1  {ú}{{\'u}}1
        {Á}{{\'A}}1  {É}{{\'E}}1  {Í}{{\'I}}1 {Ó}{{\'O}}1  {Ú}{{\'U}}1
        {à}{{\`a}}1  {è}{{\`e}}1  {ì}{{\`i}}1 {ò}{{\`o}}1  {ù}{{\`u}}1
        {À}{{\`A}}1  {È}{{\'E}}1  {Ì}{{\`I}}1 {Ò}{{\`O}}1  {Ù}{{\`U}}1
        {ä}{{\"a}}1  {ë}{{\"e}}1  {ï}{{\"i}}1 {ö}{{\"o}}1  {ü}{{\"u}}1
        {Ä}{{\"A}}1  {Ë}{{\"E}}1  {Ï}{{\"I}}1 {Ö}{{\"O}}1  {Ü}{{\"U}}1
        {â}{{\^a}}1  {ê}{{\^e}}1  {î}{{\^i}}1 {ô}{{\^o}}1  {û}{{\^u}}1
        {Â}{{\^A}}1  {Ê}{{\^E}}1  {Î}{{\^I}}1 {Ô}{{\^O}}1  {Û}{{\^U}}1
        {ø}{{\o}}1
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

```{.Java caption="test caption"}
class MaClasse{
  this.function{}
}
```

`class Maclass{}`{.Java}

Il faut que `X` soit un tableau dont les éléments ne sont pas privée pour pouvoir Point.afficher ...

2. Quel code sera exécuté pour x.afficher() et x.translater(4, -3) ?

`Point.afficher()` et `Point.translater(double, double)`

3. Indiquer les autres éléments à définir sur X ? Justifier la réponse.

ø

4. Donner un nom plus significatif à X.

`SchemaTab` serait plus significatif pour X.

# Exercice 2 : Écrire la classe X et adapter l’application

1. Est-ce que l’on sait écrire le code des méthodes afficher ou translater de X ?

Oui si tout les éléments de X possède les méthodes afficher et translater. 
Ce qui est la cas car X peut contenir soit un Point, soit un PointNomme, soit un Segment.
Il serait judicieux de faire un interface: ObjectGeometrique.

2. Peut-on créer des instances de X ?

Oui ?   

3. Quels constructeurs définir sur X ?

?

4. Quand ces constructeurs seront-ils appelés ?

Lors de la création de X ?

5. Écrire le code de la classe X.



6. Lister et effectuer les modifications à apporter aux autres classes de l’application.


# Exercice 3 : Construire le schéma en utilisant les listes

Au lieu d’utiliser un tableau comme dans l’exercice 2, on veut utiliser l’interface List et sa
réalisation ArrayList du paquetage java.util (en particulier la méthode add et la structure de
contrôle foreach).

1. Indiquer les avantages et inconvénients des listes par rapport aux tableaux.
   

2. Construire le schéma en utilisant une liste.


# Exercice 4 : Définir un groupe
Dans un éditeur de schémas mathématiques, il serait pratique de pouvoir grouper plusieurs X
pour les manipuler comme un seul et leur appliquer à tous, en une seule fois, la même opération
(translater, afficher, etc.).

1. Sachant que la classe X est abstraite, la classe Groupe est-elle abstraite ou concrète ?
   

2. Écrire la classe Groupe et l’utiliser (ExempleSchemaGroupe).
   

3. On souhaite pouvoir mettre un groupe dans un groupe. Par exemple, on souhaite grouper les
trois segments, puis ce groupe et le barycentre. Comment faire ?