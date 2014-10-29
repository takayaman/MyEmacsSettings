#!/bin/sh

clang++ -cc1 -emit-pch -x c++-header ./stdafx.hpp -o stdafx.pch -I/usr/include/c++/4.6 -I/usr/include/c++/4.6/x86_64-linux-gnu/. -I/usr/include/c++/4.6/backward -I/usr/lib/gcc/x86_64-linux-gnu/4.6/include -I/usr/local/include -I/usr/lib/gcc/x86_64-linux-gnu/4.6/include-fixed -I/usr/include/x86_64-linux-gnu -I/usr/include -I/usr/local/include/ -I/usr/local/include/ -I~/Qt5.0.2/5.0.2/gcc_64/include
