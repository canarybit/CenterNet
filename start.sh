#!/bin/bash

# Display CUDA compiler version
nvcc -V

# Display NVIDIA GPU information
nvidia-smi

python3 src/lib/models/networks/DCNv2/setup.py build develop
python3 src/demo.py ctdet --demo images --load_model models/ctdet_coco_dla_2x.pth
