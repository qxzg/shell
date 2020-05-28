#!/bin/bash

TargetPool="cold-backup-1"
BackupListFile='backup-dataset-list.txt'

clear


echo -e "请确认目标Pool:\033[1;4;41;337m "${TargetPool}" \033[0m中的Dataset已经\033[41;37m 全部清除 \033[0m"
read -e -r -p "Are You Sure? [Y/n] " input1
echo
case ${input1} in
    [yY][eE][sS]|[yY])
		echo "请确认备份的DataSet:"
		;;
    [nN][oO]|[nN]|*)
		exit 1
      ;;
esac

TotalSize=0
echo
for line in `cat $BackupListFile`
do
    DatasetSize=`zfs list -H -o used ${line}`
    printf "\033[4;41;37m%-30s %-5s %-6s\033[0m\n" ${line} Size: ${DatasetSize}
    sizet=`echo ${DatasetSize} | tr -d "a-zA-Z"`
    if [[ ${DatasetSize} =~ "M" ]]
    then
       TotalSize=`echo "scale=10;"${TotalSize}"+"${sizet}"/1048576" | bc`
    fi
    if [[ ${DatasetSize} =~ "G" ]]
    then
       TotalSize=`echo "scale=10;"${TotalSize}"+"${sizet}"/1024" | bc`
    fi
    if [[ ${DatasetSize} =~ "T" ]]
    then
       TotalSize=`echo ${TotalSize}"+"${sizet} | bc`
    fi
done
printf "\033[4;42;37m                         %-13s \33[1m%-5.3f%s\033[0m\n" 合计大小: ${TotalSize} TiB
printf "\033[4;45;37m                     %-11s \33[1m%-8s\033[0m\n" 目标剩余空间: `zfs list -H -o avail ${TargetPool}`iB

echo
echo -e "请确认备份Dataset和目标Pool剩余容量足够"
read -e -r -p "Are You Sure? [Y/n] " input2
echo
case ${input2} in
    [yY][eE][sS]|[yY])
		echo ""
		;;
    [nN][oO]|[nN]|*)
		exit 1
      ;;
esac

read -e -r -p "请最后一次确认备份无误，按Y启动备份" input2
echo ""
case ${input2} in
    [yY])
		echo ""
		;;
    [nN][oO]|[nN]|*)
		exit 1
      ;;
esac


# #开始备份
SnapName=cold-backup-`cat /dev/urandom | head -n 10 | md5 |cut -c 1-6`
for line in `cat $BackupListFile`
do 
    echo;echo;echo "Backing up "${line}
    zfs snap -r ${line}@${SnapName} || exit 1
    
    #创建父目录
    unset Parent;unset PathArray
    Parent=${TargetPool}
    PathArray=(${line//// })  
    unset PathArray[${#PathArray[@]}-1]
    for var in ${PathArray[@]}
    do
       Parent=${Parent}"/"${var}
       ls /mnt/${Parent} > /dev/null 2>&1 || zfs create ${Parent}
    done;unset var
    
    #开始移动
    ls /mnt/${TargetPool}/${line} > /dev/null 2>&1 && zfs destroy ${TargetPool}/${line}
    zfs send -R ${line}@${SnapName} | zfs receive -F -v ${TargetPool}/${line}
    if [ "$?" != "0" ]; then
       read -e -r -p "在备份"${line}"时检测到异常，请问是否继续？按Y继续" input5
       case ${input5} in
          [yY])
            echo ""
            ;;
          [nN][oO]|[nN]|*)
            exit 1
            ;;
       esac
    fi
    zfs destroy -R -v ${line}@${SnapName}
    echo "Backup complete "${line};echo;echo
done

