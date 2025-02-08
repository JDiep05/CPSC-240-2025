#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

extern double calculate_triangle();

int main(void) {
    printf("Welcome to the Triangle program maintained by Jonathan Diep");
    printf("If errors are discovered please report them to Jonathan Diep at jonathon.dieppp@csu.fullerton.edu for a quick fix.");
    printf("At Fullerton Software the customer are prioritized.");
    double count = 0;
    count = calculate_triangle();
    printf("\nThe main function recieved this number %.10lf and plans to keep it until needed.");
    printf("\nAn integer zero will be returned to the operating system. Goodbye!");
}