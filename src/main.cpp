#include <iostream>

#include <cuda_runtime_api.h>

int main()
{
  auto gpu_count = int{};
  cudaGetDeviceCount(&gpu_count);
  std::cout << "GPU count: " << gpu_count << std::endl;
  
  return 0;
}