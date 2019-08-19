#include <iostream>
#include <thread>
#include <future>
#include <functional>
#include <queue>

class ThreadPool {
private:
    std::queue<std::function<int()>> items;
    std::mutex mutex;
    std::condition_variable cv;
    std::vector<std::thread> workers;
    bool stop;

public:
    ThreadPool(int num) : stop(false) {
        for (int i = 0; i < num; ++i) {
            this->workers.emplace_back([this]() {
                while (true) {
                    std::function<int()> task;
                    {
                        std::unique_lock<std::mutex> lock(this->mutex);
                        this->cv.wait(lock, [this]() { return this->stop || !this->items.empty(); });
                        if (this->stop && this->items.empty()) {
                            return;
                        }
                        if (!this->items.empty()) {
                            task = std::move(this->items.front());
                            this->items.pop();
                        }
                    }
                    task();
                }
            });
        }
    }

    std::future<int> enqueue(std::function<int(int)> &&func, int arg) {
        auto task = std::make_shared<std::packaged_task<int()>>(
                std::bind(std::forward<std::function<int(int)>>(func), arg));
        auto future = task->get_future();
        std::unique_lock<std::mutex> lock(mutex);
        items.emplace([task]() -> int { (*task)(); });
        cv.notify_one();
        return future;
    }

    ~ThreadPool() {
        {
            std::unique_lock<std::mutex> lock(mutex);
            stop = true;
            cv.notify_all();
        }
        for (auto &worker : workers) {
            worker.join();
        }
    }
};


int main() {
    ThreadPool tp(10);
    std::vector<std::future<int>> futures;
    for (int i = 0; i < 10; i++) {
        auto future = tp.enqueue([](int v) {
            std::this_thread::sleep_for(std::chrono::seconds(1));
            return v * v;
        }, i);
        futures.emplace_back(std::move(future));
    }
    std::cout << "All task enqueued." << std::endl;
    for (auto &&result: futures)
        std::cout << result.get() << ' ';
    std::cout << std::endl;
    return 0;
}