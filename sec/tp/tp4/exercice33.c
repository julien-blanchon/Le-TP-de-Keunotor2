/* Exercice 3.3 - TP4 - Sec */
/*
(couplage en lecture) un processus père crée un tube, puis un fils.
Le père écrit une série d’entiers dans le tube, puis attend (par appel à pause), 
puis se termine. Le fils effectue une boucle consistant à lire un entier du tube, 
afficher l’entier et la valeur retournée par read(...), jusqu’à ce que cette valeur soit ≤ 0. 
Une fois sorti de la boucle, le fils affiche un message "sortie de boucle", puis se termine.
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
        int n, rd;
        do
        {
            rd = read(p[0], &n, sizeof(n));
            printf("%d %d", n, rd);
        } while ( rd>0 );
        printf("sortie de boucle");
        close(p[0]);
        exit(EXIT_SUCCESS);
    }
    else
    { /* fork pere */
        printf(">pere\n");
        for (size_t i = 0; i < 10; i++)
        {
            write(p[1], &i, sizeof(i));
        }
        pause();
        close(p[0]); /*sortie du tube*/        
        exit(EXIT_SUCCESS);
    }

    return 0;
}
