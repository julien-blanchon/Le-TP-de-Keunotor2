Avertissement
-------------
Le script de vérification `verif.sh` doit être considéré comme un simple outil mis à votre
disposition, pour vous fournir une indication quant à la viabilité de vos réponses, et non 
comme une application de validation automatique de votre travail. Simplement, si vous passez
la vérification, vous pouvez avoir bon espoir quant à l'évaluation effective. Et inversement.

En particulier :

  - il est inutile de modifier le script pour qu'il donne des réponses `OK`: la validation
  se fera sur nos propres outils.
  - le script n'est pas protégé contre les erreurs résultant de (mauvaises) actions liées
  à l'exécution de vos programmes. Par exemple si vos commandes détruisent des fichiers
  de manière intempestive, le script de vérification peut devenir invalide.
  Il est donc prudent de prévoir une sauvegarde de l'original, si vous voulez être prémunis
   contre ce genre d'accidents.
  - en revanche, le script de vérification fonctionne bien avec des réponses correctes.
    Par conséquent, si une erreur est signalée sur une ligne du script, vous pouvez être
    quasi-certains que cela découle d'une erreur dans l'exercice qui est en cours de test
    autour de cette ligne, et non pas dans le script de test.

Conventions de nommage
----------------------

Pour que le script de vérification `verif.sh` puisse être appliqué :

  - pour chaque question, la réponse devra être fournie dans un fichier distinct
  - le nom du fichier réponse sera **exactement** composé du numéro de la question, 
    précédé d'un 'F' si la question est un exercice sur les filtres, 
    et d'un 'S' si la question est un exercice sur les scripts.   
    Par exemple, 'F8' serait le nom du fichier contenant la réponse à l'exercice 8 du TP filtres. 
  - les fichiers contenant les réponses devront être placés dans le même répertoire que
    `verif.sh`, au même niveau que `verif.sh`.
  - les fichiers contenant les réponses devront être exécutables (appliquer `chmod`au besoin)
  - le répertoire contenant `verif.sh` ne devra pas être modifié, en dehors de l'ajout des
    fichiers de réponse.
  
Conventions de lancement
------------------------

Pour les exercices du TP filtres, les énoncés font souvent mention d'un "fichier donné".
Pour le script de vérification, cela est compris comme un fichier donné *en paramètre*,
et le script de vérification s'attend à ce que la réponse désigne ce fichier comme `$1`. 
Par exemple, pour l'énoncé  
"Afficher les 10 premières lignes d'un fichier donné"  
la réponse attendue serait  
`head $1`

Appel et résultats du script de vérification
--------------------------------------------

Le script `verif.sh` doit être lancé depuis un terminal, le répertoire courant étant le
répertoire contenant `verif.sh`.

Le script `verif.sh` vérifie les réponses dans l'ordre lexicographique des noms de fichier.
Si une réponse est manquante ou en échec le script affiche `KO` pour cette réponse, sinon
il affiche `OK`.  
Notez que la mention `OK` est une condition nécessaire pour que la réponse soit juste,
mais que ce n'est pas une condition suffisante.

Lorsque le script `verif.sh` se termine, il affiche un message `fini`. Il est possible
qu'une réponse provoque le blocage du script. Dans ce cas, il faut tuer le processus
exécutant le script, et corriger (ou supprimer/renommer) la réponse ayant provoqué
 le blocage (qui devrait être la réponse suivant la dernière réponse pour laquelle `KO`
  ou `OK` a été affiché)
  
  