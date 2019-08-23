#include <iostream>
#include <vector>
#include "template.h"
#include "PrettyPrinter.h"


int main() {
    std::cout << "Hello, World!" << std::endl;
    float arr[] = {1.0 ,2.1,3};
    std::cout << ArraySum(arr) << std::endl;
    // std::cout << compare(1, 2) << std::endl;

    const char *s1 = "B";
    const char *s2 = "A";
    //std::cout << compare(s1, s2) << std::endl;
    // Print(1,"a", 2);

    Vec2<int> vint = {{1, 2, 3}, {4,5,6}};
    PrettyPrinter<Vec2<int>> pp(&vint);
    pp.Print();
    return 0;
}