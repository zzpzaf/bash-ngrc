
# ngrc

<img src="https://miro.medium.com/v2/resize:fit:1400/format:webp/0*SntSbK0oO5dhuF4F.png" alt="Any Angular version" title="Any Angular version" width="450"/>



Bash script 

# ngcr.sh 

# Version 0.0.8

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

## Flags / Parameters:

-d  | --directory	      
The project folder and project name. It should not be empty. If the name of the current folder has the same name,    then the script creates the project in the current folder.  If a direct sub-folder with the same name exists, then asks for overwriting for proceeding. e.g.: -d=myproject1

-a  | --angular	        
The Angular CLI version that will be used to create the project. It should not be empty. It should be an existing and valid Angular CLI version. e.g.: -a=16.2.11 You can select a version number from the history list at: https://www.npmjs.com/package/@angular/cli?activeTab=versions

-n  | --node
The Node.js version. This should be one of the versions already installed via nvm, and it should be also, compatible with the Angular version selected. e.g.: -n=18.10.0. You can select a version number from the ones installed via nvm tool. List all of the installed versions via nvm, using the 'nvm list' command. See also at: https://nodejs.org/en/download/releases/. 

-m  | --material        
If the @angular/material library is going to be installed, or not. The flag takes the version to be installed, e.g. -m=15.2.9, -m=16.2.5, -m=17.1.0, etc. You can select a version number from the history list at: https://www.npmjs.com/package/@angular/material?activeTab=versions. Generally, the selected version should follow the Angular version (at least its major number).  The flag, also can be 'true' or 'yes' and in this case it installs the latest compatible version of the Angular Material. Without using the -m flag, or using it with any unrecognized value, the flag is set to false and the @angular/material will not be installed.

-t  | --theme 
If the @angular/material library is going to be installed, then you can select one of the 3 default themes for Angular Material. -t=1 for indigo-pink (default), -t=2 for deeppurple-amber, -t=3 for pink-bluegrey

-o  | --othermodules    
If other modules are going to be installed, or not. It recognizes 'true' or 'yes' as values that cause the other modules to be added in the project e.g.:-o=true. The default value is false.

-bf | --basicform       
If a basic form is going to be used within the form1 component, or not. e.g.:-bf=true or -bf=yEs. The default value is false. The @angular/material library should be installed with additional material modules, as well as the 'form1' component.




## Usage examples:

ngcr.sh -d=myproject1 -a=16.2.11 -n=18.10.0

ngcr.sh -d=myproject1 -a=16.2.11 -n=18.10.0 -m=yes

ngcr.sh -d=angular1 -a=16.2.11 -n=18.10.0 -m=trUE -o=yEs

ngcr.sh -d=myproject1 -a=16.2.11 -n=18.10.0 -m=trUE -o=yEs -t=2

ngcr.sh -d=demoform -a=16.2.11 -n=18.10.0 -m=trUE -o=yEs -t=2 -bf=yes

ngcr.sh -d=NGxDatetimepicker2 -a=15.2.10 -n=18.10.0 -m=15.2.9 -o=yEs -t=3 -bf=YEs

## Usage Notes:

For information related to installing an Angular version and NVM, check Author's posts at:

https://medium.com/@zzpzaf.se/angular-create-a-project-with-any-angular-version-you-like-c9108419835c

https://medium.com/@zzpzaf.se/node-js-version-adventures-using-nvm-974f81b4cc08

After you download the script, you should make it executable, e.g.:

chmod +x ngcr.sh

Alternatively, you can also run it as a command:

- Copy the file to the system folder (which is included in your $PATH): e.
- Give execution permissions: e.g chmod u+x ngcr.sh
- Additionally, you can remove the .sh extension or use a name alias

## Change log:

Version 0.0.8 (240124) Updates/Changes 

Capability for specifying the desired Angular Material version has been added via the -m flag. Now the version numbers provided as values for flags -a, -n and -m are also validated against the x.y.z pattern, where x,y,z shouls be valid integer decimal digits 

---

Version 0.0.7 (240123) Updates/Changes 

An optional parameter -bf has been added for creation of a basic/elemntary form. If it has been used e.g. -bf=true or -bf=yEs then very
basic form is created with 1 input field and 1 submit button 

---

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
