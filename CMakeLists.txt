cmake_minimum_required(VERSION 3.10)

project(IceInterface)

if (BUILD_SHARED_LIBS)
  set(icegen_BUILD_SHARED_LIBS ON)
else (BUILD_SHARED_LIBS)
  set(icegen_BUILD_SHARED_LIBS OFF)
endif(BUILD_SHARED_LIBS)
include(iceGenerator.cmake)

# set ice gen folder
set(IceBuildDir ${CMAKE_CURRENT_BINARY_DIR}/ice_gen)

add_ice_library(hello ${CMAKE_CURRENT_SOURCE_DIR}/example/ice ${IceBuildDir}/ice)
add_ice_library(hello2 ${CMAKE_CURRENT_SOURCE_DIR}/example/ice2 ${IceBuildDir}/ice2)
add_dependencies(hello2 hello)
add_library(${PROJECT_NAME} STATIC test.cpp)
target_link_libraries(${PROJECT_NAME} PUBLIC hello hello2)