cmake_minimum_required(VERSION 3.5)
project(csound_pd)

option(BUILD_FOR_CSOUND7 "build csound_pd for Csound7 (rather than Csound6)")

if(BUILD_FOR_CSOUND7)
add_subdirectory(csound7_tilde)
else()
add_subdirectory(csound6_tilde)
endif()
