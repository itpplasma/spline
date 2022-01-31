### Basic settings
cmake_minimum_required (VERSION 2.8.12)

### Define the project
project (spline)
enable_language(Fortran)
set(PROJECT_EXE_NAME "spline_test")

### Set compiler flags
#set(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/OBJS)
#set(CMAKE_Fortran_FLAGS "-O3") #GNU
#set(CMAKE_Fortran_FLAGS "-mkl -O3") #INTEL

### Define library
add_library(spline SHARED
  spline.f90
)

### Define executable
add_executable(${PROJECT_EXE_NAME}
  spline_test.f90
)

find_package(BLAS)
find_package(LAPACK)

target_link_libraries(
  spline
  ${BLAS_LIBRARIES} ${LAPACK_LIBRARIES}
  pthread
 )

target_link_libraries(
  ${PROJECT_EXE_NAME}
  spline
)
