#include <assert.h>
#include <err.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <utility>

int64_t time_ns() {
  struct timespec ts[1];
  if (clock_gettime(CLOCK_REALTIME, ts) == -1) err(1, "clock_gettime");
  return ts->tv_nsec + ts->tv_sec * 1000L * 1000L * 1000L;
}

// random number generator state
struct RandState {
  uint64_t x;
  uint64_t next();
  RandState(uint64_t x_) { x = x_; }
};

// next number
uint64_t RandState::next() {
  uint64_t a = 0x5DEECE66D;
  uint64_t c = 0xB;
  uint64_t m = (1UL << 48) - 1;
  x = (a * x + c) & m;
  return x >> 17;
}

// binary search tree
struct BinSearchTree {
  uint64_t val;
  uint64_t lc;
  BinSearchTree * left;
  uint64_t rc;
  BinSearchTree * right;
  BinSearchTree(uint64_t val, uint64_t lc, BinSearchTree * left, uint64_t rc, BinSearchTree * right) {
    this->val = val;
    this->lc = lc;
    this->left = left;
    this->rc = rc;
    this->right = right;
  }
};

// insert x to a tree
BinSearchTree * insert(BinSearchTree * t, uint64_t x) {
  if (!t) {
    return new BinSearchTree(x, 0, nullptr, 0, nullptr);
  } else {
    auto val = t->val;
    auto lc = t->lc;
    auto left = t->left;
    auto rc = t->rc;
    auto right = t->right;
    delete t;
    if (x <= val) {
      return new BinSearchTree(val, lc + 1, insert(left, x), rc, right);
    } else {
      return new BinSearchTree(val, lc, left, rc + 1, insert(right, x));
    }
  }
}

// remove the nth element in the tree (0-based), and return the removed value and the new tree
std::pair<uint64_t, BinSearchTree *> remove_nth(BinSearchTree * t, uint64_t n) {
  if (!t) {
    err(1, "remove_nth : empty tree");
  } else if (n < t->lc) {
    auto [val, left_] = remove_nth(t->left, n);
    auto val_ = t->val;
    auto lc_ = t->lc - 1;
    auto rc_ = t->rc;
    auto right_ = t->right;
    delete t;
    return {val, new BinSearchTree(val_, lc_, left_, rc_, right_)};
  } else if (n == t->lc) {
    if (t->lc < t->rc) {
      auto [val, right_] = remove_nth(t->right, 0);
      auto val_ = t->val;
      auto lc_ = t->lc;
      auto left_ = t->left;
      auto rc_ = t->rc - 1;
      delete t;
      return {val_, new BinSearchTree(val_, lc_, left_, rc_, right_)};
    } else if (t->left) {
      auto [val, left_] = remove_nth(t->left, t->lc - 1);
      auto val_ = t->val;
      auto lc_ = t->lc - 1;
      auto rc_ = t->rc;
      auto right_ = t->right;
      delete t;
      return {val_, new BinSearchTree(val_, lc_, left_, rc_, right_)};
    } else {
      auto val_ = t->val;
      delete t;
      return {val_, nullptr};
    }
  } else {
    auto [val, right_] = remove_nth(t->right, n - t->lc - 1);
    auto val_ = t->val;
    auto lc_ = t->lc;
    auto left_ = t->left;
    auto rc_ = t->rc - 1;
    delete t;
    return {val, new BinSearchTree(val_, lc_, left_, rc_, right_)};
  }
}

void dump(BinSearchTree * t, uint64_t n) {
  if (t && n > 0) {
    dump(t->left, n);
    if (t->lc < n) {
      printf("%lu ", t->val);
      if (t->lc + 1 < n) {
	dump(t->right, n - t->lc - 1);
      }
    }
  }
}

int main(int argc, char ** argv) {
  printf("lang = cplus\n");
  int64_t m = (argc > 1 ? atol(argv[1]) : 100L * 1000L);
  int64_t n = (argc > 2 ? atol(argv[2]) : m / 2);
  RandState rg(123456);
  printf("make a tree of m = %ld nodes\n", m);
  BinSearchTree * t = nullptr;
  for (int64_t i = 0; i < m; i++) {
    uint64_t x = rg.next() % 1000000000;
    t = insert(t, x);
  }
  printf("insert/delete n = %ld times\n", n);
  auto t0 = time_ns();
  for (int64_t i = 0; i < n; i++) {
    uint64_t x = rg.next() % 1000000000;
    uint64_t k = rg.next() % (m + 1);
    t = insert(t, x);
    auto vt = remove_nth(t, k);
    t = vt.second;
  }
  auto t1 = time_ns();
  printf("dump the first 5 elements in the tree : ");
  dump(t, 5);
  printf("\n");
  printf("took %ld nsec to insert/remove %ld elements (%f nsec/elem)\n", (t1 - t0), n, (t1 - t0) / (double)n);
  return 0;
}

