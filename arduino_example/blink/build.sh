#!/bin/bash

if [ $# -ne "2" ] || [ ! -f "$2" ]; then
    echo "usage: $0 [build | flash] <ino file>"
    exit 1
fi

if [ "$1" != "build" ] && [ "$1" != "flash" ]; then
    echo "usage: $0 [build | flash] <ino file>"
    exit 1
fi


abs_path() {
    pushd . > /dev/null
    if [ -f "$1" ]; then
	CUR_DIR="$(dirname $1)"
    else
	CUR_DIR=$1
    fi

    cd ${CUR_DIR}
    CUR_PATH="$(pwd)"
    echo "${CUR_PATH}"
    popd > /dev/null
}

dirname=$(abs_path "$2")
fullname=$(basename -- "$2")
extension="${fullname##*.}"
filename="${fullname%.*}"
fullpath="${dirname}/${filename}.cpp"

if [ ! -e "${dirname}/Makefile.txt" ]; then
    echo "### You need the Makefile.txt to build $2"
    exit 1
fi
echo "source file: ${dirname}/${fullname}"

cp "$2" ${fullpath}

{ echo "#include <Arduino.h>"; cat ${fullpath}; } > "${fullpath}.new"
mv ${fullpath}{.new,}

pushd . > /dev/null

cd ${dirname}
mkdir -p build

{ echo "CODENAME=${dirname}/${filename}"; cat Makefile.txt; } > "build/Makefile.new"
mv build/Makefile{.new,}

cd build
make $1

popd > /dev/null

echo "### build directory: ${dirname}/build"
