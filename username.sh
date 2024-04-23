#!/bin/bash

# Old username placeholder
OLD_USERNAME="z3ji"

# Function to recursively replace OLD_USERNAME with provided username
replace_username() {
    local target_dir=$1
    local username=$2
    
    # Iterate through files and directories in the target directory
    for item in "$target_dir"/*; do
        local item_name=$(basename "$item")
        local new_item_name=$(echo "$item_name" | sed "s/$OLD_USERNAME/$username/g")
        
        if [ -d "$item" ]; then
            # If it's a directory, replace OLD_USERNAME in directory name
            local new_dir_name=$(echo "$item_name" | sed "s/$OLD_USERNAME/$username/g")
            if [ "$item_name" != "$new_dir_name" ]; then
                sudo mv "$item" "$(dirname "$item")/$new_dir_name"
            fi
            # Recursively call function for subdirectories
            replace_username "$(dirname "$item")/$new_dir_name" "$username"
        elif [ -f "$item" ]; then
            # If it's a file, replace OLD_USERNAME in file contents
            sudo sed -i "s/$OLD_USERNAME/$username/g" "$item"
        fi
    done
}

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo privileges."
    exit 1
fi

# Ask user for username input
read -p "Enter your username: " username

# Check if the username is provided
if [ -z "$username" ]; then
    echo "Username not provided."
    exit 1
fi

# Get the root directory
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Call the function to recursively replace OLD_USERNAME with provided username
replace_username "$root_dir" "$username"

echo "Username updated successfully."
