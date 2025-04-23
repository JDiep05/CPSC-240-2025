//Name: Jonathan Diep
//Cwid: 884973462
//Email: jonathon.dieppp@csu.fullerton.edu
//Date: Apr 23 2025
//Program: Final program.

#include <iostream>
extern "C" long manager();

int main() {
    std::cout << "\nWelcome to getqwords test program developed by Jonathan Diep \n";
    long result = manager();
    std::cout << "\nThe driver received " << result << std::endl;
    std::cout << "\nA zero will be sent to the OS. Bye.\n";
    return 0;
}