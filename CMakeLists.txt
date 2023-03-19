cmake_minimum_required(VERSION 3.24)
project(3 C ASM)

set(CMAKE_CXX_STANDARD 14)

set (GCC_COVERAGE_COMPILE_FLAGS "-no-pie")
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}")
include_directories(.)

add_executable(3
        tirgul.s)
