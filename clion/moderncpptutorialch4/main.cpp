#include <iostream>
#include <string>
#include <unordered_map>

int main() {

    std::unordered_map<int, std::string> u = {
        {1, "foo"},
        {2, "bar"}
    };

    std::cout << u.size() << std::endl;
    for (auto&& p : u) {
        std::cout << p.first << ": " << p.second << std::endl;
    }
    return 0;
}