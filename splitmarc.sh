#! /bin/bash

set -x

file=$1
itemcount=$(grep 'datafield tag="952"' $file | wc -l)
file_basename=$(basename $file '.marcxml')
items_per_file=50
items_left=$itemcount
output_dir='/tmp'

last_header_line=$(( $(grep -n 'datafield tag="952"' $file | head -1 | cut -d ':' -f 1) - 1 ))

start=1
while [[ $items_left -gt 0 ]]
do
    if [[ $items_per_file -gt  $items_left ]]
    then
        items_per_file=$items_left
    fi
    end=$(($start + $items_per_file - 1))
    xmlfile=" $output_dir/$file_basename.${start}-${end}.xml"
    marcfile=" $output_dir/$file_basename.${start}-${end}.marc"
    ( sed -n "1,${last_header_line}p" $file ; xpath -e "//datafield[@tag=952][ $start <= position() and position() < $end ]" $file 2> /dev/null;echo '</record>' ) > $xmlfile; 
    yaz-marcdump -i marcxml $xmlfile > $marcfile && rm  $xmlfile
    items_left=$(($items_left - $items_per_file))
    start=$(($start + $items_per_file))
done

