cmake_minimum_required(VERSION 3.10)

project(IceInterface VERSION 1.0)
if (WIN32)
    set (Ice_HOME
    "C:/Program Files (x86)/ZeroC/Ice-3.6.5")
endif (WIN32)

find_package(Ice QUIET COMPONENTS Ice )

include(iceGenerator.cmake)

# set ice gen folder
set(IceBuildDir ${CMAKE_CURRENT_BINARY_DIR}/ice_gen)

build_ice(${CMAKE_CURRENT_SOURCE_DIR}/example/ice ${IceBuildDir})

file(GLOB SRC_FILES ${IceBuildDir}/*.cpp)

add_library(${PROJECT_NAME} SHARED ${SRC_FILES} )

target_link_libraries(${PROJECT_NAME} PUBLIC ${Ice_LIBRARIES})

target_include_directories(${PROJECT_NAME} PUBLIC ${Ice_INCLUDE_DIR})

target_include_directories(${PROJECT_NAME} PUBLIC ${IceBuildDir})
