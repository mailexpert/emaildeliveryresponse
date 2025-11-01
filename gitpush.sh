#!/bin/bash

VERSION_FILE="version.txt"

# Check if version.txt exists
if [[ ! -f $VERSION_FILE ]]; then
    echo "version.txt not found!"
    exit 1
fi

# Read the current version number
current_version=$(cat "$VERSION_FILE")

# Validate that it's an integer
if ! [[ "$current_version" =~ ^[0-9]+$ ]]; then
    echo "Invalid version number in $VERSION_FILE: $current_version"
    exit 1
fi

# Increment version
new_version=$((current_version + 1))

# Save new version to file
echo "$new_version" > "$VERSION_FILE"
echo "Version updated: $current_version -> $new_version"

# Optionally, commit the version update
#git add "$VERSION_FILE"
git add *
git commit -a -m "Updated with version $new_version"

# Push changes to git
git push

