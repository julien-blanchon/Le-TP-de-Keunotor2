/* Perso 1.3 Ouverture de fichier*/
/* A la suite, ouvrez en  ́ecriture le fichier dont le nom est pass ́e en second argument du programme. 
L’ ́ecraser s’il existe, sinon le cr ́eer avec les droits de lecture et  ́ecriture pour l’utilisateur. 
Traitez les cas d’erreur. Affichez le num ́ero du descripteur lorsque l’ouverture r ́eussit. 
V ́erifiez qu’un nouveau fichier avec les bons droits (ls -l) est bien cr ́e ́e. 
V ́erifiez que le contenu d’un fichier qui existe d ́eja` est bien effac ́e. 
Prenez garde `a ne pas tester votre programme sur des fichiers utiles, 
leur contenu serait  ́ecras ́e.*/

#include <stdio.h>    /* entrées sorties */
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>    /* errno pour savoir si le fichier est bien open */
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */

int main(int argc, char const *argv[])
{
    if (argc!=2)
    {
        printf("Erreur trop d'argument !");
    }
    else
    {
        const char *fichier = argv[1];
        int open_ret;
        open_ret = open(fichier, O_WRONLY | O_CREAT | O_TRUNC, 0600);

        if (open_ret < 0)
        {   /* failure */
            printf("Failure open: errno = %d", errno);
            return EXIT_FAILURE;
        }

        printf("Le descripteur est : %d", open_ret);

        char buffer[8];
        bzero(buffer, sizeof(buffer));
        int read_ret;

        do
        {
            read_ret = read(open_ret, buffer, 4);
            if (read_ret < 0)
            { /* failure */
                printf("Failure read: errno = %d", errno); /*Pk errno = 9 Bad access file ??*/
                return EXIT_FAILURE;
            }
            printf("%s", buffer);
            bzero(buffer, sizeof(buffer));
        } while (read_ret > 0);

        int close_ret;
        close_ret = close(open_ret);
        if (close_ret < 0)
        { /* failure */
            printf("Failure close: errno = %d", errno);
            return EXIT_FAILURE;
        }
    }
    
    
    return EXIT_SUCCESS;
}