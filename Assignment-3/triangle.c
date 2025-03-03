#include <stdio.h>
#include <stdlib.h>

extern double manager();

int main(void) {
    char name[50];

    printf("\nWelcome to Huron's Triangles. We take care of all your triangle needs.\n");
    printf("\nPlease enter your name: ");
    fgets(name, sizeof(name), stdin);
    double count = 0;
    count = manager();

    printf("\nThe main function has recieved this number %.4lf, and will keep it for a while.\n", count);
    printf("\nThank you %s. Your patronage is appreciated.\n", name);
    printf("\nA zero will now be return to the operating system\n");

}