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

set(COMPONENTS Widgets LinguistTools Quick QuickControls2 Qml Network)

if($ENV{QT_PATH})
    find_package(Qt5 COMPONENTS ${COMPONENTS} REQUIRED
            PATHS  $ENV{QT_PATH}
            NO_DEFAULT_PATH)
else()
    find_package(Qt5 COMPONENTS ${COMPONENTS} REQUIRED)
endif()

add_executable(Client
        main.cpp
        ../../resources/Client/resources.qrc
        TcpClient/TcpClient.cpp
        TcpClient/TcpClient.hpp

)

target_link_libraries(Client
        Qt5::Widgets Qt5::Quick Qt5::QuickControls2
        Qt5::Network
)

get_filename_component(TRANSLATION_ROOT ../../resources/Client/i18n ABSOLUTE)
set(TS_FILES ${TRANSLATION_ROOT}/SGC_ru_RU.ts)

get_filename_component(UI_PATH ../../resources/Client/ui ABSOLUTE)
add_custom_target(ClientTranslationsUpdate
        COMMAND ${Qt5_LUPDATE_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR} ${UI_PATH} -recursive -ts ${TS_FILES}
)

add_custom_target(ClientTranslationsRelease
        COMMAND ${Qt5_LRELEASE_EXECUTABLE} ${TS_FILES}
)

add_custom_target(ClientTranslateAndRun
        DEPENDS ClientTranslationsUpdate ClientTranslationsRelease
)
