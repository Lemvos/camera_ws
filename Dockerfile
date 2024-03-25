# Use ROS Noetic base image
FROM ros:humble

# Install pip and other dependencies for building ROS packages
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential

ENV VIDEO_DEVICE=/dev/video0
# Install required Python packages
#RUN pip3 install adafruit-circuitpython-bno08x

# Install required dependencies for ROS packages
RUN apt-get install -y ros-humble-v4l2-camera

# Create a catkin workspace
RUN mkdir -p /workspace

COPY ./src /workspace/src

WORKDIR /workspace

# Install dependencies with rosdep
RUN rosdep install --from-paths src --ignore-src -r -y

# Build the ROS packages
RUN /bin/bash -c '. /opt/ros/humble/setup.bash; colcon build'

# Copy the startup script into the container
COPY scripts /workspace/scripts/

# Make sure the script is executable
RUN chmod +x /workspace/scripts/*.sh

# Set the startup script to run when the container starts
ENTRYPOINT ["/workspace/scripts/startup.sh"]
