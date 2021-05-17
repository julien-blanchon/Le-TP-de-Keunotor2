#include  <stdio.h> /* printf  */
#include  <unistd.h> /* fork */
#include  <stdlib.h> /*  EXIT_SUCCESS  */
#include <sys/wait.h> 
#include <sys/types.h>
#include <string.h>   
#include <fcntl.h>    /* opérations sur les fichiers */


int  main () {
    int retour;
    retour = open("/Users/julienblanchon/Desktop/1SN_LangageC_C1.html", O_RDONLY);
    printf("%d \n",retour);
    return  EXIT_SUCCESS;
}
