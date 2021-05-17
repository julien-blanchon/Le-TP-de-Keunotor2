/* Exercice 1 - TP4 - Sec */ /*commande ls*/

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */
#include <sys/wait.h> /* wait */

#include <unistd.h> /* ??? */
#include <fcntl.h> /* O_WRONLY ...*/

int main(int argc, char const *argv[])
{
    if (argc != 2)
    {
        perror("Nombre d'arguments !");
        exit(EXIT_FAILURE);
    }

    int fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1)
    {
        perror("Erreur open");
        exit(EXIT_FAILURE);
    }
    
    int du = dup2(fd, STDOUT_FILENO);
    if (du == -1)
    {
        perror("Erreur dup2");
        exit(EXIT_FAILURE);
    }
    
    int cls = close(fd);
    if (cls == -1)
    {
        perror("Erreur close");
        exit(EXIT_FAILURE);
    }

    execlp("ls", "ls", "-u", NULL);
    perror("Erreur exec");
    exit(EXIT_FAILURE);
    
}
