import os
import json
from datetime import datetime

import shutil

# Function to check if a string is valid JSON
def is_valid_json(data):
    try:
        json.loads(data)
        return True
    except ValueError:
        return False

# List all files in a folder
folder_path = "/mnt/data/lotus-ec2-tools/tasks/snapshot_state_summary/data"
file_dict = {}


def get_title(filename):
    # Extract the date and time portion from the filename
    datetime_string = filename.split('-')[1:]  # Extracts ['2023', '06', '30', '00', '02', '36.out']

    # Join the date and time portions and remove the file extension
    datetime_string = '-'.join(datetime_string).split('.')[0]  # Joins as '2023-06-30-00-02-36'

    # Parse the datetime string into a datetime object
    datetime_object = datetime.strptime(datetime_string, '%Y-%m-%d-%H-%M-%S')

    return str(datetime_object)


for file_name in os.listdir(folder_path):
    file_path = os.path.join(folder_path, file_name)
    if os.path.isfile(file_path):
        # Read the file as JSON
        with open(file_path, "r") as file:
            file_data = file.read()
            if is_valid_json(file_data):
                file_dict[get_title(file_name)] = json.loads(file_data)
            else:
                print(f"Warning: Invalid JSON format in file '{file_name}'. Skipping.")

# Construct the snapshotData dictionary
snapshot_data = {}
for file_name, json_data in file_dict.items():
    snapshot_data[file_name] = json_data

# Read the index.html.template file
template_path = "index.html.template"  # Replace with the actual template file path
with open(template_path, "r") as template_file:
    template_content = template_file.read()

# Replace the snapshotData placeholder with the constructed snapshotData dictionary
template_content = template_content.replace("/* JSON data for snapshot */", json.dumps(snapshot_data))

# Write the index.html file
output_path = "index.html"  # Replace with the desired output file path
with open(output_path, "w") as output_file:
    output_file.write(template_content)

# Optionally, move the index.html file to the desired location
# shutil.move(output_path, "path/to/output/location")  # Replace with the actual output location

