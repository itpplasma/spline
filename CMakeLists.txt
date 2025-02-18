### Basic settings
cmake_minimum_required (VERSION 3.10)

### Define the project
project (spline)
enable_language(Fortran)
set(PROJECT_EXE_NAME "spline_test")

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
