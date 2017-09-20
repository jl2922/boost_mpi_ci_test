CXX := mpic++
CXXFLAGS := -std=c++17 -Wall -Wextra -fopenmp -O3 -g
TEST_EXE := test.x

LOCAL_MAKEFILE := local.mk
ifneq ($(wildcard $(LOCAL_MAKEFILE)),)
include $(LOCAL_MAKEFILE)
endif

all: $(TEST_EXE)
	./$(TEST_EXE)

$(TEST_EXE): main.cc
	$(CXX) $(CXXFLAGS) main.cc -o $(TEST_EXE)