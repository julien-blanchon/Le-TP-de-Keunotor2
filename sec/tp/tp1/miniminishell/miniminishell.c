#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h> /* wait */

int main(int argc, char *argv[])
{
    /* variable coordination pere/fils */
    int codeTerm;
    pid_t pidFils, idFils;

    /* variable miniminishell */
    int codeSortie = 0; /* code sortie
                                -1  -> ECHEC : idFils
                                0   -> SUCCES : Command valide
                                1   -> ECHEC : scanf
                                2   -> ECHEC : commande invalide
                                3   -> ECHEC : signal SIGQUIT
                                4   -> ECHEC : signal SIGKILL
                                5   -> ECHEC : signal inconnus
                                */

    /* variable commande miniminishell */
    char buf[30] = "";      /* La commande saisie au clavier (30 char max)*/
    int ret;                /* valeur de retour de scanf */
    char *arg;              /* argument */
    char *arg_array[30];    /* array cmd+arguments (30 string max)*/
    int i = 0;              /* compteur i*/
    //int j = 0;              /* compteur j*/
    //int k = 0;              /* compteur k*/
    while (codeSortie == 0)
    {
        pidFils = fork();

        if (pidFils == -1)
        {
            printf("Erreur fork\n");
            exit(1);
        }

        if (pidFils == 0)
        { /* fils */
            /* construction de arg_array */
            printf(">>> ");
            ret = scanf("%100[^\n]s\n", &buf);
            if (ret != 1)
            {
                printf("ECHEC : scanf\n");
                codeSortie = 1;
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
            {
                printf("ECHEC : commande invalide [1]\n");
                codeSortie = 2;
                exit(EXIT_FAILURE);
            }
        }
        else
        { /* père */
            /* attente de terminaison de la commande chez le fils */
            idFils = wait(&codeTerm);

            /* traitement du resultat */
            if (idFils == -1)
            {
                printf("ECHEC : idFils\n"); // Ne s'afficheras pas sauf si erreur
                codeSortie = -1;
                exit(EXIT_FAILURE);
            }

            if (WIFEXITED(codeTerm))
            { //exit(EXIT_*)
                int exit_status = WEXITSTATUS(codeTerm);
                if (exit_status == 0)
                { //exit(EXIT_SUCCESS)
                    //printf("SUCCES : Command valide\n");
                    //codeSortie = 0;
                }
                else
                { //exit(EXIT_FAILURE)
                    // printf("ECHEC : scanf OU Command invalide [%d]\n", exit_status);
                    //codeSortie = 1; //ou codeSortie = 2
                    /* Nothings */
                }
            }
            else if (WIFSIGNALED(codeTerm))
            { //signal
                int sig_status = WTERMSIG(codeTerm);
                if (sig_status == SIGQUIT)
                {
                    printf("ECHEC : signal SIGQUIT\n");
                    codeSortie = 3;
                }
                else if (sig_status == SIGKILL)
                {
                    printf("ECHEC : signal SIGKILL\n");
                    codeSortie = 4;
                }
                else
                {
                    printf("ECHEC : signal %d\n", sig_status);
                    codeSortie = 5;
                }
            }
        }
    }
    printf("Salut");
    return EXIT_SUCCESS; /* -> exit(EXIT_SUCCESS); pour le père */
}
