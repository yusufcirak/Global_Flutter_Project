# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(serialport_library VERSION 0.0.1 LANGUAGES C)

add_library(serialport SHARED
  "SerialPort.c"
)

set_target_properties(serialport PROPERTIES
  PUBLIC_HEADER SerialPort.h
  OUTPUT_NAME "serialport"
)

target_compile_definitions(serialport PUBLIC DART_SHARED_LIB)
