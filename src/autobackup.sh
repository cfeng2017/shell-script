#!/bin/bash

# 本脚本实现了自动备份指定目录文件到某个目录
# 需要配置下面三个以BAK_开头的变量
# 自动执行需要添加到定时任务(crontab)，比如每小时执行一次备份
#     0 */1 * * * /bin/bash 当前脚本的完整路径
# author: 管宜尧<guanyiyao@letv.com>

# 要备份的文件（夹）所在目录
BAK_DIR_BASE="/vagrant/codes/"
# 要备份的文件（夹）
BAK_DIR_NAME="c"

# 备份到哪个目录
BAK_DEST="/home/vagrant/backup/"


if [ ${BAK_DIR_BASE:${#BAK_DIR_BASE}-1:1} != "/" ]
then
  BAK_DIR_BASE="${BAK_DIR_BASE}/"
fi

if [ ${BAK_DEST:${#BAK_DEST}-1:1} != "/" ]
then
  BAK_DEST="${BAK_DEST}/"
fi

echo "进入目录${BAK_DIR_BASE}"
cd ${BAK_DIR_BASE} 

DATE=$(date +%Y%m%d%H%M%S)

echo "备份目录${BAK_DIR_NAME} 到 ${BAK_DEST}${BAK_DIR_NAME}-backup.${DATE}.tar"
tar -zcvf ${BAK_DEST}${BAK_DIR_NAME}-backup.${DATE}.tar.gz ${BAK_DIR_NAME}


echo "删除过期文件（30天前)"
find ${BAK_DEST} -name "${BAK_DIR_NAME}-backup.*.tar.gz" -mtime +30
find ${BAK_DEST} -name "${BAK_DIR_NAME}-backup.*.tar.gz" -mtime +30 -exec rm {} \;

echo "操作完成!"
