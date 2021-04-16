/* Exercice 1 - TP2 - Sec */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */
#include <sys/wait.h> /* wait */

/* Traitant du signal */
void handler(int signal_num) {
    printf("\n     \t Processus de pid %d : J'ai reçu le signal %d\n", 
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
            printf("\n     \t Je suis toujours actifs: %d s", duree);
        }
        duree++ ;
    }
}

int main()
{
    int retour ;
    pid_t fils_pid;
    int codeTerm;
    int duree_sommeil = 60 ;

    /* associer un traitant au signal SIGINT */
    for (int i = 0; i < 30; i++)
    {
        if (i != 9 && i != 19)
        { /* tout les signaux sauf SIGKILL et SIGSTOP. */
            signal(i, handler);
        }
    }

    retour = fork();

    /* Bonne pratique : tester systématiquement le retour des appels système */
    if (retour < 0)
    { /* échec du fork */
        printf("Erreur fork\n");
        /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
        exit(1);
    }

    /* fils */
    if (retour == 0)
    {
        printf("\nProcessus fils (%d)\n", getpid());
        execl("/bin/sleep", "/bin/sleep", "100", NULL); /*Donc remet a zero les signaux !*/
        /* Important : terminer un processus par exit */
        printf("\nErreur execl fils !");
        //exit(EXIT_FAILURE); /* Terminaison annormale (1 = avec erreur) */
    }

    /* pere */
    else
    {
        printf("\nProcessus pere (%d)\n", getpid());
        fils_pid = wait(&codeTerm);
        if (WIFEXITED(codeTerm))
        { //exit()
            int exit_status = WEXITSTATUS(codeTerm);
            printf("Fin du fils avec exit : [%d]\n", exit_status);
        }
        else if (WIFSIGNALED(codeTerm))
        { //signal()
            int sig_status = WTERMSIG(codeTerm);
            printf("Fin du fils avec signal : [%d]\n", sig_status);
        }

        return EXIT_SUCCESS;
    }
}