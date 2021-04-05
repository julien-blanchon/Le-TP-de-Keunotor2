#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> //Pour les var d'env
#include <sys/wait.h> /* wait */

extern char **environ;

int main(int argc, char const *argv[], char *arge[])
{
    int i;

    printf("Affichage `environ`\n");
    i = 0;
    while (environ[i] != NULL)
    {
        printf("\tLigne %d : %s \n", i, environ[i]);
        i++;
    }

    printf("Affichage `arge`\n");
    i = 0;
    while (arge[i] != NULL)
    {
        printf("\tLigne %d : %s \n", i, arge[i]);
        i++;
    }

    return EXIT_SUCCESS;
}