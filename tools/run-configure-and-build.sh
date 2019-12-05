#!/bin/bash

rm -rf build \
&& cmake -H. -B./build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
&& cmake --build ./build --target all -- -j8
