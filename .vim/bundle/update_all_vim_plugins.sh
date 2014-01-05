#!/bin/bash
echo "$0 had $# parameters: $*"
#if [ "$#" -ne 0 ] #this bashfile needn't input any parameters
#then
#    echo "error!, it needn't input any parameters!"
#else
#    #for dir_list in `ls .`
#    #do
#    #    if [ -d $dir_list ]
#    #    then
#    #        echo $dir_list
#    #        echo "enter in $dir_list"
#    #        cd $dir_list
#    #        git pull origin master
#    #        echo "jump out $dir_list"
#    #        cd ..
#    #    fi
#    #done
#fi
dir_list=`ls .`
dir_name=($dir_list) #set value directly

dir_num=${#dir_name[*]}
echo "There are $dir_num plugins should update..."
count=0
#while [[ "$count" < $dir_num ]];do
while (("$count" < $dir_num)); do
    echo "count = $count"
    if [ -d ${dir_name[count]} ];then
        echo "enter in ${dir_name[count]}..."
        cd ${dir_name[count]}
        git pull origin master
        echo "update done, jump out ${dir_name[count]}"
        cd ..
    fi
    let "count+=1"
done
