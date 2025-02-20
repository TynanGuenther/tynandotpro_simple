#!/bin/bash

#TODO 
# [X]copy base_report.html to public/
# [X]rename that file to the first argument -n [FileName]
# [X]add filename to list in index.html with -a [Name]
# [X]open file with vim
# [ ] Delete Reports

Name=$(date +%Y-%m-%d)
DisName="$Name"

Help ()
{
  echo "This is a tool to add blog/report entries to a website folder"
  echo "These are the options and how to use it"
  echo "newreport"
  echo "  no args will create a new report in the Sites Directory based of the Base report"
  echo "  -h displays this page"
  echo "  -n [NAME]: will create a new report with the given name as the filename"
  echo "  -a [FILENAME] [NAME]: will add the created file to the list of files in the index.html file if the FILENAME exists with the name NAME"
}

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
      Name="$OPTARG.html"
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
