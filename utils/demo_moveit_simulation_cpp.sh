#!/bin/bash

# FRI send period: 10 ms
# IP address: your configuration
# FRI control mode: POSITION_CONTROL
# FRI client command mode: POSITION

byobu new-session -d -s demo_moveit_simulation_cpp
byobu select-pane -t 0
byobu split-window -v
byobu select-pane -t 0
byobu split-window -h
byobu select-pane -t 2
byobu split-window -h
byobu select-pane -t 3

byobu send-keys -t 0 'xhost + && docker exec -it iiwa_ros2_container bash -it -c "cp --force /yaml/lbr_system_config_moveit.yaml /root/ros2_ws/src/lbr-stack/src/lbr_fri_ros2_stack/lbr_description/ros2_control/lbr_system_config.yaml"' 'C-m'
sleep 1.
byobu send-keys -t 1 'xhost + && docker exec -it iiwa_ros2_container bash -it -c "cp --force /yaml/lbr_controllers_moveit.yaml /root/ros2_ws/src/lbr-stack/src/lbr_fri_ros2_stack/lbr_description/ros2_control/lbr_controllers.yaml"' 'C-m'
sleep 1.
byobu send-keys -t 0 'xhost + && docker exec -it iiwa_ros2_container bash -it -c "ros2 launch lbr_bringup mock.launch.py moveit:=true model:=iiwa14"' 'C-m'
sleep 2.
byobu send-keys -t 1 'xhost + && docker exec -it iiwa_ros2_container bash -it -c "ros2 launch lbr_bringup move_group.launch.py mode:=mock rviz:=true model:=iiwa14"' 'C-m'
sleep 2.
byobu send-keys -t 2 'xhost + && docker exec -it iiwa_ros2_container bash -it -c "ros2 launch lbr_moveit_cpp hello_moveit.launch.py mode:=mock model:=iiwa14"' 'C-m'

byobu attach -t demo_moveit_simulation_cpp