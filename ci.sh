test -n $CC && unset CC
test -n $CXX && unset CXX

# Get OpenMPI.
if [ -f "openmpi-3.0.0/bin/mpirun" ]; then
	echo "Using cached OpenMPI"
else
	echo "Downloading OpenMPI Source"
	wget https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.bz2
	tar xjf openmpi-3.0.0.tar.bz2
	echo "Configuring and building OpenMPI"
	cd openmpi-3.0.0
	./configure --prefix=$TRAVIS_BUILD_DIR/openmpi-3.0.0 CC=$C_C CXX=$CXX_C &> configure.log
	make -j 4 &> make.log
	make install &> install.log
	cd ..
fi
export PATH=$TRAVIS_BUILD_DIR/openmpi-3.0.0/bin:$PATH

make -j