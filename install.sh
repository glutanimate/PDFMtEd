#!/bin/bash

# Installer for PDFMtEd

# (c) 2014 Glutanimate
# License: GNU GPLv3

# Variables

Installer="$(readlink -f "$0")"
SourcePath="${Installer%/*}"

InstallPath="/usr/local"
BinPath="$InstallPath/bin"
LauncherPath="$InstallPath/share/applications"
IconPath="$InstallPath/share/icons/hicolor/scalable/apps"

Application="PDFMtEd"
InstallationFiles=("desktop/pdfmted-editor.desktop" "desktop/pdfmted-inspector.desktop"\
  "desktop/pdfmted.svg" "pdfmted-editor" "pdfmted-inspector" "pdfmted-thumbnailer")
Dependencies=(yad exiftool python2.7 qpdf)

# Functions

check_deps() {
    for i in "$@"; do
      type "$i" > /dev/null 2>&1 
      if [[ "$?" != "0" ]]; then
        MissingDeps+=" $i"
      fi
    done
    if [[ -n "$MissingDeps" ]]; then
      echo "Error: Missing dependencies(${MissingDeps})"
      echo "Aborting installation."
      exit 1
    fi
}

check_sourcefiles(){
  for i in "$@"; do
    if [[ ! -f "$i" && ! -d "$i" ]]; then
      echo "Error: $i not found in current directory.
 Please make sure to execute the installer in the same
 directory as all other project files."
      echo "Aborting installation."
      exit 1
    fi
  done
}

check_destinations(){
  for i in "$@"; do
   if [[ ! -d "$i" ]]; then
     echo "Error: Installation directory not found ($i)"
     echo "Aborting installation."
     exit 1
   fi
  done
}

# Main

# Check if interactive
if [[ ! -t "0" ]]; then
  echo "Error: Shell not interactive"
  echo "Aborting installation"
  exit 1
fi

# Check if root
if [[ "$(whoami)" != "root" ]]; then
  echo "Error: This script needs root privileges. Restarting..."
  sudo "$0"
  exit
fi

cd "$SourcePath"

echo "Checking installation files for integrity..."
check_sourcefiles "${InstallationFiles[@]}"

echo "Checking installation directory..."
check_destinations "$BinPath" "$LauncherPath" "$IconPath"

echo "Checking dependencies..."
check_deps "${Dependencies[@]}"

echo "Installing $Application to $InstallPath ..."
sudo cp -v "pdfmted-editor" "pdfmted-inspector" "pdfmted-thumbnailer" "${BinPath}/"
sudo cp -v "desktop/pdfmted-editor.desktop" "desktop/pdfmted-inspector.desktop" "${LauncherPath}/"
sudo cp -v "desktop/pdfmted.svg" "${IconPath}/"

echo "Done."