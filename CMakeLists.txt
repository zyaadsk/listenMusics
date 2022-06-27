cmake_minimum_required(VERSION 3.5)

#include_directories("/run/media/root/date/softwareDevelopment/ListenToSomeMusic/include/")

#link_directories("/run/media/root/date/softwareDevelopment/ListenToSomeMusic/lib/")

project(ListenToSomeMusic VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check https://doc.qt.io/qt/deployment-android.html for more information.
# They need to be set before the find_package( ...) calls below.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Widgets REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Widgets REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Qml)
find_package(Qt6 REQUIRED COMPONENTS Network)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)
find_package(Qt6 REQUIRED COMPONENTS Core)

set(PROJECT_SOURCES
        main.cpp
        Resources.qrc
        mainwindow.h
        mainwindow.cpp
        kugou.h
        kugou.cpp
        decode.h
        decode.cpp
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(ListenToSomeMusic
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
else()
    if(ANDROID)
        add_library(ListenToSomeMusic SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_executable(ListenToSomeMusic
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(ListenToSomeMusic PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)
target_link_libraries(ListenToSomeMusic PRIVATE Qt${QT_VERSION_MAJOR}::Qml)
target_link_libraries(ListenToSomeMusic PRIVATE Qt${QT_VERSION_MAJOR}::Network)
target_link_libraries(ListenToSomeMusic PRIVATE Qt${QT_VERSION_MAJOR}::Multimedia)
target_link_libraries(ListenToSomeMusic PRIVATE Qt${QT_VERSION_MAJOR}::Core)
target_link_libraries(ListenToSomeMusic PRIVATE avutil avcodec avfilter avdevice avformat postproc swresample)

set_target_properties(ListenToSomeMusic PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(ListenToSomeMusic)
endif()
