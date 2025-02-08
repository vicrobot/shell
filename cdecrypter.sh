#!/usr/bin/env bash

## README GENERAL OR FOR TROUBLESHOOT ##

# 1. pwdhere needs to be updated with your password of colornote
# 2. The command should look like 
     # $ ./cdecrypter.sh <backupfile> <outfile.json> <password>
     # most of the time, the decrypter is stuck, no work, is all because of wrong command, check names again.
     # also im assuming backupfile is in pwd, the same where script is located
# 3. Decrypter tool is in tmp, where its renamed as master.zip, make sure there isn't other unexpected master.zip
# 4. For java related and json output file's encoding etc stuffs related things, might want to check the github repo
#  https://github.com/olejorgenb/ColorNote-backup-decryptor
# of course core credit goes to this above repo's developer(s).
# 5. For other queries, write to me: 'chaosplusorder@gmail.com'

##  


success(){
    
    if [[ $1 != 0 ]]; then
        echo 'error'
        echo 'you might want to read the troubleshoot part of this script'
        exit 1
    fi
}


if [[ $# -ne 3 ]]; then
    echo "Argument Error"
    echo "Expected arguments should be like:"
    echo " $ ./cdecrypter.sh <backupfile> <outfile.json> <password>"
    exit 1
fi


inputfile=$1
outputfilename=$2
password=$3

PWDVAR=$(pwd)
echo "Current directory is $PWDVAR"

echo "changing script's working dir to /tmp"

cd /tmp
success $?

if [[ ! -d ColorNote-backup-decryptor-master ]]; then
    echo 'fetching zip'
    wget -t 3 https://github.com/olejorgenb/ColorNote-backup-decryptor/archive/refs/heads/master.zip
    success $?
    
    echo 'extracting zip'
    unzip master.zip
    success $?

fi

# &0 file descriptor 0 is stdin, 1 is stdout, and 2 is stderr
echo "decrypting $inputfile"
#java -jar ColorNote-backup-decryptor-master/colornote-decrypt.jar $password 28 <&0 | ./ColorNote-backup-decryptor-master/fixup-v2  > $outputfilename

if [[ -f $PWDVAR/$inputfile && -f ColorNote-backup-decryptor-master/colornote-decrypt.jar && -f ColorNote-backup-decryptor-master/colornote-decrypt.jar ]]; then
    echo "Command looks like:"
    echo  "java -jar ColorNote-backup-decryptor-master/colornote-decrypt.jar $password 28 < $PWDVAR/$inputfile | ./ColorNote-backup-decryptor-master/fixup-v2  > $outputfilename"
    java -jar ColorNote-backup-decryptor-master/colornote-decrypt.jar $password 28 < $PWDVAR/$inputfile | ./ColorNote-backup-decryptor-master/fixup-v2  > $outputfilename
    success $?
else
    echo -e "some of the file \n$PWDVAR/$inputfile, \n/tmp/ColorNote-backup-decryptor-master/colornote-decrypt.jar or \n/tmp/ColorNote-backup-decryptor-master/colornote-decrypt.jar \nis missing"
fi

echo "outputfile $outputfilename is ready"
echo "moving file to $PWDVAR"
mv $outputfilename $PWDVAR/$outputfilename
success $?

exit 0














