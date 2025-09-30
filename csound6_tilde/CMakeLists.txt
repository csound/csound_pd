cmake_minimum_required(VERSION 3.5)

# coerce CMake to use the cc command directly
if(APPLE)
 set(CMAKE_C_COMPILER "cc")
 set(CMAKE_CXX_COMPILER "c++")
endif()

project(csound6_tilde)

# coerce CMake not to set isysroot
set(CMAKE_OSX_SYSROOT "")
set(CMAKE_MACOSX_RPATH 1)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules/")


if(APPLE)
  set(pdext ".pd_darwin")
elseif(WIN32)
  set(pdext ".dll")
else()
  set(pdext ".pd_linux")
endif()

set (PD_EXTENSION "${pdext}" CACHE STRING "the external extension (.pd_linux, .linux-amd64-64.so)")
set (PD_FLOATSIZE 32 CACHE STRING "the floatsize of Pd (32 or 64)")

if(PD_FLOATSIZE STREQUAL 64)
  add_definitions(-DPD_FLOATSIZE=64)
  # TODO check if the extension matches ".*-*-64.*"
  if(NOT PD_EXTENSION MATCHES "^\.[^.]*-[^.]*-64\.[^.]*$")
    message(FATAL_ERROR " double-precision externals must have an extension like '.linux-amd64-64.so'")
  endif()
elseif(PD_FLOATSIZE STREQUAL 32)
else()
  message(FATAL "FLOATSIZE must be 32 or 64")
endif()

find_path(PD_HEADER_PATH m_pd.h HINTS ${CMAKE_SOURCE_DIR}/src)
find_library(PD_LIBRARY pd.dll)
find_package(CSOUND)

if(PD_HEADER_PATH)
    if(WIN32)
      set(pdname "csound6_tilde${PD_EXTENSION}")
      set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_WIN32 -D__x86_64__")
    else()
       set(pdname "csound6~${PD_EXTENSION}")
    endif()
    add_library(pdcsound MODULE src/csoundapi_tilde.c)
    target_include_directories(pdcsound PRIVATE
    ${CSOUND_INCLUDE_DIRS} ${PD_HEADER_PATH})
    if(WIN32)
        target_link_libraries (pdcsound ${CSOUND_LIBRARY} ${PD_LIBRARY})
        set_target_properties(pdcsound  PROPERTIES "LINK_FLAGS"  "-Wl,--allow-multiple-definition")
    else()
        target_link_libraries (pdcsound ${CSOUND_LIBRARY})
    endif()
    set_target_properties(pdcsound PROPERTIES  PREFIX "")
    set_target_properties(pdcsound PROPERTIES  SUFFIX "")
    set_target_properties(pdcsound PROPERTIES  OUTPUT_NAME ${pdname})
    if(APPLE)
        set_target_properties(pdcsound  PROPERTIES "LINK_FLAGS"
            "-flat_namespace -undefined suppress")
    endif(APPLE)
else()
   MESSAGE(FATAL_ERROR "Pd header not found")
endif()
    

