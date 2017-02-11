#!/usr/bin/bash

#store dotfiles path in a variable
dotfilesDir=~/dotfiles

#========== Load bash related settings ==============

#First create a backup folder for old files
mkdir -p ~/backup_dotfiles
backupDir=~/backup_dotfiles

#Append '#old' to all backup files already there
cd $backupDir
for f in .*;do [ -f "$f" ] || continue;mv -- "$f" "${backupDir}/${f}#old"; done

#Head to home
cd ~
# the 2>/dev/null || : takes care of error if file not found
#Backup .bashrc
cp .bashrc "${backupDir}/" 2>/dev/null || :
#Backup .bash_aliases
cp -p .bash_aliases "${backupDir}/" 2>/dev/null || :

#Add bash source line to bashrc if not present
text="source ${dotfilesDir}/bash/exports.sh;source ${dotfilesDir}/bash/path.sh;source ${dotfilesDir}/bash/bash_aliases.sh"
if grep -Fxq "$text" .bashrc
then
#All good already
:
else
echo "" >> ~/.bashrc
echo "$text" >> ~/.bashrc
fi





