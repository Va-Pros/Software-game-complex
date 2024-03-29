# TODO
add_compile_options(
#     -Werror

     -Wall
#     -Wextra
#     -Wpedantic

#     -Wcast-align
#     -Wcast-qual
#     -Wconversion
#     -Wctor-dtor-privacy
#     -Wenum-compare
#     -Wfloat-equal
#     -Wnon-virtual-dtor
#     -Wold-style-cast
#     -Woverloaded-virtual
#     -Wredundant-decls
#     -Wsign-conversion
#     -Wsign-promo
)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(COMPONENTS Widgets LinguistTools Quick QuickControls2 Qml)

if($ENV{QT_PATH})
    find_package(Qt5 COMPONENTS ${COMPONENTS} REQUIRED
            PATHS  $ENV{QT_PATH}
            NO_DEFAULT_PATH)
else()
    find_package(Qt5 COMPONENTS ${COMPONENTS} REQUIRED)
endif()

add_library(Common
        Situation/TestSituation.h
        Situation/TestSituation.cpp
        )

target_link_libraries(Admin
        Qt5::Widgets Qt5::Quick Qt5::QuickControls2
)

get_filename_component(TRANSLATION_ROOT ../../resources/i18n ABSOLUTE)
set(TS_FILES ${TRANSLATION_ROOT}/SGC_ru_RU.ts)

get_filename_component(UI_PATH ../../resources/ui ABSOLUTE)
add_custom_target(AdminTranslationsUpdate
        COMMAND ${Qt5_LUPDATE_EXECUTABLE} . ${UI_PATH} -recursive -ts ${TS_FILES}
)

add_custom_target(AdminTranslationsRelease
        COMMAND ${Qt5_LRELEASE_EXECUTABLE} ${TS_FILES}
)

add_custom_target(AdminTranslateAndRun
        DEPENDS AdminTranslationsUpdate AdminTranslationsRelease
)
