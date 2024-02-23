#!/bin/bash

#TODO 
# [ ]copy base_report.html to public/
# [ ]rename that file to the first argument -n [FileName]
# [ ]add filename to list in index.html with -a [Name]
# [ ]open file with vim

Name=$(date +%Y-%m-%d)
DisName="$Name"


Copy ()
{
  if cp "$BASE_REP" "$SITE_DIR"; then
    mv "$SITE_DIR/base_report.html" "$SITE_DIR/$Name"
  else
    echo "Could Not Copy File"
    exit
  fi
}
Add ()
{

  if test -f $SITE_DIR/$fileName; then
    new_li="\\\\t\t\t\t\t\\<li><a href\"/$fileName\">$DisName</a></li>"
    sed -i '/<!-- HERE -->/i '"$new_li"'' "$SITE_DIR/index.html"
  else
    echo "Error $fileName Does Not Exist!"
  fi

}

#Get options
while getopts ":hn:a:" option; do
  case $option in
    h) #Show help page
      Help
      exit;;
    n) # Create new report
      Name=$OPTARG
      Copy
      vim $SITE_DIR/$Name
      exit;;
    a) # Add to list in public/index.html
      fileName=${OPTARG}
      if [[ "${!OPTIND}" != "-"* ]]; then
        DisName=${!OPTIND}
        OPTIND=$((OPTIND + 1))
      fi
      Add
      exit;;
    \?) #Invalid option
      echo "Error Invalid option"
      exit;;
  esac
done
Copy
