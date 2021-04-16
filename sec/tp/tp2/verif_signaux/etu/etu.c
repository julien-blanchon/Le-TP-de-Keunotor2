/* Exercice 1 - TP2 - Sec */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */

/* Traitant du signal */
void handler_print(int signal_num) {
    printf("\n~~~~~~ Reception %d\n", signal_num);
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
        duree++ ;
    }
}

int main()
{

    printf("Salut --> \n");
    signal(SIGUSR1, handler_print);
    signal(SIGUSR2, handler_print);

    /*ens1 avec SIGINT*/
    sigset_t ens1;
    sigemptyset(&ens1);
    sigaddset(&ens1, SIGINT);

    /*ens2 avec SIGUSR1*/
    sigset_t ens2;
    sigemptyset(&ens2);
    sigaddset(&ens2, SIGUSR1);

    //printf("Masquage de SIGINT\n");
    sigprocmask(SIG_BLOCK, &ens1, NULL);
    //printf("Masquage de SIGUSR1\n");
    sigprocmask(SIG_BLOCK, &ens2, NULL);
    //printf("Attente 10s ...\n");
    sleep(10);
    //printf("\n \t \t !! RAISE signal 30 !!");
    raise(SIGUSR1);
    //printf("\n \t \t !! RAISE signal 30 !!");
    raise(SIGUSR1);
    //printf("\nAttente 5s");
    sleep(5);
    //printf("\n \t \t !! RAISE signal 31 !!");
    raise(SIGUSR2);
    //printf("\n \t \t !! RAISE signal 31 !!");
    raise(SIGUSR2);
    //printf("Demasquage de SIGINT\n");
    sigprocmask(SIG_UNBLOCK, &ens2, NULL);
    //printf("Attente 10s ...\n");
    sleep(10);
    //printf("Demasquage de SIGUSR1\n");
    sigprocmask(SIG_UNBLOCK, &ens1, NULL);
    return EXIT_SUCCESS ;
}