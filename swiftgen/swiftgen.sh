#!/bin/sh
project_folder="$1"
if [ "$1" != "" ]; then
    echo "Files project folder: $project_folder"
else
    echo "Project name not provided stopped process"
    exit 1
fi
​
mkdir -p "$project_folder/Resources/SwiftGen"
​
swiftgen storyboards "$project_folder" --output "$project_folder/Resources/SwiftGen/Storyboards.swift"
swiftgen images "$project_folder" --output "$project_folder/Resources/SwiftGen/Images.swift"
swiftgen colors "$project_folder/Resources/Colors.txt" --output "$project_folder/Resources/SwiftGen/Colors.swift"
swiftgen strings "$project_folder/Resources/en.lproj/Localizable.strings" --output "$project_folder/Resources/SwiftGen/Strings.swift"
