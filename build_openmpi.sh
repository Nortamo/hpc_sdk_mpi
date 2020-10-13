set -e
cd $_BUILD_ROOT
rm -rf openmpi-4.0.3/ openmpi-4.0.3.tar.bz2
wget http://www.open-mpi.org/software/ompi/v4.0/downloads/openmpi-4.0.3.tar.bz2
tar -xvf openmpi-4.0.3.tar.bz2
cd  openmpi-4.0.3

./configure --prefix=$_STACK_ROOT/openmpi \
 --without-xpmem \
 --with-platform=contrib/platform/mellanox/optimized \
 --disable-silent-rules \
 --with-wrapper-ldflags= \
 --with-pmix=/usr \
 --enable-static \
 --with-zlib=/usr \
 --enable-mpi1-compatibility \
 --without-psm \
 --with-ucx=$_STACK_ROOT/ucx \
 --without-verbs \
 --without-mxm \
 --without-libfabric \
 --without-psm2 \
 --without-tm \
 --without-sge \
 --with-slurm \
 --without-lsf \
 --without-alps \
 --disable-memchecker \
 --with-libevent=/usr \
 --with-hcoll=$_HCOLL_ROOT \
 --with-hwloc=$_STACK_ROOT/hwloc \
 --disable-mpi-java \
 --with-cuda=$_HPC_SDK_ROOT/Linux_x86_64/20.7/cuda/$_CUDA_VERSION \
 --enable-cxx-exceptions

# Had to add the -fPIC flag, missing due to some unknown reason
#/scratch/project_2001659/nortamoh/HPC_SDK/openmpi-4.0.3/ompi/mpi/fortran/use-mpi-f08/
#LTPPFCCOMPILE = $(LIBTOOL) $(AM_V_lt) --tag=FC $(AM_LIBTOOLFLAGS) \
#	$(LIBTOOLFLAGS) --mode=compile $(FC) $(DEFS) \
#	$(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) -fPIC \
#	$(AM_FCFLAGS) $(FCFLAGS)

make -j 10
make install
rm -rf openmpi-4.0.3/ openmpi-4.0.3.tar.bz2
