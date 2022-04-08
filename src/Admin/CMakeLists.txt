# TODO
add_compile_options(
#     -Werror

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

set(COMPONENTS Widgets LinguistTools Quick QuickControls2 Qml Network Sql)

if($ENV{QT_PATH})
    find_package(Qt5 COMPONENTS ${COMPONENTS} REQUIRED
            PATHS  $ENV{QT_PATH}
            NO_DEFAULT_PATH)
else()
    find_package(Qt5 COMPONENTS ${COMPONENTS} REQUIRED)
endif()

add_executable(Admin
        main.cpp
        ../../resources/Admin/resources.qrc
        TcpServer/TcpServer.cpp
        TcpServer/TcpServer.hpp

        DB/database.h DB/database.cpp

        SituationConstructor/SituationModifyHelper.h SituationConstructor/SituationModel.h SituationConstructor/SituationModel.cpp SituationConstructor/SituationNode.h SituationConstructor/SituationNet.h SituationConstructor/SimpleSituationNode.cpp SituationConstructor/SimpleSituationNode.h ../Common/Situation/TestSituation.cpp ../Common/Situation/TestSituation.h GameManagement/backendLayer.cpp GameManagement/backendLayer.h ../../include/utils/enums.h ../utils/enums.cpp AdminBackend/Admin.cpp AdminBackend/Themes.cpp AdminBackend/Themes.h AdminBackend/NumberOfQuestion.h AdminBackend/Admin.h AdminBackend/ListModel.cpp AdminBackend/ListModel.h ResultViewer/TableModel.cpp ResultViewer/TableModel.h ResultViewer/TableElement.cpp ResultViewer/TableElement.h)

target_link_libraries(Admin
        Qt5::Widgets Qt5::Quick Qt5::QuickControls2
        Qt5::Network Qt5::Sql
)

get_filename_component(TRANSLATION_ROOT ../../resources/Admin/i18n ABSOLUTE)
set(TS_FILES ${TRANSLATION_ROOT}/SGC_ru_RU.ts)

get_filename_component(UI_PATH ../../resources/Admin/ui ABSOLUTE)
add_custom_target(AdminTranslationsUpdate
        COMMAND ${Qt5_LUPDATE_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR} ${UI_PATH} -recursive -ts ${TS_FILES}
)

add_custom_target(AdminTranslationsRelease
        COMMAND ${Qt5_LRELEASE_EXECUTABLE} ${TS_FILES}
)

add_custom_target(AdminTranslateAndRun
        DEPENDS AdminTranslationsUpdate AdminTranslationsRelease
)
