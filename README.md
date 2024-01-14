
# ngrc

Bash script filename: ngcr.sh - version 0.0.2
==================================================================================================
240114-31 (c) Copyright Panos Zafiropoulos <www.devxperiences.com>
--------------------------------------------------------------------------------------------------

## Description:
Creates a new Angular project of any Angular version you like. 
Note: by default it uses the following parameters: --commit=false --style=scss --routing. However, you can change them (or add new) in the script.

## Prerequisites:
1. nvm should have been installed at the ~/.nvm folder.
2. At least a Node.js version should have been set via nvm and this version should be compatible with the Angular version that will be used to create the project.

## Parameters:

   -d | --directory	
   The project folder and project name. It should not be empty. If the name of the current folder has the same name, then the script creates the project in the current folder. If a direct sub-folder with the same name exists, then asks for overwriting for proceeding.
   
   -a | --angular
   The Angular CLI version that will be used to create the project. It should not be empty. It should be an existing and valid Angular CLI version
   
   -n | --node
   The Node.js version. This should be one of the versions already installed via nvm, and it should be also, compatible with the Angular version selected.

## Usage example:
ngcr.sh -d=ngtest -a=16.2.11 -n=18.10.0


---

For related information check Authors posts at:

https://medium.com/@zzpzaf.se/angular-create-a-project-with-any-angular-version-you-like-c9108419835c

https://medium.com/@zzpzaf.se/node-js-version-adventures-using-nvm-974f81b4cc08
