//
// Created by Zhiyuan Yin on 8/31/19.
//

#include <string>
#include <vector>
#include "Widget.h"

struct Widget::Impl {
    std::string name;
    std::vector<int> size;
};

//Widget::~Widget() = default;

Widget::Widget() : pimpl(std::make_unique<Impl>()) {}

//Widget::Widget(Widget &&rhs) = default;