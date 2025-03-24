#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* executive();

int main(void) {
    printf("Welcome to Random Products, LLC.\n");
    printf("This software is maintained by Jonathan Diep\n");
    char* user = executive();
    printf("Oh, %s. We hope you enjoyed your arrays. Do come again.\n");
    printf("A zero will be returned to the operating system.\n");
}