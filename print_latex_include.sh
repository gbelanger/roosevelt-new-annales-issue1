#!/bin/bash

##  Define directory names (as a string of single strings) 
dirs="intro long_reads quick_takes reviews closing"
##  Define part titles (as an array of strings)
parts=("Introductory Remarks" "Long Reads" "Quick Takes" "Reviews" "Closing Remarks")

basedir=$PWD
out="$basedir/include_contents.tex"
if [[ -f $out ]] ; then
    rm $out ; touch $out
fi

i=0
for dir in $dirs ; do
    cd $dir
    mkdir -p superseded
    echo -e "\part{${parts[i]}}" >> $out
    if [[ "${parts[i]}" == "Introductory Remarks" ]] || [[ "${parts[i]}" == "Closing Remarks" ]] ; then
	echo "\onecolumn" >> $out
	echo >> $out
    else
	echo "\twocolumn" >> $out
	echo >> $out
    fi
    for file in *.tex ; do
	if [[ $file != *"final"* ]] ; then
	    name=$(echo $file | sed 's/.tex/_final/g')
	    echo "\include{$dir/$name}" >> $out
	fi
    done
    echo >> $out
    i=$((i+1))
    cd ..
done
