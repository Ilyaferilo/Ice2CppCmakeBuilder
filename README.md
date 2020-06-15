# Ice2CppCmakeBuilder

Generate cpp library from ice-files in `ice_interface_dir` to `ice_build_dir`

usage:
```cmake
cmake_minimum_required(VERSION 3.10)

project(IceInterface)

# build shared or static
set(icegen_BUILD_SHARED_LIBS ON)

include(iceGenerator.cmake)

# set ice gen folder
set(IceBuildDir ${CMAKE_CURRENT_BINARY_DIR}/ice_gen)

# generate ice2cpp
add_ice_library(hello ${CMAKE_CURRENT_SOURCE_DIR}/example/ice ${IceBuildDir}/ice)
add_ice_library(hello2 ${CMAKE_CURRENT_SOURCE_DIR}/example/ice2 ${IceBuildDir}/ice2)
add_dependencies(hello2 hello)
add_library(${PROJECT_NAME} STATIC test.cpp)
target_link_libraries(${PROJECT_NAME} PUBLIC hello hello2)
```

```cpp
#include "second_hello.h"
#include "hello2.h"
#include <Ice/Communicator.h>
#include <iostream>

int stub()
{
    HelloIce::Hello2Prx f;
    f->say2Hello(12);
    HelloIce::HelloSecondPrx s;
    s->sayHello(34);
    return 12 + 20 + 10;
}
```