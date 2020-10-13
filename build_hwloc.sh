set -e
cd $_BUILD_ROOT
rm -rf  hwloc-build
git clone https://github.com/open-mpi/hwloc.git hwloc-build
cd  hwloc-build


if [ -z "$CPATH" ];then
    CPATH="$_STACK_ROOT/libpciaccess/include"
else
    CPATH="$CPATH:$_STACK_ROOT/libpciaccess/include"
fi

    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$_STACK_ROOT/libpciaccess/lib"

if [ -z "$LIBRARY_PATH" ];then
    LIBRARY_PATH="$_STACK_ROOT/libpciaccess/lib"
else
    LIBRARY_PATH="$LIBRARY_PATH:$_STACK_ROOT/libpciaccess/lib"
fi

./autogen.sh

./configure \
 --prefix=$_STACK_ROOT/hwloc \
 --disable-opencl \
 --enable-netloc \
 --disable-cairo \
 --enable-cuda \
 --disable-nvml \
 --disable-gl \
 --enable-libxml2 \
 --enable-pci \
 --enable-shared \
LDFLAGS="-L$_STACK_ROOT/libpciaccess/lib -L$_HPC_SDK_ROOT/Linux_x86_64/20.7/cuda/$_CUDA_VERSION/lib64/"


MKFILES=$(find . -name "Makefile")

while IFS= read -r MKF; do
    sed -i 's/-Werror=[a-z,A-Z,-]*//g' $MKF
    sed -i 's/-Werror//g' $MKF
    sed -i 's/-pedantic//g' $MKF
    sed -i 's/-W[a-z,A-Z,-]*//g' $MKF
    sed -i "s/-implicit-function-declaration//g" $MKF
done <<< "$MKFILES"


make -j 10
make install
rm -rf hwloc-build
