#!/bin/bash


get_file_name_ext() {
    input=$1
    # extract config.ini
    file_name="${input##*/}"
    echo ${file_name}
}

get_file_ext() {
    file_name=$(get_file_name_ext $1)
    # get .ext 
    file_extension="${file_name##*.}"
    echo ${file_extension}
}

get_file_name_only() {
    file_name=$(get_file_name_ext $1)
    # get config 
    file="${file_name%.*}"
    echo ${file}
}

#############################
# test

#file_name=$(get_file_name_ext $0)
#file_extension=$(get_file_ext $0)
#file=$(get_file_name_only $0)

# print it
#echo "Full input file : $0"
#echo "Filename only : $file_name"
#echo "File extension only: $file_extension"
#echo "First part of filename only: $file"
