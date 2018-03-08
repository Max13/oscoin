#!/bin/sh

# This script depends on the GNU script makeself.sh found at: http://megastep.org/makeself/
# Note: The structure of this package depends on the -rpath,./lib to be set at compile/link time.

version="1.7"
arch=`uname -i`

if [ "${arch}" = "x86_64" ]; then
    arch="64bit"
    QtLIBPATH="${HOME}/Qt5.4.2/5.4/gcc_64"
else
    arch="32bit"
    QtLIBPATH="${HOME}/Qt5.4.2/5.4/gcc"
fi

if [ -f oscoin-qt ] && [ -f oscoin.conf ] && [ -f README ]; then
    echo "Building OSCoin_${version}_${arch}.run ...\n"
    if [ -d OSCoin_${version}_${arch} ]; then
        rm -fr OSCoin_${version}_${arch}/
    fi
    mkdir OSCoin_${version}_${arch}
    mkdir OSCoin_${version}_${arch}/libs
    mkdir OSCoin_${version}_${arch}/platforms
    mkdir OSCoin_${version}_${arch}/imageformats
    cp oscoin-qt OSCoin_${version}_${arch}/
    cp oscoin.conf OSCoin_${version}_${arch}/
    cp README OSCoin_${version}_${arch}/
    ldd oscoin-qt | grep libssl | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} OSCoin_${version}_${arch}/libs/
    ldd oscoin-qt | grep libdb_cxx | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} OSCoin_${version}_${arch}/libs/
    ldd oscoin-qt | grep libboost_system | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} OSCoin_${version}_${arch}/libs/
    ldd oscoin-qt | grep libboost_filesystem | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} OSCoin_${version}_${arch}/libs/
    ldd oscoin-qt | grep libboost_program_options | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} OSCoin_${version}_${arch}/libs/
    ldd oscoin-qt | grep libboost_thread | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} OSCoin_${version}_${arch}/libs/
    ldd oscoin-qt | grep libminiupnpc | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} OSCoin_${version}_${arch}/libs/
    ldd oscoin-qt | grep libqrencode | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} OSCoin_${version}_${arch}/libs/
    cp ${QtLIBPATH}/lib/libQt*.so.5 OSCoin_${version}_${arch}/libs/
    cp ${QtLIBPATH}/lib/libicu*.so.53 OSCoin_${version}_${arch}/libs/
    cp ${QtLIBPATH}/plugins/platforms/lib*.so OSCoin_${version}_${arch}/platforms/
    cp ${QtLIBPATH}/plugins/imageformats/lib*.so OSCoin_${version}_${arch}/imageformats/
    strip OSCoin_${version}_${arch}/oscoin-qt
    echo "Enter your sudo password to change the ownership of the archive: "
    sudo chown -R nobody:nogroup OSCoin_${version}_${arch}

    # now build the archive
    if [ -f OSCoin_${version}_${arch}.run ]; then
        rm -f OSCoin_${version}_${arch}.run
    fi
    makeself.sh --notemp OSCoin_${version}_${arch} OSCoin_${version}_${arch}.run "\nCopyright (c) 2014-2015 The OSCoin Developers\nOSCoin will start when the installation is complete...\n" ./oscoin-qt \&
    sudo rm -fr OSCoin_${version}_${arch}/
    echo "Package created in: $PWD/OSCoin_${version}_${arch}.run\n"
else
    echo "Error: Missing files!\n"
    echo "Copy this file to a setup folder along with oscoin-qt, oscoin.conf and README.\n"
fi

