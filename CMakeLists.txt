cmake_minimum_required(VERSION 2.8.12)
set(CMAKE_MACOSX_RPATH 1)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

find_package(Csound)
find_path(PD_HEADER_PATH m_pd.h)
find_library(PD_LIBRARY pd.dll)

if(PD_HEADER_PATH)
    if(LINUX)
        set(pdname "csound6~.pd_linux")
    elseif(APPLE)
        set(pdname "csound6~.pd_darwin")
    elseif(WIN32)
        set(pdname "csound6~.dll")
    endif()
    add_library(pdcsound MODULE src/csoundapi_tilde.c)
    target_include_directories(pdcsound PRIVATE
    ${CSOUND_INCLUDE_DIRS} ${PD_HEADER_PATH})
    if(WIN32)
        target_link_libraries (pdcsound ${CSOUND_LIBRARY} ${PD_LIBRARY})
        set_target_properties(pdcsound  PROPERTIES "LINK_FLAGS"
            "-Wl,--allow-multiple-definition")
    else()
        target_link_libraries (pdcsound ${CSOUND_LIBRARY})
    endif()
    set_target_properties(pdcsound PROPERTIES
        PREFIX ""
        SUFFIX ""
        OUTPUT_NAME ${pdname})
    if(APPLE)
        set_target_properties(pdcsound  PROPERTIES "LINK_FLAGS"
            "-flat_namespace -undefined suppress")
    endif(APPLE)
    install(TARGETS pdcsound
        LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
endif()

