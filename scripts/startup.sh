#!/bin/bash

DIR_PATH=/workspace

# Source the ROS setup script
source /opt/ros/humble/setup.bash
source "${DIR_PATH}/install/setup.bash"

echo "Launching camera driver..."
echo "Video device: $VIDEO_DEVICE"
ros2 launch lemvos_v4l2_camera lemvos_camera.launch.py video_device:=$VIDEO_DEVICE &

echo "All nodes launched successfully."

# Trap Ctrl+C (SIGINT) and kill all background processes
trap "echo 'Stopping all nodes'; kill $!; exit 1" SIGINT

# Wait for all background processes to finish
wait
