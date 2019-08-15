#include <iostream>
#include <functional>
#include <bits/unique_ptr.h>

void lambda_expression_capture() {
    auto important = std::make_unique<int>(1);
    auto add = [&](int x, int y) {
        return x + y + *important;
    };
    std::cout << add(3,4) << std::endl;
}

int foo(int x, int y, int z) {
    return x + y + z;
}
void overloaded( const int &arg ) { std::cout << "by lvalue\n"; }
void overloaded( int && arg ) { std::cout << "by rvalue\n"; }

template< typename t >
/* "t &&" with "t" being template param is special, and  adjusts "t" to be
   (for example) "int &" or non-ref "int" so std::forward knows what to do. */
void forwarding( t && arg ) {
    std::cout << "via std::forward: ";
    overloaded( std::forward< t >( arg ) );
    std::cout << "via std::move: ";
    overloaded( std::move( arg ) ); // conceptually this would invalidate arg
    std::cout << "by simple passing: ";
    overloaded( arg );
}

int main() {
    lambda_expression_capture();
    auto bindFoo = std::bind(foo, std::placeholders::_1, 2, 3);
    std::cout << bindFoo(1) << std::endl;

    std::cout << "initial caller passes rvalue:\n";
    forwarding( 5 );
    std::cout << "initial caller passes lvalue:\n";
    int x = 5;
    forwarding( x );
    return 0;
}