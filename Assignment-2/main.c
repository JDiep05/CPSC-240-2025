#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern double manager();

int main(void) {
    printf("\nWelcome to Arrays of floating point numbers.\n");
    printf("Bought to you by Jonathan Diep\n\n");

    double output = manager();

    printf("Main recieved %.10lf, and will keep it for future use.\n", output);
    printf("Main will return 0 to the operating system. Bye.\n");
}