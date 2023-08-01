#!/bin/bash

# Ask for task name
echo "Please enter task name: "
read task_name

# Create directory using task name from template
cp -r template "$task_name"

sed -i "s/TASKNAMESENTINEL/$task_name/g" "$task_name"/run.bash


# Notify the user
echo "Task '$task_name' created with two files: $(ls $task_name)"

