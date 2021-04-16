/* Perso 1.2 Ouverture de fichier*/
/* Utilisez open pour ouvrir en lecture le fichier dont le nom est pass ́e en */
/* premier argument du programme (le fichier que l’on va copier). Traitez les cas */
/* d’erreurs (fichier inexistant, pas les bons droits d’acc`es, etc). La fonction */
/* perror peut g ́en ́erer automatiquement des messages d’erreur. Affichez le num ́ero */
/* du descripteur lorsque l’ouverture r ́eussit. */

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
        open_ret = open(fichier, O_RDONLY);

        if (open_ret < 0)
        {   /* failure */
            printf("Failure open: errno = %d", errno);
            return EXIT_FAILURE;
        }

        char buffer[8];
        bzero(buffer, sizeof(buffer));
        int read_ret;

        do
        {
            read_ret = read(open_ret, buffer, 4);
            if (read_ret < 0)
            { /* failure */
                printf("Failure read: errno = %d", errno);
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