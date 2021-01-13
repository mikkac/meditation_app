cmake_minimum_required(VERSION 3.16)

project(meditation_app LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick LinguistTools REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick LinguistTools REQUIRED)

if(ANDROID)
    find_package(QT NAMES Qt6 Qt5 COMPONENTS AndroidExtras REQUIRED)
    find_package(Qt${QT_VERSION_MAJOR} COMPONENTS AndroidExtras REQUIRED)
endif()

if(ANDROID)
    add_library(meditation_app SHARED
      main.cpp
      logic/timer.cpp
      logic/meditationcontroller.cpp
      model/meditationmodel.cpp
      model/statsmodel.cpp
      model/settingsmodel.cpp
      qml.qrc
    )
else()
    add_executable(meditation_app
      main.cpp
      logic/timer.cpp
      logic/meditationcontroller.cpp
      model/meditationmodel.cpp
      model/statsmodel.cpp
      model/settingsmodel.cpp
      qml.qrc
    )
endif()

target_compile_definitions(meditation_app
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(meditation_app
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)
if(ANDROID)
    target_link_libraries(meditation_app
        PRIVATE Qt${QT_VERSION_MAJOR}::AndroidExtras)
endif()
