#!/bin/shell
for dir_list in `ls .`
do
    if [ -d $dir_list ]
    then
        echo $dir_list
        echo "enter in $dir_list"
        cd $dir_list
        git pull origin master
        echo "jump out $dir_list"
        cd ..
    fi
done
