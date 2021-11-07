cmake_minimum_required(VERSION 3.20)

project(Software_game_complex VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(${CMAKE_PREFIX_PATH} "${$ENV{QT_PATH}}")

# TODO
add_compile_options(
        -Werror

        -Wall
        -Wextra
        -Wpedantic

        -Wcast-align
        -Wcast-qual
        -Wconversion
        -Wctor-dtor-privacy
        -Wenum-compare
        -Wfloat-equal
        -Wnon-virtual-dtor
        -Wold-style-cast
        -Woverloaded-virtual
        -Wredundant-decls
        -Wsign-conversion
        -Wsign-promo
)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5 COMPONENTS Widgets REQUIRED)

message(STATUS ${CMAKE_PREFIX_PATH})
add_executable(${PROJECT_NAME}
        main.cpp
        resources.qrc
        )

# TODO
#add_subdirectory()

target_link_libraries(${PROJECT_NAME} Qt5::Widgets)

