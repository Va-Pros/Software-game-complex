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

if($ENV{QT_PATH})
    find_package(Qt5 COMPONENTS Widgets REQUIRED
            PATHS  $ENV{QT_PATH}
            NO_DEFAULT_PATH)
else()
    find_package(Qt5 COMPONENTS Widgets REQUIRED)
endif()

add_executable(Admin
        main.cpp
########################################################################################################################
        admin.cpp
        "${CMAKE_SOURCE_DIR}/include/Admin/admin.h"
########################################################################################################################
        main-menu.cpp
        "${CMAKE_SOURCE_DIR}/include/Admin/main-menu.h"
########################################################################################################################
        question-designer.cpp
        "${CMAKE_SOURCE_DIR}/include/Admin/question-designer.h"
########################################################################################################################
     )
target_link_libraries(Admin Qt5::Widgets)