#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h> /* wait */

int main(int argc, char const *argv[])
{
    while (1)
    {
        char buf[30]; /* contient la commande saisie au clavier */
        int ret;      /* valeur de retour de scanf */
        pid_t pidFils, idFils;
        int codeTerm;
        pidFils = fork();
        if (pidFils == -1)
        { 
            /* erreur */
            printf("ECHEC FORK\n");
            exit(EXIT_FAILURE);
        } else if (pidFils == 0)
        {
            /* fils */
            char *token = strtok(buf, " ");
            char* cmd = token;
            printf("%s", cmd);
            token = strtok(NULL, " ");
            char *cmd_arg[50];
            int i = 0;
            while (token != NULL)
            {
                cmd_arg[i++] = token;
                token = strtok(NULL, " ");
            }
            printf("%s", cmd);
            execvp(cmd, cmd_arg);
            printf("ECHEC\n");       // Ne s'afficheras pas sauf si erreur
            exit(EXIT_FAILURE);
        } else
        {
            /* pere */
            printf(">>> ");
            ret = scanf("%s ", buf); /* lit et range dans buf la chaine entr ´e e au clavier */
            idFils = wait(&codeTerm);
            printf("%s", buf);
            switch (codeTerm)
            {
            case 256:
                exit(EXIT_FAILURE);
                break;
            case -1:
                exit(EXIT_FAILURE);
                break;
            case 0:
                printf("SUCCES\n");
                break;
            default:
                printf("Wtf !\n\tflag = %d\n", codeTerm);
                exit(EXIT_FAILURE);
                break;
            }
        }
        
        
    }
    printf("Salut");
    return 0;
}
