#!/bin/bash
path=$1
sed -i 's/AUTO_INCREMENT//g' $path
sed -i 's/CHARACTER SET utf8 COLLATE utf8_bin//g' $path
sed -i 's/CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci//g' $path
sed -i 's/CHARACTER SET utf8mb4 COLLATE utf8mb4_bin//g' $path
sed -i 's/CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci//g'  $path
sed -i 's/CHARACTER SET utf8mb4 COLLATE utf8_general_ci//g' $path
sed -i 's/CHARACTER SET utf8 COLLATE utf8_general_ci//g' $path
sed -i 's/DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP//g' $path
sed -i 's/DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP//g' $path
sed -i 's/CHARACTER SET utf8mb4 COLLATE utf8mb4_bin//g' $path
sed -i 's/DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP//g' $path
sed -i 's/DEFAULT CURRENT_TIMESTAMP//g' $path
sed -i 's/CHARACTER SET utf8mb4//g' $path
sed -i 's/CHARACTER SET utf8//g' $path
sed -i 's/COLLATE utf8mb4_general_ci//g' $path
sed -i 's/COLLATE utf8_general_ci//g'  $path
sed -i 's/COLLATE utf8_bin//g'  $path
sed -i 's/\<tinytext\>/varchar(65533)/g' $path
sed -i 's/\<text\>/varchar(65533)/g' $path
sed -i 's/\<mediumtext\>/varchar(65533)/g' $path
sed -i 's/\<longtext\>/varchar(65533)/g' $path
sed -i 's/\<tinyblob\>/varchar(65533)/g' $path
sed -i 's/\<blob\>/varchar(65533)/g' $path
sed -i 's/\<mediumblob\>/varchar(65533)/g' $path
sed -i 's/\<longblob\>/varchar(65533)/g' $path
sed -i 's/\<tinystring\>/varchar(65533)/g' $path
sed -i 's/\<mediumstring\>/varchar(65533)/g' $path
sed -i 's/\<longstring\>/varchar(65533)/g' $path
sed -i 's/\<timestamp\>/datetime/g' $path
sed -i 's/\<unsigned\>//g' $path
sed -i 's/\<zerofill\>//g' $path
sed -i 's/\<json\>/varchar(65533)/g' $path
sed -i 's/enum([^)]*)/varchar(65533)/g' $path
sed -i 's/\<set\>/varchar(65533)/g' $path
sed -i 's/\<bit\>/varchar(65533)/g' $path
sed -i 's/\<string\>/varchar(65533)/g' $path
sed -i 's/\<binary\>/varchar(65533)/g' $path
sed -i 's/\<varbinary\>/varchar(65533)/g' $path
sed -i 's/decimal([^)]*)/double/g' $path
sed -i 's/varbinary([^)]*)/varchar(65533)/g' $path
sed -i 's/binary([^)]*)/varchar(65533)/g' $path
sed -i 's/string([^)]*)/varchar(65533)/g' $path
sed -i 's/datetime([^)]*)/varchar(65533)/g' $path