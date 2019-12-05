# Getting Started

## Clone repository dan masuk dalam project folder
```bash
git clone https://github.com/janucaria/gpu-count.git
cd gpu-count
```

## Build docker image tergatung dari versi cuda

### cuda 10.0

```
docker build -t janucaria/gpu-count -f cuda-10-0.dockerfile .
```
### cuda 10.1

```
docker build -t janucaria/gpu-count -f cuda-10-1.dockerfile .
```

### cuda 10.2
```
docker build -t janucaria/gpu-count -f cuda-10-2.dockerfile .
```

## Run container docker dengan GPU enabled
```
docker run --rm --gpus all -it janucaria/gpu-count bash -c "nvidia-smi; gpu-count"
```

jika gagal bisa ganti `--gpus all` menjadi `--runtime nvidia`
```
docker run --rm --runtime nvidia -it janucaria/gpu-count bash -c "nvidia-smi; gpu-count"
```
## Output
Expected output similar like this

```bash
Thu Dec  5 06:11:50 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 435.21       Driver Version: 435.21       CUDA Version: 10.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 106...  Off  | 00000000:01:00.0  On |                  N/A |
| N/A   56C    P2    22W /  N/A |   1274MiB /  6078MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
GPU count: 0
```
