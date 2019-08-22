#include <iostream>
#include <atomic>
#include <thread>

class Mutex {
private:
    std::atomic_bool locked;

public:
    Mutex() : locked(false) {}

    void lock() {
        bool expected = false;
        while (!locked.compare_exchange_strong(expected,
                                               true,
                                               std::memory_order_acq_rel)) {
            expected = false;
        }

    }

    void unlock() {
        locked.store(false, std::memory_order_release);
    }

};

int main() {
    Mutex m;
    int val = 0;
    std::thread thread1([&]() {
        m.lock();
        std::this_thread::sleep_for(std::chrono::seconds(1));
        std::cout << "thread1" << std::endl;
        m.unlock();
    });

    std::thread thread2([&]() {
        m.lock();
        //std::this_thread::sleep_for(std::chrono::seconds(60));
        std::cout << "thread2" << std::endl;
        m.unlock();
    });


//  thread2.detach();
//  thread1.detach();

    thread1.join();
    thread2.join();

    return 0;
}
