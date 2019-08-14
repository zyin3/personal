#include <iostream>
#include <type_traits>
#include <vector>
#include <algorithm>
#include <map>

void foo(char*);
void foo(int);

template<typename T, typename  U>
auto add(T t, U u) -> decltype(t+u) {
    return t + u;
}

template <typename Key, typename Value, typename F>
void update(std::map<Key, Value>& m, F foo) {
    // TODO:
    for (auto& [key, value] : m) value = foo(key);
}

template<typename... T>
auto avg(T ... t) {
    return ( t + ... ) / sizeof...(t);
}


int main() {
    std::map<std::string, long long int> m {
        {"a", 1},
        {"b", 2},
        {"c", 3}
    };
    update(m, [](std::string key) {
        return std::hash<std::string>{}(key);
    });
    for (auto&& [key, value] : m)
        std::cout << key << ":" << value << std::endl;


    std::cout << avg(1,2,3) << std::endl;
}

//int main() {
//    if (std::is_same<decltype(NULL), decltype(0)>::value)
//        std::cout << "NULL == 0" << std::endl;
//    if (std::is_same<decltype(NULL), decltype((void*) 0)>::value)
//        std::cout << "NULL == (void *)0" << std::endl;
//    if (std::is_same<decltype(NULL), std::nullptr_t>::value)
//        std::cout << "NULL == nullptr" << std::endl;
//
////    if (std::is_same<decltype(0), decltype(1)>::value) {
////      std::cout << "0 == 1.1" << std::endl;
////    }
////    std::cout << decltype(NULL) << std::endl;
//    foo(0);          // will call foo(int)
//    // foo(NULL);    // doen't compile
//    foo(nullptr);    // will call foo(char*)
//
//    std::vector<int> vec = {1, 2, 3, 4};
//
//    if (auto itr = std::find(vec.begin(), vec.end(), 4); itr != vec.end()) {
//        *itr = 5;
//    }
//
//    for (int& e : vec) {
//        std::cout << e << std::endl;
//    }
//
//    auto x = 1;
//    auto y = 1.0;
//
//    auto z = add(x, y);
//    if (std::is_same<int, decltype(z)>::value) {
//        std::cout << z << std::endl;
//    }
//
//    return 0;
//}

void foo(char*) {
    std::cout << "foo(char*) is called" << std::endl;
}
void foo(int i) {
    std::cout << "foo(int) is called" << std::endl;
}