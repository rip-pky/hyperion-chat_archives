cmake_minimum_required(VERSION 3.20)
project(ProjectHyperion VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Network WebEngineWidgets WebChannel)

set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)

add_executable(ProjectHyperion
    ${SRC_DIR}/main.cpp
    ${SRC_DIR}/mainwindow.cpp
    ${SRC_DIR}/media_buffer.cpp
    ${SRC_DIR}/secure_socket_client.cpp
    ${SRC_DIR}/hwid_utils.cpp
    ${SRC_DIR}/md3_theme.cpp
    ${SRC_DIR}/profiledialog.cpp
    ${SRC_DIR}/errordialog.cpp
    ${SRC_DIR}/webbridge.cpp
    ${SRC_DIR}/resources.qrc
)

target_include_directories(ProjectHyperion PRIVATE ${SRC_DIR})

target_link_libraries(ProjectHyperion PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::Network
    Qt6::WebEngineWidgets
    Qt6::WebChannel
)

set_target_properties(ProjectHyperion PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
)

install(TARGETS ProjectHyperion RUNTIME DESTINATION bin)
