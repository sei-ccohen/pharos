// Copyright 2019 Carnegie Mellon University.  See LICENSE file for terms.

#include "test.hpp"

void func(volatile int n) {
  path_start();
  if (n > 2) {
    if (n < 10) {
      n++;
    }
  }
  path_goal();
}
int main() {
  func(INT_RAND);
}
