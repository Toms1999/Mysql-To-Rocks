#!/bin/bash
source ../conf/rocks.conf

#Execute the create external table sql
echo "source ../result/e_mysql_to_rocks.sql;" |mysql -h$fe_host -P$fe_master_port -uroot -p$fe_password 2>error.log

#Circulation monitoring mysql or conf
while (( 1 == 1 ))
do

#Monitor interval
sleep 30

#get new create table sql
sh ./e_mysql_to_rocks.sh ../result/new_e_mysql_to_rocks.sql 2>error.log

#get a md5 from old create table sql
old=`md5sum ../result/e_mysql_to_rocks.sql |awk -F ' ' '{print $1}'`

#get a md5 from new create table sql
new=`md5sum ../result/new_e_mysql_to_rocks.sql |awk -F ' ' '{print $1}'`

        if [[ $old != $new ]];then
#table charges to drop old table and create new table
                for table in $(cat ../conf/rocks_tables |grep -v '#' | awk -F '\n' '{print $1}')
                do
                       echo "drop table if exists ${table};" |mysql -h$fe_host -P$fe_master_port -uroot -p$fe_password
                done
                echo "source ../result/new_e_mysql_to_rocks.sql;" |mysql -h$fe_host -P$fe_master_port -uroot -p$fe_password 2>error.log
#delete old create table
                rm -rf ../result/e_mysql_to_rocks.sql
#alter new table sql name 
                mv ../result/new_e_mysql_to_rocks.sql ../result/e_mysql_to_rocks.sql
                fi
#if table no charge delete new create table 
        rm -f ../result/new_e_mysql_to_rocks.sql
done