//
//  minishell.c
//  minishell
//
//  Created by Julien Blanchon on 12/04/2021.
//
// Pour les tubes: http://www.lifl.fr/~marquet/ens/sem/tubes/tubes002.html#:~:text=2%20Communication%20inter%2Dprocessus%20par%20tube&text=Les%20deux%20processus%20p%C3%A8re%20et,en%20%C3%A9criture%20sur%20le%20tube.&text=Le%20processus%20fils%20ferme%20son,%C3%AAtre%20lues%20par%20le%20fils.

#include "readcmd.h" /* readcmd */

#include <stdio.h>
#include <unistd.h> /* write */
#include <stdlib.h>
#include <string.h>
#include <sys/types.h> /* pid_t */
#include <sys/wait.h>  /* wait */

int main(int argc, const char *argv[])
{
    /* variable compteur */
    int i = 0; /* compteur i*/
    //int j = 0; /* compteur j*/
    //int k = 0; /* compteur k*/

    /* variable miniminishell */
    int codeSortie = 0; /* code sortie
                         *  0   -> SUCCES
                         *  1   -> Fin
                         *  10  -> Sortie Signal
                         */
    struct cmdline cmd; /* struct .err .in .out .backgrounded .seq */

    /* variable coordination pere/fils */
    int codeTerm;
    pid_t pidFils, idFils;

    while (codeSortie == 0)
    { /* boucle minishell */
        pidFils = fork();

        if (pidFils == -1)
        { /* fork erreur */
            write(STDERR_FILENO, "\nERREUR : fork()\n", 16);
            exit(EXIT_FAILURE);
        }

        if (pidFils == 0)
        { /* fork fils */
            write(STDOUT_FILENO, "minishell$ ", 11);
            cmd = *readcmd();

            if (cmd.err != NULL)
            { /* erreur readcmd()*/
                write(STDERR_FILENO, "\nECHEC : readcmd()\n-->", 50);
                write(STDERR_FILENO, cmd.err, 50);
                exit(EXIT_FAILURE);
            }
            if (cmd.seq[0][0] == "cd")
            {
                int info = chdir(cmd.seq[0][1]);
                if (info == -1)
                {
                    write(STDERR_FILENO, "\nECHEC : chdir()\n", 50);
                }
                
            }
            else if (cmd.seq[0][0] == "exit")
            {
                exit(EXIT_FAILURE);
            }
            else
            {
                /* Execution de la première commande */
                execvp(cmd.seq[0][0], cmd.seq[0]);
                { /* Erreur de execvp */
                    write(STDERR_FILENO, "\nECHEC : commande inconnus [1]\n", 50);
                    exit(EXIT_SUCCESS);
                }
            }
            
        }
        else
        { /* fork père */
            /* attente de terminaison de la commande chez le fils */
            idFils = wait(&codeTerm);

            /* traitement du resultat */
            if (idFils == -1)
            { /* echec wait */
                write(STDERR_FILENO, "ECHEC : wait()\n", 15);
                //exit(EXIT_FAILURE);
            }

            if (WIFEXITED(codeTerm))
            { /* exit(...) */
                int exit_status = WEXITSTATUS(codeTerm);

                if (exit_status == 0)
                { /* exit(EXIT_SUCCESS) */
                    continue;
                }
                else
                { /* exit(EXIT_FAILURE) */
                    codeSortie = 1;
                    continue;
                }
            }
            else if (WIFSIGNALED(codeTerm))
            { /* signal(...) */
                int sig_status = WTERMSIG(codeTerm);
                
                if (sig_status == SIGQUIT)
                { /* signal(SIGQUIT) */
                    //printf("ECHEC : signal SIGQUIT\n");
                    //codeSortie = 3;
                    codeSortie = 10;
                }
                else if (sig_status == SIGKILL)
                { /* signal(SIGKILL) */
                    //printf("ECHEC : signal SIGKILL\n");
                    //codeSortie = 4;
                    codeSortie = 10;
                }
                else
                { /* signal(***) */
                    //printf("ECHEC : signal %d\n", sig_status);
                    //codeSortie = 5;
                    codeSortie = 10;
                }
            }
        }
    }
}
