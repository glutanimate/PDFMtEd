#!/bin/bash

# Uninstaller for PDFMtEd

# (c) 2014 Glutanimate
# License: GNU GPLv3

# Variables

InstallPath="/usr/local"
BinPath="$InstallPath/bin"
LauncherPath="$InstallPath/share/applications"
IconPath="$InstallPath/share/icons/hicolor/scalable/apps"

Application="PDFMtEd"

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

echo "Uninstalling $Application ..."

[[ -f "$BinPath/pdfmted-editor" ]] && sudo rm -v "$BinPath/pdfmted-editor"
[[ -f "$BinPath/pdfmted-inspector" ]] && sudo rm -v "$BinPath/pdfmted-inspector"
[[ -f "$BinPath/pdfmted-thumbnailer" ]] && sudo rm -v "$BinPath/pdfmted-thumbnailer"
[[ -f "$LauncherPath/pdfmted-editor.desktop" ]] && sudo rm -v "$LauncherPath/pdfmted-editor.desktop"
[[ -f "$LauncherPath/pdfmted-inspector.desktop" ]] && sudo rm -v "$LauncherPath/pdfmted-inspector.desktop"
[[ -f "$IconPath/pdfmted.svg" ]] && sudo rm -v "$IconPath/pdfmted.svg"

echo "Done."