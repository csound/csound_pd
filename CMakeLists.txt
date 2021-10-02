cmake_minimum_required(VERSION 3.5)

# coerce CMake to use the cc command directly
if(APPLE)
 set(CMAKE_C_COMPILER "/usr/bin/cc")
 set(CMAKE_CXX_COMPILER "/usr/bin/c++")
endif()

project(csound6_tilde)

# coerce CMake not to set isysroot
set(CMAKE_OSX_SYSROOT "")
set(CMAKE_MACOSX_RPATH 1)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

find_path(PD_HEADER_PATH m_pd.h)
find_library(PD_LIBRARY pd.dll)
find_package(CSOUND)

if(PD_HEADER_PATH)
    if(APPLE) 
        set(pdname "csound6~.pd_darwin")
    elseif(WIN32)
      set(pdname "csound6_tilde.dll")
      set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_WIN32 -D__x86_64__")
    else()
       set(pdname "csound6~.pd_linux")
    endif()
    add_library(pdcsound MODULE src/csoundapi_tilde.c)
    target_include_directories(pdcsound PRIVATE
    ${CSOUND_INCLUDE_DIRS} ${PD_HEADER_PATH})
    if(WIN32)
        target_link_libraries (pdcsound ${CSOUND_LIBRARY}
    ${PD_LIBRARY})
        set_target_properties(pdcsound  PROPERTIES "LINK_FLAGS"
            "-Wl,--allow-multiple-definition")
    else()
        target_link_libraries (pdcsound ${CSOUND_LIBRARY})
    endif()
    set_target_properties(pdcsound PROPERTIES  PREFIX "")
    set_target_properties(pdcsound PROPERTIES  SUFFIX "")
    set_target_properties(pdcsound PROPERTIES  OUTPUT_NAME ${pdname})
    if(APPLE)
        set_target_properties(pdcsound  PROPERTIES "LINK_FLAGS"
            "-flat_namespace -undefined suppress -F/Library/Frameworks")
       set_target_properties(pdcsound  PROPERTIES "COMPILE_FLAGS"
            "-F /Library/Frameworks")
    endif(APPLE)
else()
   MESSAGE(FATAL_ERROR "Pd header not found")
endif()
    

