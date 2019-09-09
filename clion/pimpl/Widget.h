//
// Created by Zhiyuan Yin on 8/31/19.
//

#ifndef PIMPL_WIDGET_H
#define PIMPL_WIDGET_H


#include <memory>

class Widget {
private:
    struct Impl;
    std::shared_ptr<Impl> pimpl;
public:
    Widget();
    // ~Widget();

    //Widget(Widget&& rhs);
};


#endif //PIMPL_WIDGET_H
