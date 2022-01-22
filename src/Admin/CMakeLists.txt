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

set(COMPONENTS Widgets LinguistTools)

if($ENV{QT_PATH})
    find_package(Qt5 COMPONENTS ${COMPONENTS} REQUIRED
            PATHS  $ENV{QT_PATH}
            NO_DEFAULT_PATH)
else()
    find_package(Qt5 COMPONENTS ${COMPONENTS} REQUIRED)
endif()

add_executable(Admin
        main.cpp
        ../../resources/resources.qrc
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

get_filename_component(TRANSLATION_ROOT ../../resources/i18n ABSOLUTE)
set(TS_FILES ${TRANSLATION_ROOT}/SGC_ru_RU.ts)

add_custom_target(AdminTranslationsUpdate
        COMMAND ${Qt5_LUPDATE_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR} -recursive -ts ${TS_FILES}
)

add_custom_target(AdminTranslationsRelease
        COMMAND ${Qt5_LRELEASE_EXECUTABLE} ${TS_FILES}
)

add_custom_target(AdminTranslateAndRun
        DEPENDS AdminTranslationsUpdate AdminTranslationsRelease Admin
)