#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> /* exit */
int main(int argc, char *argv[]) {
    int tempsPere , tempsFils;
    int v = 5; /* utile pour la section 2.3 */ 
    pid_t pidFils;
    tempsPere = 120;
    tempsFils = 60;
    pidFils = fork();
    /* bonne pratique : tester syst ́ematiquement le retour des appels syst`eme */ 
    if (pidFils == -1) {
        printf("Erreur fork\n");
        exit (1);
        /* par convention , renvoyer une
        * diff ́erente pour chaque cause
        */ 
    }
    if (pidFils == 0) { 
        /* fils printf("processus %d (fils), de sleep(tempsFils);
        printf("fin du fils\n"); exit(EXIT_SUCCESS); /* bonne pratique :
        } */
    else { /* p`ere */
        printf("processus %d (p`ere), de p`ere %d\n", getpid(), getppid()); sleep(tempsPere);
        printf("fin du p`ere\n");
    }
    return EXIT_SUCCESS; /* -> exit(EXIT_SUCCESS); pour le p`ere */
}