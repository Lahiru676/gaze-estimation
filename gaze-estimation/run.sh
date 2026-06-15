#!/bin/bash
# Allow container to access the host display
xhost +local:docker

docker run --rm -it \
  --runtime nvidia \
  --network host \
  --device /dev/video0 \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $(pwd)/weights:/app/weights \
  gaze-estimation \
  python3 inference.py --model resnet18 --weight weights/resnet18.pt --view --source 0
