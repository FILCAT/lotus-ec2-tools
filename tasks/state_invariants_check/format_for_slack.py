import sys
import json

#only read first 60k bytes to fit in slack
def read_file(filename):
    with open(filename, 'r') as file:
        return file.read()[:1600]

def generate_json(file_content):
    json_data = {
        "text": "```\n" + file_content + "\n```\n"
    }
    return json_data

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 program.py <filename>")
        return

    filename = sys.argv[1]
    file_content = read_file(filename)
    json_data = generate_json(file_content)
    json_str = json.dumps(json_data)
    print(json_str)

if __name__ == '__main__':
    main()

