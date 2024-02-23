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
    mv "$SITE_DIR/base_report.html" "$Name"
  else
    echo "Could Not Copy File"
    exit
  fi
}
Add ()
{
  fileName=${AddOpts[0]}
  if ${#AddOpts[@]}==2; then
    DisName=${AddOpts[1]}
  fi
  if test -f $SITE_DIR/$fileName; then
    new_li="<li><a href\"/$fileName\">$DisName</a></li>"
    sed -i '/<\/ul>/i '"$new_li"'' $SITE_DIR
  else
    echo "Error $fileName Does Not Exist!"
  fi

}

#Get options
while getopts ":hn:a" option; do
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
      AddOpts+=("$OPTARG")
      Add
      exit;;
    \?) #Invalid option
      echo "Error Invalid option"
      exit;;
  esac
done
Copy
