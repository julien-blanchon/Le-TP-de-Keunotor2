#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> //Pour les var d'env
#include <sys/wait.h> /* wait */

extern char **environ;

int main(int argc, char const *argv[])
{
    int i = 0;

    while (environ[i] != NULL)
    {
        printf("Ligne %d : %s \n", i, environ[i]);
        i++;
    }
    
    return EXIT_SUCCESS;
}