cmake_minimum_required(VERSION 3.16)

project(QMLDemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(HTTP_SUPPORT OFF)
set(WS_SERVER_SUPPORT OFF)
set(WS_CLIENT_SUPPORT OFF)
set(ONVIF_SUPPORT OFF)
set(QML_SUPPORT ON)
add_subdirectory(WebRTSP)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)

pkg_check_modules(GSTREAMER REQUIRED gstreamer-1.0)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    VERSION 1.0
    QML_FILES
        Main.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${PROJECT_NAME} PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER org.webrtsp.${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    OUTPUT_NAME "${PROJECT_NAME}.app"
)

target_include_directories(${PROJECT_NAME}
    PRIVATE
        ${GSTREAMER_INCLUDE_DIRS}
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt6::Core
        Qt6::Quick
        ${GSTREAMER_LDFLAGS}
        WebRTSPClientPlugin
)
