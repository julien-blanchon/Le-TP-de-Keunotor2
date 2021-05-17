/*
 * Copyright (C) 2020, Julien BLANCHON
 */

/*
 * Minishell
 */

#include "readcmd.h"    /* readcmd */
#include <stdio.h>
#include <unistd.h>     /* write */
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>  /* pid_t */
#include <sys/wait.h>   /* wait */
#include <errno.h>
/* errno: https://www.gnu.org/software/libc/manual/html_node/Error-Codes.html */
/* fprintf plutôt que perror pour ne pas avoir les errno */

#define    KO    1
#define    OK    0

int minishell_exec(struct cmdline cmd);
int minishell_extern(char **args, const char *backgrounded);
int minishell_intern_cd(char **args);

int main() { /* Fonction principale */
    struct cmdline cmd; /* struct .err .in .out .backgrounded .seq */
    int codeSortie = 0; /* codeSortie
                         *  OK   -> continue
                         *  KO   -> quit
                         */
    while (codeSortie == 0)
    { /* boucle minishell */
        fprintf(stdout, "minishell$ ");      // Prompt Display
        cmd = *readcmd();           // Lecture commande
        codeSortie = minishell_exec(cmd);// Execution commande
    }
    return EXIT_SUCCESS;
}

int minishell_exec(struct cmdline cmd) {
    if (cmd.err != NULL)
    { /* Cas erreur readcmd ! KO */
        fprintf(stdout, "Erreur readcmd !\n");
        return OK;
    } else if (*cmd.seq == NULL)
    { /* Cas ligne vide ! OK */
        fprintf(stdout, "Ligne vide !\n");
        return OK;
    } else
    { /* Cas commande conforme ! OK */
        int codeSortie;
        char **args = cmd.seq[0];
        char *bin = args[0];
        char *backgrounded = cmd.backgrounded;
        if (strcmp(bin, "cd") == 0)
        { /* Commande interne  : cd ! OK */
            minishell_intern_cd(args);
            return OK;
        } else if (strcmp(bin, "exit") == 0)
        { /* Commande interne  : exit ! KO */
            return KO;
        } else
        { /* Commande externe  : bin ! OK */
            codeSortie = minishell_extern(args, backgrounded);
            return codeSortie;
        }
    }
}

int minishell_extern(char **args, const char *backgrounded) { /* Commande externe */
    /* Exécution de la première commande */
    pid_t pidFils = fork();
    if (pidFils == -1)
    { /* fork erreur ! OK */
        fprintf(stdout, "Erreur fork fils !\n");
        return OK;
    } else if (pidFils == 0)
    { /* proc fils */
        execvp(args[0], args);
        /* Erreur de execvp fils OK */
        exit(127); /* commande introuvable */
    } else
    { /* proc père */
        if (backgrounded == NULL)
        { /* commande directe */
            /* attente de terminaison de la commande chez le fils */
            int codeTerm;
            pid_t idFils = wait(&codeTerm);
            if (idFils == -1)
            { /* échec wait ! OK */
                fprintf(stdout, "Erreur wait !\n");
                return OK;
            } else if (WIFEXITED(codeTerm))
            { /* exit(...) */
                int exit_status = WEXITSTATUS(codeTerm); /* exit_status == ? */
                switch (exit_status)
                {/*https://tldp.org/LDP/abs/html/exitcodes.html*/
                    case 0: /* commande est exécutée avec succès: ls -l */
                        return OK;
                    case 1:
                    case 2: /* commande renvoie un échec: ls -jdks */
                        fprintf(stdout, "%s: échec !\n", args[0]);
                        return OK;
                    case 126: /* commande non exécutable ou pb de permission */
                        fprintf(stdout, "%s: non exécutable !\n", args[0]);
                        return OK;
                    case 127: /* commande introuvable */
                        fprintf(stdout, "%s: commande introuvable !\n", args[0]);
                        return OK;
                    default:
                        fprintf(stdout, "%s: exit %d !\n", args[0], exit_status);
                        return OK;
                }
            } else if (WIFSIGNALED(codeTerm))
            { /* signal(...) */
                int sig_status = WTERMSIG(codeTerm);
                if (sig_status == SIGQUIT)
                { /* signal(SIGQUIT) */
                    fprintf(stdout, "signal SIGQUIT !\n");
                    return KO;
                } else if (sig_status == SIGKILL)
                { /* signal(SIGKILL) */
                    fprintf(stdout, "signal SIGKILL !\n");
                    return KO;
                } else
                { /* signal(***) */
                    fprintf(stdout, "signal %d !\n", sig_status);
                    return KO;
                }
            }
        } else
        { /* commande en tâche de fond */
            return OK;
        }
    }
    return OK;
}

int minishell_intern_cd(char **args) {
    if (args[1] != NULL && args[2] != NULL)
    { /* nbr argument invalide KO */
        fprintf(stdout, "cd: trop d'arguments !\n");
        return OK;
    } else
    { /* nbr argument valide */
        char *path = ((args[1] == NULL) ? (getenv("HOME")): (args[1]));
        int info = chdir(path);
        if (info == -1)
        { /* erreur chdir KO */
            switch (errno)
            {
                case EACCES: /* erreur accès ! OK */
                    fprintf(stdout, "cd: '%s' problème d'accès !\n", path);
                    return OK;
                case EIO: /* erreur E/S ! OK */
                    fprintf(stdout, "cd: '%s' erreur E/S !\n", path);
                    return OK;
                case ELOOP: /* erreur référence circulaire ! OK */
                    fprintf(stdout, "cd: '%s' référence circulaire !\n", path);
                    return OK;
                case ENAMETOOLONG: /* erreur nom trop long ! OK */
                    fprintf(stdout, "cd: '%s' chemin trop long !\n", path);
                    return OK;
                case ENOENT: /* erreur pas assez de mémoire ! OK */
                    fprintf(stdout, "cd: '%s' pas assez de mémoire !\n", path);
                    return OK;
                case ENOMEM: /* erreur chemin introuvable ! OK */
                    fprintf(stdout, "cd: '%s' n'existe pas !\n", path);
                    return OK;
                case ENOTDIR: /* erreur répertoire ! OK */
                    fprintf(stdout, "cd: '%s' n'est pas un répertoire !\n", path);
                    return OK;
                default: /* erreur inconnus ! OK */
                    fprintf(stdout, "cd: '%s' problème inconnus !\n", path);
                    return OK;
            }
        }
        /* OK */
        return OK;
    }
}

int minishell_intern_jobs()
{

}