#include <iostream>
#include <memory>

struct Foo {
  Foo() { std::cout << "Foo::Foo" << std::endl; }
  ~Foo() { std::cout << "Foo::~Foo" << std::endl; }
  void foo() { std::cout << "Foo::foo" << std::endl; }
};

int main() {
    std::cout << "Hello, World!" << std::endl;
    std::unique_ptr<Foo> p1 = std::make_unique<Foo>();

    if (p1) p1->foo();

    {
        std::unique_ptr<Foo> p2(std::move(p1));
        if (p2) p2->foo();
        auto p3 = std::move(p2);
        p1 = std::move(p3);
    }

    if (p1) std::cout << "p1 has value!" << std::endl;

    return 0;
}