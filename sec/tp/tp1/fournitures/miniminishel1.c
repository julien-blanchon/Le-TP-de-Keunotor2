#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h> /* wait */

int main(int argc, char const *argv[])
{
    /* code */
    char buf[100] = ""; /* La commande saisie au clavier (100 char max)*/
    int ret;            /* valeur de retour de scanf */
    char arg = "";
    char* arg_array[10];  /* array cmd+arguments (10*n char max)*/
    int i = 0;          /* compteur */
    int j = 0;          /* compteur */
    int k = 0;          /* compteur */

    printf(">>> ");
    ret = scanf("%100[^\n]s\n", &buf);
    if (ret != 1)
    {
        printf("/n Erreur: scanf");
        exit(EXIT_FAILURE);
    }

    i = 0;
    j = 0;
    k = 0;
    while (buf[i] != '\n' && buf[i] != '\0')
    {
        if (buf[i] == ' ')
        {
            j++;
            i++;
            k = 0;
            strcpy(arg_array[k], arg);
            arg = "";
        }

        //*(arg+k) = 
        i++;
        k++;

        if (i == 99) // trop d'arguments !
        {
            printf("/n Erreur: Commande trop longue");
            exit(EXIT_FAILURE);
        }
    }
    printf(">>> ");
    printf(">>> ");
    printf(">>> ");
    i = 4;
}



