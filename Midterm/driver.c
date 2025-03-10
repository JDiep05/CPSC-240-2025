// Jonathan Diep
// CPSC 240-03
// March 10, 2025 
// jonathon.dieppp@csu.fullerton.edu

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern double manager();

int main (void) {
    printf("\nWelcome to Computations by Jonathan Diep.\n");

    double output = manager();

    printf("\nMain recieved %.5lf, and will keep it for future use.", output);
    printf("\nAn integer zero is sent to the OS, and execution terminates.\n");
}