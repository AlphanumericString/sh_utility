#!/bin/bash

proj_name=$(pwd | rev | cut -d'/' -f1 | rev)

echo "Creating a new C/CPP project: $proj_name"

# Create a new repository if .git doesn't exist
if [ ! -d .git ]; then
	git init
	remote=$1
	if [ -z $remote ]; then
		read -p "Enter the remote repository URL: " remote
	fi
	if [ -z $remote ]; then
		echo "No remote repository URL provided, skipping..."
	else
		git remote add origin $remote
	fi
fi

echo "Creating the default structure..."
# Create directories for src include and test
mkdir src include test lib

# Create a README.md file if it doesn't exist
if [ ! -f README.md ]; then
	# Get the current directory and write it to the README.md file
	echo "#" $proj_name > README.md
	echo "by : " $(whoami) >> README.md
fi

# Create a .gitignore file if it doesn't exist

if [ ! -f .gitignore ]; then
	touch .gitignore
	# Write the following to the .gitignore file
	echo $proj_name >> .gitignore
	echo "build/" >> .gitignore
	echo "*.o" >> .gitignore
	echo "*.out" >> .gitignore
	echo "*.exe" >> .gitignore
	echo "*.a" >> .gitignore
	echo "*.so" >> .gitignore
fi

# copy the Makefile from the template directory

cp ~/Templates/Makefile .
