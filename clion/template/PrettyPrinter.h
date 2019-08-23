//
// Created by Zhiyuan Yin on 8/22/19.
//

#ifndef TEMPLATE_PRETTYPRINTER_H
#define TEMPLATE_PRETTYPRINTER_H

#include <iostream>
#include <vector>

template <typename T>
using Vec2 = std::vector<std::vector<T>>;

template<typename T>
class PrettyPrinter {
    T* data_;
public:
    explicit PrettyPrinter(T* data) : data_(data) {}

    void Print() {
        std::cout << *data_ << std::endl;
    }
};

template<>
void PrettyPrinter<Vec2<int>>::Print() {
    for (auto& subvector : *data_) {
        std::cout << "{";
        for (auto& val : subvector) {
            std::cout << val << " ";
        }
        std::cout << "}" << std::endl;
    }
}
#endif //TEMPLATE_PRETTYPRINTER_H
