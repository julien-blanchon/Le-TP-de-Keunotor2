# Indiquer quel compilateur est à utiliser
CC = gcc
	
# Spécifier les options du compilateur
CFLAGS = -Wall -Wextra
EXEC = superminishell

all: $(EXEC)

superminishell: superminishell.c readcmd.o 
	$(CC) $(CFLAGS) $^ -o $@

readcmd: readcmd.c readcmd.h
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f *.o core

mrproper: clean
	rm -f $(EXEC)