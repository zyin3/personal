#include <iostream>
#include <string>
#include <vector>
#include <folly/futures/Future.h>

#include <folly/executors/ThreadedExecutor.h>
#include <folly/Conv.h>
using namespace folly;

void f(std::string &s)
{
    std::cout << s << std::endl;
}

std::string g()
{
    return "foo";
}
void foo(int x)
{
    // do something with x
    std::cout << "foo(" << x << ")" << std::endl;
}

int main(int argc, char **argv)
{
    // std::vector<std::string> vec {"a"};

    // for (const auto& s : vec) {
    //     std::cout << s << std::endl;
    // }
    // std::cout << "hello world" << std::endl;

    // ...
    folly::ThreadedExecutor executor;
    std::cout << "making Promise" << std::endl;
    Promise<int> p;
    Future<int> f = p.getSemiFuture().via(&executor);
    auto f2 = std::move(f).thenValue(foo);
    std::cout << "Future chain made" << std::endl;
    fbstring str;
    toAppend(1.1, "foo", &str);

    std::cout << str << std::endl;


    auto int_str = to<std::string>(100);
    std::cout << int_str << std::endl;

    tryTo<int>(int_str).then([](int i){std::cout << -i << std::endl;});
}