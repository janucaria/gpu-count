cmake_minimum_required(VERSION 3.10)
project(gpu-count)

find_package(CUDA REQUIRED)

add_compile_options(-Wall -Wpedantic -pedantic-errors)

add_executable(gpu-count
  src/main.cpp
)

target_include_directories(gpu-count
  PRIVATE
    ${CUDA_INCLUDE_DIRS}
)

target_link_libraries(gpu-count
  PRIVATE
    ${CUDA_LIBRARIES}
)

target_compile_features(gpu-count
  INTERFACE
    cxx_std_17
)
