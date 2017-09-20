CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -fopenmp -O3 -g
TEST_EXE := test.x

CONFIG_FILE := local.mk
ifneq ($(wildcard $(CONFIG_FILE)),)
include $(CONFIG_FILE)
endif

all: $(TEST_EXE)
	./$(TEST_EXE)

$(TEST_EXE): main.cc
	$(CXX) $(CXXFLAGS) main.cc -o $(TEST_EXE)