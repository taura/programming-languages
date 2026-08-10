#include <assert.h>
#include <err.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int64_t time_ns() {
  struct timespec ts[1];
  if (clock_gettime(CLOCK_REALTIME, ts) == -1) err(1, "clock_gettime");
  return ts->tv_nsec + ts->tv_sec * 1000L * 1000L * 1000L;
}

int64_t min(int64_t x, int64_t y) {
  return x < y ? x : y;
}

int64_t max(int64_t x, int64_t y) {
  return x < y ? y : x;
}

// allocation record that records how long an allocation took
struct Event {
  int64_t stamp;		// when it happened
  int64_t dt;                   // how long it took
};

// heap data structure that keeps track of longest m allocations
// (this heap should not be confused with heap memory of programming languages).
struct EventHeap {
  EventHeap(int64_t m_) {
    n = 0;
    m = m_;
    a = new Event[m];
    start_stamp = time_ns();
  }
  ~EventHeap() {
    n = 0;
    m = 0;
    start_stamp = 0;
    delete[] a;
    a = 0;
  }
  int64_t n;		   // actual no of elements
  int64_t m;               // number of elements a can hold
  Event * a;               // vector of m elements
  // invariant a[p] < a[2p+1], a[p] < a[2p+2]
  int64_t start_stamp;
  void add(Event x);
  Event removeSmallest();
  void addRecord(int64_t dt);
  void printHeap(const char * filename);
};

void swap(Event * a, int64_t i, int64_t j) {
  auto ai = a[i];
  auto aj = a[j];
  a[i] = aj;
  a[j] = ai;
}

// add an element x to heap h
void EventHeap::add(Event x) {
  assert(n < m);
  n = n + 1;
  a[n - 1] = x;
  auto c = n - 1;
  while (c > 0) {
    auto p = (c - 1) / 2;
    if (a[c].dt < a[p].dt) {
      swap(a, c, p);
    }
    c = p;
  }
}

// remove the smallest element from h
Event EventHeap::removeSmallest() {
  assert(n > 0);
  auto x = a[0];
  a[0] = a[n - 1];
  n = n - 1;
  int64_t p = 0;
  while (2 * p + 1 < n) {
    auto l = 2 * p + 1;
    auto r = 2 * p + 2;
    int64_t c;
    if (r < n && a[r].dt < a[l].dt) {
      c = r;
    } else {
      c = l;
    }
    if (a[c].dt < a[p].dt) {
      swap(a, c, p);
    }
    p = c;
  }
  return x;
}

// if h has a room for another element, insert Event(no, stamp, dt)
// otherwise if dt is larger than the smallest dt in h, then
// replace it with Event(no, stamp, dt)
void EventHeap::addRecord(int64_t dt) {
  if (n == m && a[0].dt < dt) { removeSmallest(); }
  if (n < m) {
    auto stamp = time_ns() - start_stamp;
    add(Event{stamp, dt});
  }
}

// debugprint heap
void EventHeap::printHeap(const char * filename) {
  FILE * wp = fopen(filename, "w");
  if (!wp) err(1, "fopen: %s", filename);
  for (int64_t i = 0; i < n; i++) {
    auto e = removeSmallest();
    fprintf(wp, "%ld,%ld\n", e.stamp, e.dt);
  }
  fclose(wp);
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
  BinSearchTree * left;
  BinSearchTree * right;
  BinSearchTree(uint64_t val_, BinSearchTree * left_, BinSearchTree * right_) {
    val = val_;
    left = left_;
    right = right_;
  }
};

// insert x to a tree
BinSearchTree * insert(BinSearchTree * t, uint64_t x) {
  if (!t) {
    return new BinSearchTree(x, nullptr, nullptr);
  } else {
    auto val = t->val;
    auto left = t->left;
    auto right = t->right;
    delete t;
    if (x <= val) {
      return new BinSearchTree(val, insert(left, x), right);
    } else {
      return new BinSearchTree(val, left, insert(right, x));
    }
  }
}

// remove the maximum element from a tree
BinSearchTree * remove_max(BinSearchTree * t) {
  if (!t) {
    return nullptr;
  } else if (!t->right) {
    auto left = t->left;
    delete t;
    return left;
  } else {
    auto val = t->val;
    auto left = t->left;
    auto right = t->right;
    delete t;
    return new BinSearchTree(val, left, remove_max(right));
  }
}

// find the maximum element of a tree
uint64_t peek_max(BinSearchTree * t)  {
  if (!t->right) {
    return t->val;
  } else {
    return peek_max(t->right);
  }
}

int main(int argc, char ** argv) {
  printf("lang = cplus\n");
  int64_t m = (argc > 1 ? atol(argv[1]) : 100L * 1000L);
  int64_t n = (argc > 2 ? atol(argv[2]) : m / 2);
  int64_t n_records = (argc > 3? atol(argv[3]) : max(n / 1000, 100));
  RandState rg(123456);
  printf("make a tree of m = %ld nodes\n", m);
  BinSearchTree * t = nullptr;
  for (int64_t i = 0; i < m; i++) {
    uint64_t x = rg.next() % 1000000000;
    t = insert(t, x);
  }
  printf("insert/delete n = %ld times\n", n);
  EventHeap h(n_records);
  auto t0 = time_ns();
  for (int64_t i = 0; i < n; i++) {
    uint64_t x = rg.next() % 1000000000;
    auto s0 = time_ns();
    t = insert(t, x);
    t = remove_max(t);
    auto s1 = time_ns();
    h.addRecord(s1 - s0);
  }
  auto t1 = time_ns();
  if (!t) {
    printf("\n");
  } else {
    auto v = peek_max(t);
    printf("%ld th smallest value out of %ld values v = %ld\n", m, (m + n), v);
  }
  printf("took %ld nsec to insert/remove %ld elements\n", (t1 - t0), n);
  auto alloc_log = "allocation-cc.csv";
  printf("dump %ld records that took longest to %s\n", n_records, alloc_log);
  h.printHeap(alloc_log);
  // destroy tree
  while (t) {
    t = remove_max(t);
  }
  return 0;
}

