#!/bin/bash

BASENAME="$(basename $0)"
BASEDIR="$(dirname $0)"

echo -n "Renaming all vericoin files to oscoin"
find $BASEDIR -name "vericoin*" -print0 | while IFS= read -r -d $'\0' name; do
    newname=$(echo "$name" | sed 's/vericoin/oscoin/')
    mv "$name" "$newname" > /dev/null && echo -n "." || exit 1
done
echo " OK"

echo

echo -n "Renaming all VeriCoin files to OSCoin"
find $BASEDIR -name "VeriCoin*" -print0 | while IFS= read -r -d $'\0' name; do
    newname=$(echo "$name" | sed 's/VeriCoin/OSCoin/')
    mv "$name" "$newname" > /dev/null && echo -n "." || exit 1
done
echo " OK"

echo

echo -n "Changing inplace vericoin to oscoin texts"
grep -lR --null --exclude="$BASENAME" --exclude="INSTALL" --exclude-dir=".git" "vericoin" $BASEDIR | while IFS= read -r -d $'\0' name; do
    sed -i '' "s/vericoin/oscoin/g" "$name" > /dev/null
    if [[ "$?" == "0" ]]; then
        echo -n "."
    else
        echo "($name)"
        exit 1
    fi
done
echo " OK"

echo

echo -n "Changing inplace VeriCoin to OSCoin texts"
grep -lR --null --exclude="$BASENAME" --exclude="INSTALL" --exclude-dir=".git" "VeriCoin" $BASEDIR | while IFS= read -r -d $'\0' name; do
    sed -i '' "s/VeriCoin/OSCoin/g" "$name" > /dev/null
    if [[ "$?" == "0" ]]; then
        echo -n "."
    else
        echo "($name)"
        exit 1
    fi
done
echo " OK"

echo

echo -n "Changing inplace VERICOIN to OSCOIN texts"
grep -lR --null --exclude="$BASENAME" --exclude="INSTALL" --exclude-dir=".git" "VERICOIN" $BASEDIR | while IFS= read -r -d $'\0' name; do
    sed -i '' "s/VERICOIN/OSCOIN/g" "$name" > /dev/null
    if [[ "$?" == "0" ]]; then
        echo -n "."
    else
        echo "($name)"
        exit 1
    fi
done
echo " OK"

echo

echo -n "Changing inplace VRC to OSC texts"
grep -lR --null --exclude="$BASENAME" --exclude="INSTALL" --exclude-dir=".git" "VRC" $BASEDIR | while IFS= read -r -d $'\0' name; do
    sed -i '' "s/VRC/OSC/g" "$name" > /dev/null
    if [[ "$?" == "0" ]]; then
        echo -n "."
    else
        echo "($name)"
        exit 1
    fi
done
echo " OK"

echo
echo "Ready to rock !"
