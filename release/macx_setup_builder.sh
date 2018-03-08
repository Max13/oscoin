#!/bin/sh

# Note: The structure of this package depends on the -rpath,./lib to be set at compile/link time.

version="1.6.5.5"
arch=`uname -m`

if [ "${arch}" = "x86_64" ]; then
    arch="64bit"
else
    arch="32bit"
fi

if [ -f OSCoin-Qt.app/Contents/MacOS/OSCoin-Qt ] && [ -f oscoin.conf ] && [ -f README ]; then
    echo "Building OSCoin_${version}_${arch}.pkg ...\n"
    cp oscoin.conf OSCoin-Qt.app/Contents/MacOS/
    cp README OSCoin-Qt.app/Contents/MacOS/

    # Remove the old archive
    if [ -f OSCoin_${version}_${arch}.pkg ]; then
        rm -f OSCoin_${version}_${arch}.pkg
    fi

    # Deploy the app, create the plist, then build the package.
    macdeployqt ./OSCoin-Qt.app -always-overwrite
    pkgbuild --analyze --root ./OSCoin-Qt.app share/qt/OSCoin-Qt.plist
    pkgbuild --root ./OSCoin-Qt.app --component-plist share/qt/OSCoin-Qt.plist --identifier org.oscoin.OSCoin-Qt --install-location /Applications/OSCoin-Qt.app OSCoin_${version}_${arch}.pkg
    echo "Package created in: $PWD/OSCoin_${version}_${arch}.pkg\n"
else
    echo "Error: Missing files!\n"
    echo "Run this script from the folder containing OSCoin-Qt.app, oscoin.conf and README.\n"
fi

