project(IceInterface VERSION 1.0)
if (WIN32)
    if(DEFINED ENV{ICE_PATH})
        set (Ice_HOME $ENV{ICE_PATH})
    endif()
endif (WIN32)

find_package(Ice QUIET COMPONENTS Ice )

function(normalize_path in_path out_path)
  string(REPLACE "\\" "/" out_var ${in_path})
  set (${out_path} ${out_var} PARENT_SCOPE)
endfunction()

function(get_file_name in_filename out)
  string(LENGTH ${in_filename} str_size)
  string(FIND ${in_filename} "/" pos REVERSE)
  math(EXPR pos "${pos} + 1")
  math(EXPR usefull_size "${str_size}-${pos}" )
  string(SUBSTRING ${in_filename} ${pos} ${usefull_size} out_var)
  set (${out} ${out_var} PARENT_SCOPE)
endfunction()


#[=====================================[
  add_ice_library
  ---------
  generate cpp files from folder `ice_interface_dir` to `ice_build_dir`
  create custom target `gen_ice` for regenerating cpp

  set option `icegen_BUILD_SHARED_LIBS ` for build shared or static
#]=====================================]
function(add_ice_library target ice_interface_dir ice_build_dir )

  file(GLOB ICE_FILES ${ice_interface_dir}/*.ice)
  file(MAKE_DIRECTORY  ${ice_build_dir})
  foreach(ice_file ${ICE_FILES})
    normalize_path(${ice_file} ice_file_normal_path)
    string(REGEX REPLACE "(ice)$" "h" ice_header ${ice_file_normal_path})
    string(REGEX REPLACE "(ice)$" "cpp" ice_source ${ice_file_normal_path})
    
    get_file_name(${ice_source} ice_src)
    get_file_name(${ice_header} ice_hdr)
    get_file_name(${ice_file_normal_path} ice_name)

    message( "${ice_file} => ${ice_src} ${ice_hdr}")
    list(APPEND ice_cpp "${ice_build_dir}/${ice_src}")
    list(APPEND ice_head "${ice_build_dir}/${ice_hdr}")
    list(APPEND ice_files ${ice_name})
    list(APPEND ice_cpp_names ${ice_src} )
    
    endforeach()
  string( REPLACE ";" " " ice_cpp_names "${ice_cpp_names}" )

  add_custom_command(
    OUTPUT ${ice_cpp} ${ice_head}
    DEPENDS ${ICE_FILES}
    COMMAND ${Ice_SLICE2CPP_EXECUTABLE} ${ICE_FILES} --output-dir ${ice_build_dir}
    COMMENT "START GENERATE CPP from \"${ice_files}\"" 
  )

  if (icegen_BUILD_SHARED_LIBS)
    set(icegen_SHARED_OR_STATIC "SHARED")
  else (icegen_BUILD_SHARED_LIBS)
    set(icegen_SHARED_OR_STATIC "STATIC")
  endif(icegen_BUILD_SHARED_LIBS)

  add_library(${target} ${icegen_SHARED_OR_STATIC} ${ice_cpp} ${ice_head} )  
  # target_sources(${target} PRIVATE ${ICE_FILES})
  target_link_libraries(${target} PUBLIC ${Ice_LIBRARIES})
  target_include_directories(${target} PUBLIC ${Ice_INCLUDE_DIR})
  target_include_directories(${target} PUBLIC ${ice_build_dir})

endfunction()
