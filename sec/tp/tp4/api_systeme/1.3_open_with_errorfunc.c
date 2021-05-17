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
#include <errno.h>    /* errno pour savoir si le fichier est bien open... */
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */

#define BUFSIZE 5


void error_detect(int ret, char *string)
{
    if (ret < 0)
    { /* failure */
        printf("Failure %s: errno = %d", string, errno);
        perror("Failure!");
        exit(EXIT_FAILURE);
    }
}


int main(int argc, char const *argv[])
{
    if (argc!=3)
    {
        printf("./1.3_open source.txt cible.txt");
        return EXIT_FAILURE;
    }
    errno = 0; /* on initialise errno (var globale) */
    
    const char *fichier1 = argv[1];
    int open_ret1;
    open_ret1 = open(fichier1, O_RDONLY);
    error_detect(open_ret1, "open1");

    const char *fichier2 = argv[2];
    int open_ret2;
    open_ret2 = open(fichier2, O_WRONLY | O_CREAT | O_TRUNC, 0600);
    error_detect(open_ret2, "open2");

    char buffer[BUFSIZE];
    bzero(buffer, sizeof(buffer));
    int read_ret;
    int write_ret;

    do
    {
        read_ret = read(open_ret1, buffer, BUFSIZE);
        error_detect(read_ret, "read1");

        write_ret = write(open_ret2, buffer, read_ret);
        error_detect(write_ret, "write1");

        bzero(buffer, sizeof(buffer));
    } while (read_ret > 0);

    int close_ret1;
    close_ret1 = close(open_ret1);
    error_detect(close_ret1, "close1");

    int close_ret2;
    close_ret2 = close(open_ret2);
    error_detect(close_ret2, "close2");

    return EXIT_SUCCESS;
}