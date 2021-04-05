#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h> /* wait */

int main(int argc, char const *argv[])
{
    char buf[30] = "";  /* La commande saisie au clavier (30 char max)*/
    int ret;            /* valeur de retour de scanf */
    char *arg;          /* argument */
    char *arg_array[30];/* array cmd+arguments (30 string max)*/
    int i = 0;          /* compteur i*/
    int j = 0;          /* compteur j*/
    int k = 0;          /* compteur k*/

    printf(">>> ");
    ret = scanf("%100[^\n]s\n", &buf);
    if (ret != 1)
    {
        printf("/n Erreur: scanf");
        exit(EXIT_FAILURE);
    }

    i = 0;
    arg = strtok(buf, " ");
    while (arg != NULL)
    {
        arg_array[i] = arg;
        i++;
        arg = strtok(NULL, " ");
    }
    arg_array[i] = NULL;

    execvp(arg_array[0], arg_array);
}



