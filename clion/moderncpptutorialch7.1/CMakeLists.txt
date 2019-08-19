cmake_minimum_required(VERSION 3.14)
project(moderncpptutorialch7_1)

set(CMAKE_CXX_STANDARD 17)

add_executable(moderncpptutorialch7_1 main.cpp)
SET(CMAKE_CXX_FLAGS -pthread)