#!/bin/bash
source ../conf/mysql.conf
source ../conf/rocks.conf

#mkdir files to store tables and tables.sql
mkdir -p ../result

#The default path is ../result/mysql_to_rocks.sql for create table sql
path=${1:-../result/mysql_to_rocks.sql}

#delete sql file if it is exists
rm -f $path


#get create table sql for mysql
for table in $(cat ../conf/mysql_tables |grep -v '#' | awk -F '\n' '{print $1}')
        do
        echo "show create table ${table};" |mysql -h$mysql_host -uroot -p$mysql_password  >> $path
done

#adjust sql
awk -F '\t' '{print $2}' $path |awk '!(NR%2)' |awk '{print $0 ";"}' > ../result/tmp111.sql
sed -i 's/\\n/\n/g' ../result/tmp111.sql
sed -n '/CREATE TABLE/,/ENGINE\=/p' ../result/tmp111.sql > ../result/tmp222.sql


#delete tables special struct
sed -i '/^  CON/d' ../result/tmp222.sql
sed -i '/^  KEY/d' ../result/tmp222.sql
rm -rf $path
rm -rf ../result/tmp111.sql
mv ../result/tmp222.sql $path

#start transform tables struct
sed -i '/ENGINE=/a) ENGINE=MYSQL\n COMMENT "MYSQL"\nPROPERTIES (\n"host" = "rocksHostIp",\n"port" = "3306",\n"user" = "root",\n"password" = "rocksHostPassword",\n"database" = "rocksDataBases",\n"table" = "rocksTables");' $path


#delete match line
sed -i '/PRIMARY KEY/d' $path
sed -i '/UNIQUE KEY/d' $path

#delete , at the beginning (
sed -i '/,\s*$/{:loop; N; /,\(\s*\|\n\))/! bloop; s/,\s*[\n]\?\s*)/\n)/}' $path

#delete a line on keyword
sed -i -e '$!N;/\n.*ENGINE=MYSQL/!P;D' $path

#replace mysql password、database、table、host
for t_name in $(cat ../conf/mysql_tables |grep -v '#' | awk -F '\n' '{print $1}')
        do
        d=`echo $t_name | awk -F '.' '{print $1}'`
        t=`echo $t_name | awk -F '.' '{print $2}'`
        sed -i "0,/rocksHostIp/s/rocksHostIp/${mysql_host}/" $path
        sed -i "0,/rocksHostPassword/s/rocksHostPassword/${mysql_password}/" $path
        sed -i "0,/rocksDataBases/s/rocksDataBases/$d/" $path
        sed -i "0,/rocksTables/s/rocksTables/$t/" $path
done


#do transfrom from mysql to rocks external
sh ../lib/mysql_to_rocks.sh $path

#get an orderly table name and add if not exists statement
x=0
for table in $(cat ../conf/rocks_tables |grep -v '#' | awk -F '\n' '{print $1}')
        do
        let x++
        d_t=`cat ../conf/mysql_tables |grep -v '#' | awk "NR==$x{print}" |awk -F '.' '{print $2}'`
        sed -i "s/TABLE \`$d_t\`/TABLE if not exists $table/g" $path
done

#create database
for d_rocks in $(cat ../conf/rocks_tables |grep -v '#' | awk -F '\n' '{print $1}' |awk -F '.' '{print $1}' |sort -u)
do
                sed -i "1icreate database if not exists $d_rocks;" $path
done
