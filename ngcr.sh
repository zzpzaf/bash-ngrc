#!/bin/bash

# **************************************************************************************************
# Bash script filename: ngcr.sh - version 0.0.3
# ==================================================================================================
# 240114-31 (c) Copyright Panos Zafiropoulos <www.devxperiences.com>
# --------------------------------------------------------------------------------------------------
#
# Description:
# Creates a new Angular project of any Angular version you like. 
# Note: by default it uses the following parameters: --commit=false --style=scss --routing. However, you can change them (or add new) in the script.
#
# Prerequisites:
# 1. nvm should have been installed at the ~/.nvm folder.
# 2. At least a Node.js version should have been set via nvm and this version should be compatible with the Angular version that will be used to create the project.
#
# Parameters:
#   -d | --directory	The project folder and project name. It should not be empty. If the name of the current folder has the same name, then the script creates the project in the current folder. If a direct sub-folder with the same name exists, then asks for overwriting for proceeding. e.g.: -d=myproject1
#   -a | --angular	  The Angular CLI version that will be used to create the project. It should not be empty. It should be an existing and valid Angular CLI version. e.g.: -a=16.2.11
#   -n | --node		    The Node.js version. This should be one of the versions already installed via nvm, and it should be also, compatible with the Angular version selected. e.g.: -n=18.10.0
#   -m | --material   If the @angular/material library is going to be installed, or not. It recognizes 'true' or 'yes' as values that cause the #angular/material to be added in the project e.g.:-m=true. The default value is false.  
#
# Usage example:
# ngcr.sh -d=myproject1 -a=16.2.11 -n=18.10.0 -m=yes
#
# After you download the script, you should make it executable, e.g.:
# chmod +x ngcr.sh
# Alternatively, you can also run it as a command:
# - Copy the file to the system folder (which is included in your $PATH): e.g /usr/local/bin
# - Give execution permissions: e.g chmod u+x npmts.sh
# - Additionally, you can remove the .sh extension or use a name alias
#
# For related information check Authors posts at:
# https://medium.com/@zzpzaf.se/angular-create-a-project-with-any-angular-version-you-like-c9108419835c
# https://medium.com/@zzpzaf.se/node-js-version-adventures-using-nvm-974f81b4cc08
#
# **************************************************************************************************


# Check if there are any arguments
if [ $# -eq 0 ]
  then
    echo "No arguments supplied!" 
    echo "Exiting..."
    exit 1
fi

# get input paramenters
for i in "$@"; do
  case $i in
    -d=*|--directory=*)
      PROJECT_FOLDER="${i#*=}"
      shift # past argument=value
      ;;
    -a=*|--angular=*)
      ANGCLI_VERSION="${i#*=}"
      shift # past argument=value
      ;;
    -n=*|--node=*)
      NODE_VERSION="${i#*=}"   # 
      shift # past argument=value
      ;;
    -m=*|--material=*)
      MATERIAL="${i#*=}"             #  <-------------
      shift # past argument=value
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done




# Check if the required parameters are set

if [ -z "$PROJECT_FOLDER" ]; then
  echo "PROJECT FOLDER is empty. Please specify a folder name!"
  echo "Exiting..."
  exit 1
fi

if [ -z "$ANGCLI_VERSION" ]; then
  echo "Angular CLI versuin is empty. Please specify a varsuin, e.g.: 16.2.11"
  echo "Exiting..."
  exit 1
fi

if [ -z "$NODE_VERSION" ]; then
  echo "Node version is empty. Please specify thw Node.js version installed via nvm, e.g.: 18.10.0"
  echo "Exiting..."
  exit 1
fi

MAT=$(echo $MATERIAL | tr '[:upper:]' '[:lower:]' ) 
if [ $MAT == "true" ] || [ $MAT == "yes" ]; then
  MATERIAL=true
fi


# Output the parameters
echo "PROJECT FOLDER:      ${PROJECT_FOLDER}"
echo "ANGULAR CLI VERSION: ${ANGCLI_VERSION}"
echo "NODE VERSION:        ${NODE_VERSION}"


CPATH="$(pwd)"
echo "Current path: $CPATH"
CWD=${PWD##*/}
echo "Current working directory: $CWD"



# Check if we are already inside the specified folder
if [ "$CWD" != "$PROJECT_FOLDER" ]; then
  #echo "Current working directory is not the same as the -d parameter"

  # Check if the specified folder exists 
  if [ -d "$PROJECT_FOLDER" ]; then
    read -p "Subdirectory $PROJECT_FOLDER exists. Do you wish to proceed with overwriting it? [Y/n] " yn
    # read -p answer
    if [ "$yn" != "${yn#[Yy]}" ] ;then
      #echo "Overwriting $PROJECT_FOLDER"
      rm -rf $PROJECT_FOLDER
    else
      echo "Exiting..."
      exit 1
    fi
  fi

  mkdir $PROJECT_FOLDER
  cd $PROJECT_FOLDER

fi



# source the nvm.sh file
. ~/.nvm/nvm.sh

# Check if the specified Node version is already installed
if ! nvm list | grep -q ${NODE_VERSION} ; then
  echo $NODE_VERSION " doesn't exist in nvm list. Please specify an nvm-installed Node version!"
  echo "Exiting..."
  exit 1
fi

# Create a new.nvmrc file in that folder with the selected Node.jes version 
echo $NODE_VERSION > .nvmrc
nvm use

# Install Angular CLI and create th e project
echo ">===>> Installing Angular CLI and creating the project..."
npx @angular/cli@$ANGCLI_VERSION new $PROJECT_FOLDER --directory=./ --commit=false --style=scss --routing


# Install Angular Material
if [ $MATERIAL == "true" ]; then
  echo ">===>> Addng Angular Material..."
  npx ng add @angular/material --theme=indigo-pink --/typography=true --browserAnimations=true --interactive=false --skip-confirmation
fi
# npx ng add @angular/material --theme=indigo-pink --/typography=true --browserAnimations=true --interactive=false --skip-confirmation


 

