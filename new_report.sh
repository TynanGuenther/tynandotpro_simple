#!/bin/bash

#TODO 
# [ ]copy base_report.html to public/
# [ ]rename that file to the first argument -n [FileName]
# [ ]add filename to list in index.html with -a [Name]
# [ ]open file with vim

Name=date'+%Y-%m-%d'

Copy ()
{
  cp $BASE_REPORT $SITE_DIR
  mv $SITE_DIR/base_report.html SITE_DIR/$Name
}

#Get options
while getopts ":hna" option; do
  case $option in
    h) #Show help page
      Help
      exit;;
    n) # Create new report
        Name=$OPTARG;;
    a) # Add to list in public/index.html
      AddName=$OPTARG
      Add
      exit;;
    \?) #Invalid option
      echo "Error Invalid option"
      exit;;
  esac
done

Copy
vim $SITE_DIR/$Name
