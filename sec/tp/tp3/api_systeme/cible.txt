/* Perso 1.3 Lecture et  ́ecriture dans les fichiers*/
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

#define BUFSIZE 5


int main(int argc, char const *argv[])
{
    if (argc!=3)
    {
        printf("./1.3_open source.txt cible.txt");
        return EXIT_FAILURE;
    }

    const char *fichier1 = argv[1];
    int open_ret1;
    open_ret1 = open(fichier1, O_RDONLY);

    const char *fichier2 = argv[2];
    int open_ret2;
    open_ret2 = open(fichier2, O_WRONLY | O_CREAT | O_TRUNC, 0600);
    
    if (open_ret1 < 0)
    { /* failure */
        printf("Failure open 1 : errno = %d", errno);
        return EXIT_FAILURE;
    }
    if (open_ret2 < 0)
    { /* failure */
        printf("Failure open 2 : errno = %d", errno);
        return EXIT_FAILURE;
    }

    char buffer[BUFSIZE];
    bzero(buffer, sizeof(buffer));
    int read_ret;
    int write_ret;

    do
    {
        read_ret = read(open_ret1, buffer, BUFSIZE);
        if (read_ret < 0)
        { /* failure */
            printf("Failure read: errno = %d", errno);
            return EXIT_FAILURE;
        }

        write_ret = write(open_ret2, buffer, read_ret);
        if (write_ret < 0)
        { /* failure */
            printf("Failure write: errno = %d", errno);
            return EXIT_FAILURE;
        }

        bzero(buffer, sizeof(buffer));
    } while (read_ret > 0);

    int close_ret1;
    close_ret1 = close(open_ret1);
    if (close_ret1 < 0)
    { /* failure */
        printf("Failure close 1 : errno = %d", errno);
        return EXIT_FAILURE;
    }

    int close_ret2;
    close_ret2 = close(open_ret2);
    if (close_ret2 < 0)
    { /* failure */
        printf("Failure close 2 : errno = %d", errno);
        return EXIT_FAILURE;
    }

        return EXIT_SUCCESS;
}