#!/bin/bash

# **************************************************************************************************
# Bash script filename: ngcr.sh - version 0.0.7
# ==================================================================================================
# 240114-31 (c) Copyright Panos Zafiropoulos <www.devxperiences.com>
# License: MIT
# --------------------------------------------------------------------------------------------------
#
# **************************************************************************************************
# Description:
# ============
# Creates a new Angular project of any Angular version you like. 
# Note: by default it uses the following parameters: --commit=false --style=scss --routing. However, you can change them (or add new) in the script.
#
# *** The sed syntax follows the macOS sed (BSD). For Linux, you might use different syntax, e.g.: you should remove the '' after the -i parameter ***
#
# Prerequisites:
# ==============
# 1. nvm should have been installed at the ~/.nvm folder.
# 2. At least a Node.js version should have been set via nvm and this version should be compatible with the Angular version that will be used to create the project.
#
# Parameters:
# ===========
#   -d  | --directory	      The project folder and project name. It should not be empty. If the name of the current folder has the same name, then the script creates the project in the current folder. If a direct sub-folder with the same name exists, then asks for overwriting for proceeding. e.g.: -d=myproject1
#   -a  | --angular	        The Angular CLI version that will be used to create the project. It should not be empty. It should be an existing and valid Angular CLI version. e.g.: -a=16.2.11
#   -n  | --node		        The Node.js version. This should be one of the versions already installed via nvm, and it should be also, compatible with the Angular version selected. e.g.: -n=18.10.0
#   -m  | --material        If the @angular/material library is going to be installed, or not. It recognizes 'true' or 'yes' as values that cause the #angular/material to be added in the project e.g.:-m=true. The default value is false.  
#   -t  | --theme           If the @angular/material library is going to be installed, then you can select one of the 3 default themes for Angular Material. -t=1 for indigo-pink (default), -t=2 for deeppurple-amber, -t=3 for pink-bluegrey
#   -o  | --othermodules    If other modules are going to be installed, or not. It recognizes 'true' or 'yes' as values that cause the other modules to be added in the project e.g.:-o=true. The default value is false.
#   -bf | --basicform       If a basic form is going to be used within the form1 component, or not. e.g.:-bf=true or -bf=yEs. The default value is false. The @angular/material library should be installed with additional material modules, as well as the 'form1' component.
#
#
#
# Usage examples:
# ==============
# ngcr.sh -d=myproject1 -a=16.2.11 -n=18.10.0
# ngcr.sh -d=myproject1 -a=16.2.11 -n=18.10.0 -m=yes
# ngcr.sh -d=angular1 -a=16.2.11 -n=18.10.0 -m=trUE -o=yEs
# ngcr.sh -d=angular1 -a=16.2.11 -n=18.10.0 -m=trUE -o=yEs -t=2
# ngcr.sh -d=angular1 -a=16.2.11 -n=18.10.0 -m=trUE -o=yEs -t=2 -bf=yes
#
# Usage Notes:
# =================
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
#
# Change log:
#
# ================================================================================================
#
# Version 0.0.6 (240123) Updates/Changes 
# --------------------------------------------------------------------------------
# Capability for selecting one of the 3 default themes for Angular Material is added
# This is done via the new -t parameter. e.g.: -t=1 for indigo-pink (default), -t=2 for deeppurple-amber, -t=3 for pink-bluegrey
# MatToolbarModule has been added to Material Components  
#
# Version 0.0.5 (240121) Updates/Changes 
# --------------------------------------------------------------------------------
# Capability for adding additonal modules for app.module.ts and material.module.ts are added
# Other app modules will be installed into the app.module.ts file, if the -o=true parameter is set
# Material modules will be installed if the -m=true parameter is set
# 
# Version 0.0.4 (240118) Updates/Changes
# --------------------------------------------------------------------------------
# A new component named "home" added to the app.module.ts (without a test file)
#
# Version 0.0.3 (240115) Updates/Changes
# --------------------------------------------------------------------------------
# Conditional installation of @angular/material with preselected installation parameters
#
# **************************************************************************************************

# Define/add here the modules to be added into the app.module.ts file
# They will be added if the -o=true parameter is set
othmods=(
    "import { HttpClientModule } from '@angular/common/http';" 
    "import { ReactiveFormsModule } from '@angular/forms';"
)
# Define/add here the modules to be added into the material.module.ts file
# They will be added if the -m=true parameter is set
materialmods=(
    "import { MatToolbarModule } from '@angular/material/toolbar';"
    "import { MatIconModule } from '@angular/material/icon';"
    "import { MatCardModule } from '@angular/material/card';"
    "import { MatFormFieldModule } from '@angular/material/form-field';"
    "import { MatInputModule } from '@angular/material/input';"
    "import { MatButtonModule } from '@angular/material/button';"
)
# Define/add here the names of  additional components to be created
# They will be added in the app.module.ts file
# The form1 component should be present in the additionalcomponents: array, if the -bf=true parameter is set
additionalcomponents=(
    "home"
    "form1"
)


# Process the input parameters
# **************************************************************************************************************

#. <(clear)
$(clear>&2)



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
      MATERIAL="${i#*=}"           
      shift # past argument=value
      ;;
    -t=*|--theme=*)
      THEME="${i#*=}"             
      shift # past argument=value
      ;;
    -o=*|--othermodules=*)
      OTHER="${i#*=}"             
      shift # past argument=value
      ;;
    -bf=*|--basicform=*)
      BASICFORM="${i#*=}"             
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
# **************************************************************************************************************

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
# echo $MAT
if [ $MAT == "true" ] || [ $MAT == "yes" ]; then
  MATERIAL=true
fi

# 240121
OTH=$(echo $OTHER | tr '[:upper:]' '[:lower:]' ) 
# echo $OTH
if [ $OTH == "true" ] || [ $OTH == "yes" ]; then
  OTHER=true
fi

# 240123
if [[ $THEME =~ ^[1-3]$ ]]; then
  THEME=$THEME
  if [ $THEME == "1" ]; then
    THEME="indigo-pink"
  elif [ $THEME == "2" ]; then
    THEME="deeppurple-amber"
  else
    THEME="pink-bluegrey"
  fi
else
  THEME="indigo-pink"
fi

# 240123
if [ -z "$BASICFORM" ]; then 
  BASICFORM=false 
fi
BF=$(echo $BASICFORM | tr '[:upper:]' '[:lower:]' ) 
if [ $BF == "true" ] || [ $BF == "yes" ]; then
  BASICFORM=true
fi






# Output the parameters
echo "PROJECT FOLDER:      ${PROJECT_FOLDER}"
echo "ANGULAR CLI VERSION: ${ANGCLI_VERSION}"
echo "NODE VERSION:        ${NODE_VERSION}"


CPATH="$(pwd)"
echo "Current path: $CPATH"
CWD=${PWD##*/}
echo "Current working directory: $CWD"


# Selecting/creating the project folder
# **************************************************************************************************************

echo ">===>> Selecting/creating the project folder..."
# Check if we are already inside the specified folder
if [ "$CWD" != "$PROJECT_FOLDER" ]; then
  #echo "Current working directory is not the same as the -d parameter"

  # Check if the specified folder exists 
  if [ -d "$PROJECT_FOLDER" ]; then
    echo -n "Subdirectory $PROJECT_FOLDER exists. Do you wish to proceed with overwriting it? [Y/n] "
    read -s -n 1 yn
    # read -p answer
    if [[ $yn = "" ]] || [ "$yn" != "${yn#[Yy]}" ];then
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



# Selecting the Mode,js version via NVM
# **************************************************************************************************************
echo
echo ">===>> Selecting Node.js version via NVM..."
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

# Install Angular CLI and create the project
echo ">===>> Installing Angular CLI and creating the project..."
npx @angular/cli@$ANGCLI_VERSION new $PROJECT_FOLDER --directory=./ --commit=false --style=scss --routing




# **************************************************************************************************************
# Adding ANGULAR MATERIAL
# *** COMMEND-OUT THE FOLLOWING LINES IF YOU DON'T WANT TO INSTALL ANGULAR MATERIAL ***
# **************************************************************************************************************

# 240115 Install Angular Material
if [ $MATERIAL == "true" ]; then
  echo ">===>> Addng Angular Material..."
  #npx ng add @angular/material --theme=indigo-pink --/typography=true --browserAnimations=true --interactive=false --skip-confirmation
  # 240123 Add the selected theme
  npx ng add @angular/material --theme=$THEME --/typography=true --browserAnimations=true --interactive=false --skip-confirmation
  
  
  # 240118 Create/Use a separate (feature/widget) module file for Material components
  npx ng g m material --module=app --flat=true 
fi






# **************************************************************************************************************
# 240120-21 Adding additional modules e.g.: the app.module.ts and material.module.ts
# Other modules will be installed if the -o=true parameter is set
# Material modules will be installed if the -m=true parameter is set
# *** COMMEND-OUT THE FOLLOWING LINES IF YOU DON'T WANT TO ADD ADDITIONAL MODULES ***
# **************************************************************************************************************

# Define important variables for the rest of script - for module(s(s)) to be added
srcpath="src/app"                                 # Define the source path
app_mod_file_path="$srcpath/app.module.ts"        # Define the file path name (app.module.ts)
strA="imports:"                                   # Define the section for searching - start
strB="],"                                         # Define the section for searching - end
ch1="{"                                           # Define the 1st character (opening curly brace) for extracting the module from impoer statement
ch2="}"                                           # Define the 1st character (closing curly brace) for extracting the module from impoer statement
prefix=" "                                        # Define the prefix (space character) for the module name that should be removed
suffix=" "                                        # Define the suffix (space character) for the module name that should be removed
strC=","                                          # Define the comma-character that should be added after the last item in the imports: array

mat_mod_file_path="$srcpath/material.module.ts"    # Define the file path name (material.module.ts)
f="CommonModule"                                  # Define the initially only one and first item in the imports: array into material.modules.ts
strB1="]"                                         # Define the end string for initially search imports region into material.modules.ts
strB2="})"                                        # Define the end string for initially search @NgModule( region into material.modules.ts       
strA1="exports:"                                  # Define the exports start region to be added into material.modules.ts
expSect="$strA1 [\n\t]"                           # Define thewhole exports section to be added into material.modules.ts



# Function for adding other modules into the app.module.ts file
addOtherAppModules() {
    # **************************************************************************************************************
    # 240120 Additional modules for app.module.ts e.g.: HttpClient, ReactiveFormsModule, etc.to the app.module.ts
    # You can also add more modules here

    echo ">===>> Addng additional modules into app.module.ts ..."
    # Define the modules to be added
    # othmods=(
    #     "import { HttpClientModule } from '@angular/common/http';" 
    #     "import { ReactiveFormsModule } from '@angular/forms';"
    # )

    # First, add a comma after the last item in the othmods: array
    declare -i counter=0
    while read line
    do
        (( counter ++ ))
        # echo $counter $line
        if [[ "$line" == $strA* ]]
            then
            imp=true
        fi
        if [[ "$line" == *$strB ]]
            then
            if [ "$imp" = true ] 
                then
                lnr=$( expr $counter - 1)
                break
            fi
        fi
    done < $app_mod_file_path
    # echo "$strB is found at line number: $lnr"
    sed -i '' "$lnr s/$/$strC/" "$app_mod_file_path"


    #  Iterate through the modules to be added and add them to the othmods: array
    for othmod in "${othmods[@]}";
        do
        #The 2 lines command below is necessary for macOS (BSD) sed.
        sed -i '' -e "1i\\
        $othmod" "$app_mod_file_path"


        mod=$(echo $othmod | sed -n "s/.*$ch1 \(.*\)$ch2.*/\1/p")   
        mod=${mod#$prefix}; #Remove prefix
        mod=${mod%$suffix}; #Remove suffix
        # echo $mod

        sed -i ''  "/$strA/, /$strB/ s/$strB/\t$mod,\n$strB/" "$app_mod_file_path"
    done
    # cat $app_mod_file_path
}




# Function for adding Material modules into the material.module.ts file
addMaterialModules() {
    # **************************************************************************************************************
    # 240121 Additional modules for material.module.ts 
    # You can also add more modules here

    echo ">===>> Addng additional modules into material.module.ts ..."
    # materialmods=(
    #     "import { MatIconModule } from '@angular/material/icon';"
    #     "import { MatCardModule } from '@angular/material/card';"
    #     "import { MatFormFieldModule } from '@angular/material/form-field';"
    #     "import { MatInputModule } from '@angular/material/input';"
    #     "import { MatButtonModule } from '@angular/material/button';"
    # )

    # Add a comma to CommonModule
    sed -i '' "s/$f/$f$strC/" "$mat_mod_file_path"

    # Add a comma to to closing right brace of the materialmods: array
    sed -i ''  "/$strA/, /$strB2/ s/$strB1/$strB1$strC/" "$mat_mod_file_path"

    # Add the exports array section
    sed -i ''  "/$strA/, /$strB2/ s/$strB/$strB \n\t$expSect/" "$mat_mod_file_path"

    # Iterate through the Material modules and add them into the material.module.ts file (import and export array sections)
    for matmod in "${materialmods[@]}";
        do
        # echo $matmod
        #The 2 lines command below is necessary for macOS (BSD) sed.
        sed -i '' -e "1i\\
        $matmod" "$mat_mod_file_path"

        mod=$(echo $matmod | sed -n "s/.*$ch1 \(.*\)$ch2.*/\1/p")   
        mod=${mod#$prefix}; #Remove prefix
        mod=${mod%$suffix}; #Remove suffix
        # echo $mod

        # Add the Material modules into the imports: array section
        sed -i ''  "/$strA/, /$strB/ s/$strB/\t$mod,\n$strB/" "$mat_mod_file_path"

        # Add the Material modules into the exports: array section
        sed -i ''  "/$strA1/, /$strB1/ s/$strB1/\t$mod,\n$strB1/" "$mat_mod_file_path"
    done
    # cat $mat_mod_file_path
}






# Function for further customizations
furtherCustomizations() {
# **************************************************************************************************************
# 240122-23 Personal customizations
# **************************************************************************************************************
echo ">===>> Further customizations..."


# **************************************************************************************************************
# Adding additional components e.g.: add a home component 
# 240122 Create new components from the additionalcomponents: array, and  add them to the app.module.ts 

echo ">===>> Creating additional components..."
    for comp in "${additionalcomponents[@]}";
        do
        echo $comp
        npx ng g c $comp --skip-tests=true --module=app
done


srcpath=$PROJECT_FOLDER/src/app

# **************************************************************************************************************
# Initial customization for app.component.html
# **************************************************************************************************************
echo "<app-home> </app-home>" > $srcpath/app.component.html
echo "<app-form1></app-form1>" >> $srcpath/app.component.html 

# **************************************************************************************************************
# Initial customization for home.component.html
# **************************************************************************************************************

headerTitle="@angular-material DateTime picker Demo"
copyWrite="(C) 2024 Panos Zafeiropoulos"

line1="appHeaderTitle: string = \"$headerTitle\""
line2="myInfo:string = \" $copyWrite \""

strA="HomeComponent"
strB="}"
sed -i ''  "/$strA/, /$strB/ s/$strB/\t$line1\n$strB\n/" "$srcpath/home/home.component.ts"

sed -i ''  "/$strA/, /$strB/ s/$strB/\t$line2\n\n$strB\n/" "$srcpath/home/home.component.ts"



my_home_template=$(cat << 'EOF'

<mat-toolbar class="toolbar-height" color="primary">
    
    <mat-toolbar-row >  
         
          <a class="font-size2" mat-button routerLink="/">
            <mat-icon class="icon">home</mat-icon>
            {{appHeaderTitle}}
          </a>
          <span class="toolbar-item-spacer"></span>
          <div class="font-size3">{{myInfo}}</div>
  
    </mat-toolbar-row>

</mat-toolbar>

EOF
)
echo "$my_home_template" > $srcpath/home/home.component.html



my_home_css=$(cat << 'EOF'

.toolbar-item-spacer {
    flex: 1 1 auto;
} 

.toolbar-height {
    height: 70px !important;
    min-height: 70px !important;
} 

.font-size2 {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-weight: 600;
    font-size: calc(1.2 * 16px);
}

.font-size3 {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: calc(0.5 * 16px);
}

EOF
)

echo "$my_home_css" > $srcpath/home/home.component.scss



# **************************************************************************************************************
# Initial customization for form1.component.html
# **************************************************************************************************************



my_form1_tscode=$(cat << 'EOF'

import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-form1',
  templateUrl: './form1.component.html',
  styleUrls: ['./form1.component.scss']
})
export class Form1Component {

  fornCardTitle: string = 'My Demo Form';
  demoFormGroup!: FormGroup;

  input1Label: string = 'Input some text';
  input1Placeholder: string = 'Type some text here';
  input1ControlNane: string = 'input1';

  submitButtomText: string = 'Submit';

  constructor( private formBuilder: FormBuilder ) { }

  
  ngOnInit(): void {
    this.initializeForm();
  }

  initializeForm(): void {
    const fbGroup = this.formBuilder.group({});

    fbGroup.addControl(this.input1ControlNane, new FormControl(""));
    // Add more controls here

    this.demoFormGroup = fbGroup;
  }

  onFormSubmit(event: Event): void {
    console.log('Form Submitted', this.demoFormGroup.value);
  }

}

EOF
)
echo "$my_form1_tscode" > $srcpath/form1/form1.component.ts


my_form1_templatee=$(cat << 'EOF'

<mat-card >

    <mat-card-content>

        <mat-toolbar class="mat-card-title" color="primary">
            {{fornCardTitle}}
        </mat-toolbar>  

        <form [formGroup]="demoFormGroup" (ngSubmit)="onFormSubmit($event)">

            <mat-form-field class="full-width">
                <mat-label>{{input1Label}}</mat-label>
                <input matInput placeholder={{input1Placeholder}} formControlName={{input1ControlNane}} >
            </mat-form-field>

            <mat-card-footer>
                <mat-card-actions>
                    <button mat-raised-button type="submit" color="accent" > {{submitButtomText}} </button>
                </mat-card-actions>
            </mat-card-footer>

        </form>
    
    </mat-card-content>

</mat-card>

EOF
)
echo "$my_form1_templatee" > $srcpath/form1/form1.component.html


my_form1_css=$(cat << 'EOF'

mat-card {
    max-width: 400px;
    margin: 2em auto;
    text-align: center;
  }
  
  mat-form-field {
    display: block;
  }

  .mat-card-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .mat-card-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-right: 18px;
    padding-left:18px;
    margin-bottom: 15px;
    text-align: center;
    border-radius: .5cap;
  }

EOF
)
echo "$my_form1_css" > $srcpath/form1/form1.component.scss

}






# Call
if [ $OTHER == "true" ]; then
  addOtherAppModules
fi

# Call
if [ $MATERIAL == "true" ]; then
  addMaterialModules
fi


# Cal
if [ $BASICFORM == "true" ] && [ $MATERIAL == "true"] ; then
  furtherCustomizations
fi
