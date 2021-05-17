/* Exercice 3.1 - TP4 - Sec */
/*
(accès aux tubes) un processus père crée un fils, puis crée un tube. 
Le père écrit un entier dans le tube, le fils lit un entier dans le tube 
et affiche l’entier lu.
*/

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */
#include <sys/wait.h> /* wait */

#include <unistd.h> /* ??? */
#include <fcntl.h>  /* O_WRONLY ...*/

int main(int argc, char const *argv[])
{
    int p[2];

    if (pipe(p) == -1)
    {
        perror("Erreur pipe");
        exit(EXIT_FAILURE);
    }

    pid_t pidFils = fork();

    if (pidFils == -1)
    { /* Erreur fork */
        perror("Erreur fork");
        exit(EXIT_FAILURE);
    }
    else if (pidFils == 0)
    { /* fork fils */
        printf(">fils\n");
        close(p[1]); /*entrée du tube*/
        int n;
        read(p[0], &n, sizeof(n));
        close(p[0]);
        printf("%d", n);
        exit(EXIT_SUCCESS);
    }
    else
    { /* fork pere */
        printf(">pere\n");
        close(p[0]); /*sortie du tube*/
        int n = 4;
        write(p[1], &n, sizeof(n));
        exit(EXIT_SUCCESS);
    }

    return 0;
}

