#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h> /* wait */

int main(int argc, char *argv[])
{
    /* variable coordination pere/fils */
    pid_t pidFils, idFils;
    int codeTerm;
    int codeSortie = 0; /* code sortie
                                -99 -> KO : ???             

                                -13 -> KO : Signal inconnus     ERREUR
                                -12 -> KO : Signal SIGKILL      ERREUR
                                -11 -> KO : Signal SIGQUIT      ERREUR

                                -5  -> KO : CTRL+D              ø           

                                -2  -> KO : EOF                 ERREUR      exit
                                -1  -> KO : Scanf               ERREUR      exit

                                0   -> OK : Command valide      SUCCES      exit

                                1   -> OK : Commande invalide   ECHEC       exit
                                */

    /* variable commande miniminishell */
    char *tampon_ligne;
    char buf[30] = "";      /* La commande saisie au clavier (30 char max)*/
    char *ret;              /* valeur de retour de fgets */
    char *arg;              /* argument */
    char *arg_array[30];    /* array cmd+arguments (30 string max)*/
    int i = 0;              /* compteur i*/
    //int j = 0;            /* compteur j*/
    //int k = 0;            /* compteur k*/
    while (codeSortie >= 0)
    {
        pidFils = fork();

        if (pidFils == -1)
        {
            printf("Erreur fork\n");
            exit(EXIT_FAILURE);
        }

        if (pidFils == 0)
        { /* fils */
            /* construction de arg_array */
            //printf(">>> ")
            setvbuf(stdin, tampon_ligne, _IOLBF, 1000);
            setlinebuf(stdin);
            fputs(">>> ", stdout);
            ret = fgets(buf, 30, stdin);
            if (ret == NULL)
            {
                exit(-2);
            }
            size_t len = strlen(buf);
            if (len >= 2 && buf[len-1] == '\n')
            {
                buf[len-1] = '\0';
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
                printf("miniminishell.c: commande invalide `%s` [1]\n", buf);
                exit(1);
            }
        }
        else
        { /* père */
            /* attente de terminaison de la commande chez le fils */
            idFils = wait(&codeTerm);

            /* traitement du resultat */
            if (idFils == -1)
            {
                printf("ERREUR : idFils\n"); // Ne s'afficheras pas sauf si erreur
                exit(EXIT_FAILURE);
            }

            if (WIFEXITED(codeTerm))
            { //exit()
                int exit_status = WEXITSTATUS(codeTerm);
                switch (exit_status)
                {
                case -2:
                    codeSortie = -2;
                    printf("ERREUR :EOF [%d]\n", codeSortie);
                    break;
                case -1:
                    codeSortie = -1;
                    printf("ERREUR :Scanf [%d]\n", codeSortie);
                    break;
                case 0:
                    codeSortie = 0;
                    printf("SUCCES : Command valide [%d]\n", codeSortie);
                    break;
                case 1:
                    codeSortie = 1;
                    printf("ECHEC : Command invalide [%d]\n", codeSortie);
                    break;
                case 254:
                    codeSortie = -5;
                    printf("CTRL+D : Fin [%d]\n", codeSortie);
                    break;
                default:
                    codeSortie = -99;
                    printf("?? : INCONNUS ?? [%d]\n", exit_status);
                    break;
                }
            }
            else if (WIFSIGNALED(codeTerm))
            { //signal()
                int sig_status = WTERMSIG(codeTerm);
                if (sig_status == SIGQUIT)
                {
                    codeSortie = -11;
                    printf("ECHEC : signal SIGQUIT(%d) [%d]\n", sig_status, codeSortie);
                }
                else if (sig_status == SIGKILL)
                {
                    codeSortie = -12;
                    printf("ECHEC : signal SIGKILL(%d) [%d]\n", sig_status, codeSortie);
                }
                else
                {
                    if (sig_status != SIGTRAP)
                    { // pour le debugger !
                        codeSortie = -13;
                        printf("ECHEC : signal (%d) [%d]\n", sig_status, codeSortie);
                    }
                }
            }
            else
            {
                /* code */
            }
            
        }
    }
    printf("\nSalut\n");
    return EXIT_SUCCESS; /* -> exit(EXIT_SUCCESS); pour le père */
}
