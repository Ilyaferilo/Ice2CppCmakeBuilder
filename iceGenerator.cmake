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
  build_ice
  ---------
  generate cpp files from folder `ice_interface_dir` to `ice_build_dir`
  create custom target `gen_ice` for regenerating cpp
#]=====================================]
function(build_ice ice_interface_dir ice_build_dir )
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
    list(APPEND ice_files ${ice_name})
    list(APPEND ice_cpp_names ${ice_src} )
    exec_program(${Ice_SLICE2CPP_EXECUTABLE}
    ARGS ${ICE_FILES} --output-dir ${ice_build_dir})
    
    endforeach()

    string( REPLACE ";" " " ice_cpp "${ice_cpp}" )
    string( REPLACE ";" " " ice_files "${ice_files}" )
    string( REPLACE ";" " " ice_cpp_names "${ice_cpp_names}" )

    add_custom_target(gen_ice 
    COMMAND ${Ice_SLICE2CPP_EXECUTABLE} ${ICE_FILES} --output-dir ${ice_build_dir}
    DEPENDS ${Ice_SLICE2CPP_EXECUTABLE} 
    COMMENT "START GENERATE ICE from ${ice_interface_dir} ${ice_files}" 
    BYPRODUCTS ${ice_cpp}
    )
endfunction()
