cmake_minimum_required(VERSION 3.20)

project(Software_game_complex VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)

# TODO
add_subdirectory(src src/build)
