//
// Created by Zhiyuan Yin on 2019-08-22.
//

#ifndef TEMPLATE_TEMPLATE_H
#define TEMPLATE_TEMPLATE_H
template<typename T>
T Add(T x, T y) {
    return x + y;
}

template<typename T>
bool compare(T x, T y) {
    return x > y;
}

template<>
bool compare(const char* x, const char* y) {
    return strcmp(x, y) > 0;
}

template<typename T>
T ArraySum(T* parr, int size) {
    T sum = 0;
    for (int i = 0; i < size; i++) {
        sum += *(parr + i);
    }
    return sum;
}

template<typename T, int size>
T ArraySum(T (&parr)[size]) {
    T sum = 0;
    for (int i = 0; i < size; i++) {
        sum += *(parr + i);
    }
    return sum;
}

void Print() {
}

template<typename T, typename... Params>
void Print(T a, Params... args) {
    std::cout << sizeof...(Params) << std::endl;
    Print(args...);
}
#endif //TEMPLATE_TEMPLATE_H
