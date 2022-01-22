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
    find_package(Qt5 COMPONENTS Widgets LinguistTools REQUIRED
            PATHS  $ENV{QT_PATH}
            NO_DEFAULT_PATH)
else()
    find_package(Qt5 COMPONENTS Widgets LinguistTools REQUIRED)
endif()

get_filename_component(TRANSLATIONS_DIR ../../resources/i18n ABSOLUTE)
set(TS_FILES ${TRANSLATIONS_DIR}/SGC_ru_RU.ts)

set(RESOURCE_FILES ../../resources/resources.qrc)

set(PROJECT_SOURCES
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
        ${TS_FILES}
        ${RESOURCE_FILES}
        )

qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})

foreach(_qm_file ${QM_FILES})
    if (NOT EXISTS ${_qm_file})
        continue()
    endif ()

    get_filename_component(QM_NAME ${_qm_file} NAME)
    configure_file(${_qm_file} ${TRANSLATIONS_DIR}/${QM_NAME} COPYONLY)
endforeach()

add_executable(Admin
        ${PROJECT_SOURCES}
)
target_link_libraries(Admin Qt5::Widgets)