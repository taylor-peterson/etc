#!/usr/bin/env bash
cd /tmp/volnoti

./prepare.sh
./configure --prefix=/usr

# Fix compilation error. See http://ubuntuforums.org/showthread.php?t=2215264
cd src
rm value-client-stub.h && make value-client-stub.h
rm value-daemon-stub.h && make value-daemon-stub.h
cd -

make
sudo make install
