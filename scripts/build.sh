#!/bin/bash

IMAGE_NAME=orca_noetic
docker build -f Dockerfile -t "${IMAGE_NAME}" "${ROS_WS}"
