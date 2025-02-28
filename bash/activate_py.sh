#!/bin/bash 
## 單純自己整黎，至少以後打字幾個codeT^T
# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: source activate.sh <venv_name>"
  exit 1
fi
venv_name="$1"
# Search for the virtual environment directory
venv_path=$(find . -name "$venv_name" -type d -print -quit)
# Check if the virtual environment was found
if [ -z "$venv_path" ]; then
  echo "Virtual environment '$venv_name' not found."
  exit 1
fi
# Construct the path to the activate script
activate_script="$venv_path/bin/activate"
echo "$activate_script"
source "$activate_script"
