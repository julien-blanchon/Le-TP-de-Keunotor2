#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h> /* wait */

int main(int argc, char *argv[]){
    if (argc == 2) {
        char* nom_fichier = argv[1];
        int flag = execl("/bin/ls", "ls", "-l", nom_fichier, NULL);
        switch (flag){
        case -1:
            printf("Échec !\n");
            break;
        case 0:
            printf("Success !\n");
            break;
        default:
            printf("Wtf !\n\tflag = %d\n");
            break;
        }
    } else {
        printf("Trop d'argument !\n");
    }
    
    
    
    return EXIT_SUCCESS; /* -> exit(EXIT_SUCCESS); pour le père */
}