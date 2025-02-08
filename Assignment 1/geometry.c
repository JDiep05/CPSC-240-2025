// License will be included soon

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

extern double calculate_triangle();

int main(void) {
    printf("\nWelcome to the Triangle program maintained by Jonathan Diep.\n");
    printf("\nIf errors are discovered please report them to Jonathan Diep at jonathon.dieppp@csu.fullerton.edu for a quick fix.\n");
    printf("\nAt Fullerton Software the customer are prioritized.\n");
    double count = 0;
    count = calculate_triangle();
    printf("\nThe main function recieved this number %.9f and plans to keep it until needed.\n",count);
    printf("\nAn integer zero will be returned to the operating system. Goodbye!\n\n");
}