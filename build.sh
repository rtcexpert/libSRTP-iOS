dobuild() {
export CC="$(xcrun -find -sdk ${SDK} cc)"
# export CXX="$(xcrun -find -sdk ${SDK} cxx)"
export CPP="$(xcrun -find -sdk ${SDK} cpp)"
export CFLAGS="${HOST_FLAGS} ${OPT_FLAGS}"
export CXXFLAGS="${HOST_FLAGS} ${OPT_FLAGS}"
export LDFLAGS="${HOST_FLAGS}"
./configure --host=${CHOST} --prefix=${PREFIX} --enable-openssl --with-openssl-dir="../openssl/"
make
}

SDK="iphoneos"
ARCH_FLAGS="-arch armv7"
HOST_FLAGS="${ARCH_FLAGS} -miphoneos-version-min=8.0 -isysroot $(xcrun -sdk ${SDK} --show-sdk-path)"
CHOST="arm-apple-darwin"
dobuild
mv libsrtp2.a libsrtp_armv7.a
make clean

SDK="iphoneos"
ARCH_FLAGS="-arch arm64"
HOST_FLAGS="${ARCH_FLAGS} -miphoneos-version-min=8.0 -isysroot $(xcrun -sdk ${SDK} --show-sdk-path)"
CHOST="arm-apple-darwin"
dobuild
mv libsrtp2.a libsrtp_armv64.a
make clean

SDK="iphonesimulator"
ARCH_FLAGS="-arch i386"
HOST_FLAGS="${ARCH_FLAGS} -mios-simulator-version-min=8.0 -isysroot $(xcrun -sdk ${SDK} --show-sdk-path)"
CHOST="i386-apple-darwin"
dobuild
mv libsrtp2.a libsrtp_i386.a
make clean

SDK="iphonesimulator"
ARCH_FLAGS="-arch x86_64"
HOST_FLAGS="${ARCH_FLAGS} -mios-simulator-version-min=8.0 -isysroot $(xcrun -sdk ${SDK} --show-sdk-path)"
CHOST="x86_64-apple-darwin"
dobuild
mv libsrtp2.a libsrtp_x86_64.a
make clean

lipo -create libsrtp_x86_64.a libsrtp_i386.a libsrtp_armv64.a libsrtp_armv7.a -output libsrtp.a
