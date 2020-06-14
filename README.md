# IceCmakeBuilder

Auto generate cpp files from folder `ice_interface_dir` to `ice_build_dir` and
  create custom target `gen_ice` for regenerating cpp

usage:
```
include(iceGenerator.cmake)

# set ice gen folder
set(IceBuildDir ${CMAKE_CURRENT_BINARY_DIR}/ice_gen)
build_ice(${PATH_TO_YOUR_ICE_FILES} ${IceBuildDir})

# add generated sources into your lib
file(GLOB SRC_FILES ${IceBuildDir}/*.cpp)
add_library(${PROJECT_NAME} SHARED ${SRC_FILES} )

target_link_libraries(${PROJECT_NAME} PUBLIC ${Ice_LIBRARIES})
target_include_directories(${PROJECT_NAME} PUBLIC ${IceBuildDir} ${Ice_INCLUDE_DIR})
```
