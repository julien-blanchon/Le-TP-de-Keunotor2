#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h> /* wait */

int main(int argc, char *argv[]){
    if (argc == 2) {
        char* nom_fichier = argv[1];
        int codeTerm;
        pid_t pidFils, idFils;
        pidFils = fork();
        if (pidFils == -1){         /* erreur */
            printf("Erreur fork\n");
            exit(1);
        } else if (pidFils == 0){   /* fils */
            printf("Processus fils\n");
            execl("/bin/ls", "ls", "-l", nom_fichier, NULL);
            printf("fin du fils\n"); // Ne s'afficheras pas sauf si erreur
            exit(EXIT_FAILURE); // Ne s'afficheras pas sauf si erreur
        }
        else{                       /* père */
            printf("Processus pere\n");
            idFils = wait(&codeTerm);
            switch (codeTerm){
            case 256:
                printf("Échec !\n");
                break;
            case -1:
                printf("Échec !\n");
                break;
            case 0:
                printf("Success !\n");
                break;
            default:
                printf("Wtf !\n\tflag = %d\n", codeTerm);
                break;
            }
            printf("fin du pere\n");
            exit(EXIT_SUCCESS);
        }
    } else {
        printf("Trop d'argument !\n");
    }
    
    
    
    return EXIT_SUCCESS; /* -> exit(EXIT_SUCCESS); pour le père */
}