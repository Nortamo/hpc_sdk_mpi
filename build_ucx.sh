set -e
cd $_BUILD_ROOT

module use $_H_MODULE_T
module load gcc/7.4.0


rm -rf  ucx-build
git clone https://github.com/openucx/ucx.git ucx-build

cd  ucx-build

./autogen.sh
./configure --prefix=$_STACK_ROOT/ucx \
    --with-cuda=$_HPC_SDK_ROOT/Linux_x86_64/20.7/cuda/$_CUDA_VERSION \
    --disable-logging \
    --enable-debug  \
    --disable-assertions  \
    --disable-params-check  \
    --with-gdrcopy=/usr/lib64 \
    --disable-logging  \
    --enable-mt  \
    --disable-params-check  \
    --enable-cma  \
    --with-verbs  \
    --with-cm  \
    --with-knem  \
    --with-rdmacm  \
    --without-rocm  \
    --without-xpmem  \
    --without-ugni  \
    --with-march  \
    --with-mlx5-dv  \
    --with-ib-hw-tm  \
    --with-dm  \
    --with-cm  \
    --enable-optimizations 
make -j 10
make install
rm -rf ucx-build
