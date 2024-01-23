
# ngrc

<img src="https://miro.medium.com/v2/resize:fit:1400/format:webp/0*SntSbK0oO5dhuF4F.png" alt="Any Angular version" title="Any Angular version" width="450"/>



Bash script 

# ngcr.sh 

# Version 0.0.6

==================================================================================================

240114-31 (c) Copyright Panos Zafiropoulos <www.devxperiences.com>

License: [MIT](https://mit-license.org/)

--------------------------------------------------------------------------------------------------

## Description:
Creates a new Angular project of any Angular version you like. 
Note: by default it uses the following parameters: --commit=false --style=scss --routing. However, you can change them (or add new) in the script.

*** The sed syntax follows the macOS sed (BSD). For Linux, you might use different syntax, e.g.: you should remove the '' after the -i parameter ***

## Prerequisites:
1. nvm should have been installed at the ~/.nvm folder.
2. At least a Node.js version should have been set via nvm and this version should be compatible with the Angular version that will be used to create the project.

## Parameters:

   -d | --directory	
   The project folder and project name. It should not be empty. If the name of the current folder has the same name, then the script creates the project in the current folder. If a direct sub-folder with the same name exists, then asks for overwriting for proceeding. e.g.: -d=myproject1
   
   -a | --angular
   The Angular CLI version that will be used to create the project. It should not be empty. It should be an existing and valid Angular CLI version. -a=16.2.11
   
   -n | --node
   The Node.js version. This should be one of the versions already installed via nvm, and it should be also, compatible with the Angular version selected. e.g.: -n=18.10.0

   -m | --material  
   If the @angular/material library is going to be installed, or not. It recognizes 'true' or 'yes' as values that cause the #angular/material to be added in the project e.g.:-m=true. The default value is false.  

   -t | --theme   
   If the @angular/material library is going to be installed, then you can select one of the 3 default themes for Angular Material. -t=1 for indigo-pink (default), -t=2 for deeppurple-amber, -t=3 for pink-bluegrey
#

   -o | --othermodules   
   If other modules are going to be installed, or not. It recognizes 'true' or 'yes' as values that cause the other modules to be added in the project e.g.:-o=true. The default value is false.


## Usage examples:
ngcr.sh -d=myproject1 -a=16.2.11 -n=18.10.0

ngcr.sh -d=myproject1 -a=16.2.11 -n=18.10.0 -m=yes

ngcr.sh -d=angular1 -a=16.2.11 -n=18.10.0 -m=trUE -o=yEs

## Usage Notes:

For related information check Authors posts at:

https://medium.com/@zzpzaf.se/angular-create-a-project-with-any-angular-version-you-like-c9108419835c

https://medium.com/@zzpzaf.se/node-js-version-adventures-using-nvm-974f81b4cc08

After you download the script, you should make it executable, e.g.:

chmod +x ngcr.sh

Alternatively, you can also run it as a command:

- Copy the file to the system folder (which is included in your $PATH): e.
- Give execution permissions: e.g chmod u+x ngcr.sh
- Additionally, you can remove the .sh extension or use a name alias

## Change log:

Version 0.0.6 (240123) Updates/Changes 

Capability for selecting one of the 3 default themes for Angular Material has been added
This is done via the new -t parameter. e.g.: -t=1 for indigo-pink (default), -t=2 for deeppurple-amber, -t=3 for pink-bluegrey
MatToolbarModule has been added to Material Components  

---

 Version 0.0.5 (240121) Updates/Changes 

 Capability for adding additonal modules for app.module.ts and material.module.ts are added
 Other app modules will be installed into the app.module.ts file, if the -o=true parameter is set
 Material modules will be installed into the material.module.ts file, if the -m=true parameter is set
 Other fixes

---

 Version 0.0.4 (240118) Updates/Changes

 A new component named "home" added to the app.module.ts (without a test file)

---

 Version 0.0.3 (240115) Updates/Changes

 Conditional installation of @angular/material with preselected installation parameters
 A separate module -the material.module.ts- is created in the src/app/ subfolder

 **************************************************************************************************
