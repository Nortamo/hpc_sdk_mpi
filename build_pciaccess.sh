set -e
cd $_BUILD_ROOT
rm -rf libpciaccess-0.13.5 libpciaccess-0.13.5.tar.gz
wget http://xorg.freedesktop.org/archive/individual/lib/libpciaccess-0.13.5.tar.gz
tar -xvf libpciaccess-0.13.5.tar.gz
cd libpciaccess-0.13.5
./configure --prefix=$_STACK_ROOT/libpciaccess/

# nvc only understands Werror, deprectaion stops build
sed -i 's/-Werror=[a-z,A-Z,-]*//g' Makefile
sed -i 's/-Werror//g' Makefile
cd src
sed -i 's/-Werror=[a-z,A-Z,-]*//g' Makefile
sed -i 's/-Werror//g' Makefile
cd ..
make -j 10
make install
rm -rf libpciaccess-0.13.5 libpciaccess-0.13.5.tar.gz
