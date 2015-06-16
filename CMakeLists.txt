### Basic settings
cmake_minimum_required (VERSION 2.6)

### Define the project
project (spline)
enable_language(Fortran)

### Set compiler flags
set(CMAKE_Fortran_MODULE_DIRECTORY ./OBJS)

### Define executable
add_library(spline
  spline.f90
)
