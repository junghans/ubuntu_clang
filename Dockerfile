ARG TAG=devel
FROM ubuntu:${TAG}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
       make cmake g++ libexpat-dev libfftw3-dev libboost-all-dev txt2tags ccache gnuplot python3-numpy doxygen vim clang llvm python3-pip python3-lxml \
       wget libhdf5-dev graphviz pkg-config psmisc libeigen3-dev libxc-dev sudo curl clang-tidy ninja-build libclang-dev llvm-dev libomp-dev libstdc++-13-dev \
       clang-format software-properties-common zstd libint2-dev libecpint-dev python3-rdkit python3-h5py python3-pytest pybind11-dev python3-xmltodict ase && \
    apt-get purge --autoremove -y && \
    apt-get clean

RUN useradd -m -G sudo -u 1001 user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user
WORKDIR /home/user
RUN printf "#include <iostream>\n int main() { std::cout << "Hello, CMake!" << std::endl; return 0; }" > main.cpp
RUN printf "cmake_minimum_required(VERSION 3.12)\nproject(HelloWorld VERSION 1.0 LANGUAGES CXX)\nadd_executable(HelloWorld main.cpp)" > CMakeLists.txt
RUN cmake -B build -DCMAKE_CXX_COMPILER=clang++
