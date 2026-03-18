ARG TAG=devel
FROM ubuntu:${TAG}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y cmake clang libstdc++-13-dev && \
    apt-get purge --autoremove -y && \
    apt-get clean

RUN printf "#include <iostream>\n int main() { std::cout << "Hello, CMake!" << std::endl; return 0; }" > main.cpp
RUN printf "cmake_minimum_required(VERSION 3.12)\nproject(HelloWorld VERSION 1.0 LANGUAGES CXX)\nadd_executable(HelloWorld main.cpp)" > CMakeLists.txt
RUN cmake -B build -DCMAKE_CXX_COMPILER=clang++

RUN apt-get install -y ilibboost-all-dev
RUN cmake -B build2 -DCMAKE_CXX_COMPILER=clang++
