//*******************************************************************************************************************************
// Program name: "Non-deterministic Random Numbers". This program prompts the user for the number of values to generate, fills an array with random numbers, then normalizes and sorts the array.
// Copyright (C) 2025  Jonathan Diep
//
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
// of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program. If not, see
// <https://www.gnu.org/licenses/>.
//*******************************************************************************************************************************


//*******************************************************************************************************************************
// Author information
//   Author name : Jonathan Diep
//   Author email: jonathon.dieppp@csu.fullerton.edu
//   CWID : 884973462
//   Class: 240-03 Section 03
//
// Program Information
//   Program Name: Non-deterministic Random Numbers
//   Programming language: Two module in C, Five module in X86, and One module in bash.
//   Date program began: 2025-Mar-25
//   Date of last update: 2025-Mar-27
//   Files in this program: gcc -m64 -no-pie -o main.out main.o executive.o fill_random_array.o isnan.o normalize_array.o show_array.o sort.o
//   Testing: Alpha testing completed. All functions are correct.
//   Status: Ready for release to customers
//
// Purpose
//   This program prompts user for a value from 1-100 and generates random scientific decimal based on user input onto the array.
//   The program will normalize the values to be between 1.0 and 2.0.
//   The program will sort your array in numerical order.
//
// This file:
//   File name: sort.c
//   Language: C
//   Max page width: 124 columns
//   Compile (standard): gcc -c -m64 -Wall -no-pie -o sort.o sort.c -std=c2x
//   Compile (debug): gcc -m64 -no-pie -g -o sort.o -c sort.c
//   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//   Prototype of this function: extern void normalize_array(double* array, int size);
//
//
//
//*******************************************************************************************************************************



#include <stdio.h>

void sort(double* my_array, int array_size)
{
    double sorted;
    for (int x = 0; x < array_size; x++)
    {
        for (int y = 0; y < array_size - x - 1; y++)
        {
            if (my_array[y] > my_array[y + 1])
            {
                sorted = my_array[y];
                my_array[y] = my_array[y + 1];
                my_array[y + 1] = sorted;
            }
        }
    }
}