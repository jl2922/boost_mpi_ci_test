#include <boost/mpi/communicator.hpp>
#include <boost/mpi/environment.hpp>
#include <cstdio>
#include <iostream>
#include <unordered_map>

namespace mpi = boost::mpi;

int main() {
  printf("hello world\n");

  mpi::environment env(argc, argv);
  mpi::communicator world;
  std::cout << "I am process " << world.rank() << " of " << world.size() << "."
            << std::endl;
  std::unordered_map<int, int> m;
  m[1] = 2;
  return 0;
}