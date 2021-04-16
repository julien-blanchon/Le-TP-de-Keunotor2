/* Exercice 1 - TP2 - Sec */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */

/* Traitant du signal */
void handler(int signal_num) {
    printf("\n     Processus de pid %d : J'ai reçu le signal %d\n", 
            getpid(), signal_num) ;
    return ;
}

/* dormir pendant nb_secondes secondes  */
/* à utiliser à la palce de sleep(duree), car sleep s'arrête */
/* dès qu'un signal non ignoré est reçu */
void dormir(int nb_secondes)
{
    int duree = 0 ;
    while (duree < nb_secondes) {
        sleep(1) ;
        if (duree % 5 == 0)
        {
            printf("\n     Je suis toujours actifs: %d s", duree);
        }
        duree++ ;
    }
}

int main()
{
    int fils, retour ;
    int duree_sommeil = 60 ;

    /* associer un traitant au signal SIGINT */
    for (int i = 0; i < 30; i++)
    {
        if (i != 9 && i != 19)
        { /* tout les signaux sauf SIGKILL et SIGSTOP. */
            signal(i, handler);
        }
    }    

    dormir(duree_sommeil + 2) ;
    return EXIT_SUCCESS ;
}