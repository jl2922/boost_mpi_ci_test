CXXFLAGS := -std=c++17 -Wall -Wextra -fopenmp -O3 -g
TEST_EXE := test.x

all: $(TEST_EXE)
	./$(TEST_EXE)

$(TEST_EXE): main.cc
	$(CXX) $(CXXFLAGS) main.cc -o $(TEST_EXE)