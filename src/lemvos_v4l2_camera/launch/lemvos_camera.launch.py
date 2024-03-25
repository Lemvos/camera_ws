import argparse
import os
import sys

from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    ld = LaunchDescription()

    config_directory = os.path.join(
        get_package_share_directory('lemvos_v4l2_camera'),
        'config')
    params = os.path.join(config_directory, 'config.yaml')
    ld.add_action(
        Node(
            package='v4l2_camera',
            executable='v4l2_camera_node',
            output='screen',
            name='camera_node',
            parameters=[
                params,
                {
                    #'ffmpeg_image_transport.encoding': 'h264_vaapi',
                    # 'ffmpeg_image_transport.encoding': 'libx264',
                    # 'ffmpeg_image_transport.encoding': 'hevc_nvenc',
                    'ffmpeg_image_transport.profile': 'main',
                    'ffmpeg_image_transport.preset': 'ultrafast',
                    'ffmpeg_image_transport.gop': 15,
                },
            ],
        )
    )

    return ld
