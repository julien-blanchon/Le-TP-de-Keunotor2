/* Exercice 2 - TP2 - Sec */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */
#include <setjmp.h>

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
        duree++ ;
    }
}
static jmp_buf buf;

void second()
{
    printf("second\n"); // prints
    longjmp(buf, 1);    // jumps back to where setjmp was called - making setjmp now return 1
}

void first()
{
    second();
    printf("first\n"); // does not print
}

int main()
{
    if (!setjmp(buf))
        first();          // when executed, setjmp returned 0
    else                  // when longjmp jumps back, setjmp returns 1
        printf("main\n"); // prints

    return EXIT_SUCCESS;
}