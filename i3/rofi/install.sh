#!/usr/bin/env bash
cd /tmp/rofi

git submodule update --init
autoreconf -i
mkdir -p build
cd build
../configure
make
sudo make install
