test -n $CC && unset CC
test -n $CXX && unset CXX

# Get OpenMPI.
if [ -f "deps/openmpi-3.0.0/bin/mpic++" ] && [ -f "deps/openmpi-3.0.0/bin/mpic++" ]; then
	echo "Using cached OpenMPI"
else
	echo "Downloading OpenMPI Source"
  mkdir -p downloads
  cd downloads
	wget https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.bz2
	tar xjf openmpi-3.0.0.tar.bz2
	echo "Configuring and building OpenMPI"
	cd openmpi-3.0.0
  mkdir -p $TRAVIS_BUILD_DIR/deps/openmpi-3.0.0
	./configure --prefix=$TRAVIS_BUILD_DIR/deps/openmpi-3.0.0 CC=$C_C CXX=$CXX_C &> configure.log
	make -j 4 &> make.log
	make install &> install.log
	cd ../../
fi
export PATH=$TRAVIS_BUILD_DIR/deps/openmpi-3.0.0/bin:$PATH
export LD_LIBRARY_PATH=$TRAVIS_BUILD_DIR/deps/openmpi-3.0.0/lib:$LD_LIBRARY_PATH

# Get Protocol Buffers.
if [ -f "deps/protobuf-3.4.1/bin/protoc" ]; then
	echo "Using cached Protocol Buffers"
else
	echo "Downloading Protocol Buffers"
  mkdir -p downloads
  cd downloads
	wget https://github.com/google/protobuf/releases/download/v3.4.1/protobuf-cpp-3.4.1.tar.gz
	tar xzf protobuf-cpp-3.4.1.tar.gz
	echo "Configuring and building Protocol Buffers"
	cd protobuf-3.4.1
  mkdir -p $TRAVIS_BUILD_DIR/deps/protobuf-3.4.1
	./configure --prefix=$TRAVIS_BUILD_DIR/deps/protobuf-3.4.1 CC=$C_C CXX=$CXX_C &> configure.log
	make -j 4 &> make.log
	make install &> install.log
	cd ../../
fi
export PATH=$TRAVIS_BUILD_DIR/deps/protobuf-3.4.1/bin:$PATH
export LD_LIBRARY_PATH=$TRAVIS_BUILD_DIR/deps/protobuf-3.4.1/lib:$LD_LIBRARY_PATH

# Get Boost (with MPI).
if [ -f "deps/boost-1.65.1/lib/libboost_mpi.so" ] && [ -f "deps/boost-1.65.1/lib/libboost_serialization.so" ]; then
	echo "Using cached Boost"
else
	echo "Downloading Boost"
  mkdir -p downloads
  cd downloads
	wget https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.bz2
	tar xjf boost_1_65_1.tar.bz2
	echo "Configuring and building Boost"
	cd boost_1_65_1
  mkdir -p $TRAVIS_BUILD_DIR/deps/boost-1.65.1
  ./bootstrap.sh > bootstrap.sh
  echo 'libraries =  --with-mpi --with-serialization ;' >> project-config.jam
  echo 'using mpi : mpic++ ;' >> project-config.jam
	./b2 -j4 --prefix=$TRAVIS_BUILD_DIR/deps/boost-1.65.1 CC=$C_C CXX=$CXX_C install &> b2.log
	cd ../../
fi
export PATH=$TRAVIS_BUILD_DIR/deps/boost-1.65.1/bin:$PATH
export LD_LIBRARY_PATH=$TRAVIS_BUILD_DIR/deps/boost-1.65.1/lib:$LD_LIBRARY_PATH


mpic++ --version
make -j