// *******************************************************************************************************************************
//  Program name: "Arrays of Floating Point Numbers". This program takes user input's of floating point number and place them into an array.
//  Copyright (C) 2025  Jonthan Diep                                                                                             *
//                                                                                                                               *
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License    *
//  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.        *
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty  *
//  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.                *
//  You should have received a copy of the GNU General Public License along with this program.  If not, see                      *
//  <https://www.gnu.org/licenses/>.                                                                                             *
// *******************************************************************************************************************************



//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
// Author: Jonathan Diep
// Author email: jonathon.dieppp@csu.fullerton.edu
// CWID: 884973462
// Class: 240-03 Section 03
// Program name: Arrays of Floating Point Numbers
// Programming languages: Two module in C, Six in X86, and One in bash.
// Date program began: 2024-Feb-22
// Date of last update: 2024-Feb-22
// Files in this program: driver.c, manager.asm, input_array.asm, output_array.asm, sum_reciprocals.asm, r.sh
// Testing: Alpha testing completed.  All functions are correct.
// Status: Ready for release to the customers

// Purpose of this program:
//  This program takes user input's of non-zero floating point number and place them into an array.
//  The program will calculate the sum of reciprocal and the harmonic mean of the array.
//
// This file:
//  File name: driver.c
//  Language: C language
//  Max page width: 124 columns
//  Compile: gcc -c -m64 -Wall -no-pie -o driver.o driver.c -std=c2x
//  Link: gcc -m64 -no-pie -o driver.out driver.o manager.o input_array.o output_array.o sum_reciprocals.o
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


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