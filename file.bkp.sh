# *
# * Name: Andrey Bekhterev
# * Project: Backup file with crypto and compression
# * Email: info@behterev.su
# *
# * Source: file.bkp.sh
# *


#!/bin/bash

# Key for openssl crypto engine
PASSWD=blah-blah-blah

# System user (Dropbox owner)
dUID=SomeUser

# Dropbox folder
DropBox=/path/to/Dropbox/and-sub-folder

# Source file folder
PATH=/path/to/need-backup-folder

# Source file for backup
FILE=need-backup-file

# Destination folder
BKP=/path/to/local-backup-folder

# Get system date and hour
DATE=`/bin/date +'%Y%m%d%H'`

# Copy source file to backup folder
/bin/cp ${PATH}/${FILE} ${BKP}/${DATE}.${FILE}

# Bzip backuped file
/usr/bin/bzip2 -f -9 ${BKP}/${DATE}.${FILE}

# Crypting file with openssl and use PASSWD as key
/usr/bin/openssl enc -aes-256-cbc -k ${PASSWD} -salt -in ${BKP}/${DATE}.${FILE}.bz2 -out ${BKP}/${DATE}.${FILE}.crypto

# Remove source backup file
/bin/rm ${BKP}/${DATE}.${FILE}.bz2

# Copy criypted backup file to Dropbox-some-folder
/bin/cp ${BKP}/${DATE}.${FILE}.crypto ${DropBox}

# Change owner
/bin/chown ${dUID} ${DropBox}/${DATE}.${FILE}.crypto
