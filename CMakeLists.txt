### Basic settings
cmake_minimum_required (VERSION 2.6)

### Define the project
project (spline)
enable_language(Fortran)
set(PROJECT_EXE_NAME "spline_test")

### Set compiler flags
set(CMAKE_Fortran_MODULE_DIRECTORY ./OBJS)
set(CMAKE_Fortran_FLAGS "-mkl -O3")

### Define library
add_library(spline
  spline.f90
)

### Define executable
add_executable(${PROJECT_EXE_NAME}
  spline_test.f90
)

target_link_libraries(
  ${PROJECT_EXE_NAME}
  spline
  #blas
  pthread
)
