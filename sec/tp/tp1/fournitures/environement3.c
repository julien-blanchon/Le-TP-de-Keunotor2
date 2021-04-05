#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> //Pour les var d'env
#include <sys/wait.h> /* wait */
#include <string.h>

extern char **environ;

int main(int argc, char const *argv[], char *arge[])
{
    
    char* PATH = "PATH";
    char* path_var = getenv(PATH);
    if (argc == 2)
    {
        printf("PATH avant: %s\n", getenv(PATH));
        char* nouveau_path_var;
        nouveau_path_var = malloc(strlen(path_var) + 10000);
        strcat(nouveau_path_var, path_var);
        strcat(nouveau_path_var, ":");
        strcat(nouveau_path_var, argv[1]);
        int flagset = setenv(PATH, nouveau_path_var, 1);
        printf("PATH aprés %d: %s\n", flagset, getenv(PATH));
    }
    else
    {
        printf("Pb d'arguments !");
    }
    
    
    

    return EXIT_SUCCESS;
}