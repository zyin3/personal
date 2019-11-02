// Copyright 2004-present Facebook. All Rights Reserved.

#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <deque>
#include <memory>

using namespace ::testing;

template <typename E>
class Queue {
 public:
  Queue() {}
  virtual void Enqueue(const E &element) = 0;
  virtual E Dequeue() = 0;
  virtual size_t Size() = 0;
  virtual ~Queue() {}
};

template <typename E>
class MockQueue : public Queue<E> {
 public:
  MOCK_METHOD1_T(Enqueue, void(const E &element));
  MOCK_METHOD0_T(Dequeue, E(void));
  MOCK_METHOD0_T(Size, size_t(void));
};

template <typename E>
class QueueManager {
 public:
  QueueManager(std::unique_ptr<Queue<E>> queue) : queue_(std::move(queue)) {}

  void BatchAdd(const std::vector<E> &items) {
    for (const E &item : items) {
      queue_->Enqueue(item);
    }
  }

 private:
  std::unique_ptr<Queue<E>> queue_;
};

class QueueManagerTest : public Test {
 protected:
  void SetUp() override {}
};

TEST_F(QueueManagerTest, MockEnqueueWorks) {
  std::unique_ptr<Queue<int>> mqPtr = std::make_unique<MockQueue<int>>();
  MockQueue<int>* rawPtr = dynamic_cast<MockQueue<int>*>(mqPtr.get());
  EXPECT_CALL(*rawPtr, Enqueue(::testing::_)).Times(2);
  QueueManager<int> qm(std::move(mqPtr));
  std::vector<int> v{1,1,1};
  qm.BatchAdd(v);
}
