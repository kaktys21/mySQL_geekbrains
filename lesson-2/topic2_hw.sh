1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
Файл конфигурации создал, тут поэтмоу могу заходить без указаний юзера и пароля

Microsoft Windows [Version 10.0.18363.778]
(c) Корпорация Майкрософт (Microsoft Corporation), 2019. Все права защищены.

C:\WINDOWS\system32>cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 21
Server version: 8.0.23 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
6 rows in set (0.00 sec)


2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.


mysql> CREATE DATABASE example;
Query OK, 1 row affected (0.01 sec)

mysql> USE examples
ERROR 1049 (42000): Unknown database 'examples'
mysql> USE example;
Database changed
mysql> CREATE TABLE users(id SERIAL, name VARCHAR(100));
Query OK, 0 rows affected (0.13 sec)

mysql> SHOW TABLES;
+-------------------+
| Tables_in_example |
+-------------------+
| users             |
+-------------------+
1 row in set (0.00 sec)

mysql> \q
Bye

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump example > example.sql

C:\Program Files\MySQL\MySQL Server 8.0\bin>dir
 Том в устройстве C имеет метку Windows
 Серийный номер тома: 820D-7398

 Содержимое папки C:\Program Files\MySQL\MySQL Server 8.0\bin

04.03.2021  14:05    <DIR>          .
04.03.2021  14:05    <DIR>          ..
04.03.2021  14:05             1 919 example.sql
11.12.2020  08:45           681 984 harness-library.dll
11.12.2020  02:22         6 379 624 ibd2sdi.exe
11.12.2020  02:22         6 367 864 innochecksum.exe
08.12.2020  15:31         3 427 840 libcrypto-1_1-x64.dll
25.08.2020  15:40         1 839 616 libmecab.dll
11.12.2020  08:23         6 872 576 libprotobuf-debug.dll
11.12.2020  08:22         1 357 824 libprotobuf-lite-debug.dll
11.12.2020  08:43           553 472 libprotobuf-lite.dll
11.12.2020  08:42           898 420 libprotobuf-lite.lib
11.12.2020  08:44         2 832 896 libprotobuf.dll
11.12.2020  08:44         4 179 030 libprotobuf.lib
08.12.2020  15:31           685 568 libssl-1_1-x64.dll
11.12.2020  02:22         6 312 056 lz4_decompress.exe
11.12.2020  02:22         6 634 608 myisamchk.exe
11.12.2020  02:22         6 478 960 myisamlog.exe
11.12.2020  02:22         6 532 720 myisampack.exe
11.12.2020  02:22         6 509 688 myisam_ftdump.exe
11.12.2020  02:22         6 953 576 mysql.exe
11.12.2020  02:22         6 847 600 mysqladmin.exe
11.12.2020  02:22         7 157 872 mysqlbinlog.exe
11.12.2020  02:22         6 854 768 mysqlcheck.exe
11.12.2020  02:22        50 414 184 mysqld.exe
11.12.2020  02:22         6 915 184 mysqldump.exe
11.12.2020  08:21             7 902 mysqldumpslow.pl
11.12.2020  08:21            28 797 mysqld_multi.pl
11.12.2020  02:22            34 432 mysqlharness_stdx.dll
11.12.2020  02:22            62 080 mysqlharness_tls.dll
11.12.2020  02:22         6 840 944 mysqlimport.exe
11.12.2020  02:22         7 309 936 mysqlpump.exe
11.12.2020  02:22         7 472 240 mysqlrouter.exe
11.12.2020  02:22           246 912 mysqlrouter_http.dll
11.12.2020  02:22           101 016 mysqlrouter_http_auth_backend.dll
11.12.2020  02:22            30 864 mysqlrouter_http_auth_realm.dll
11.12.2020  02:22            72 848 mysqlrouter_io_component.dll
11.12.2020  02:22         7 518 848 mysqlrouter_keyring.exe
11.12.2020  02:22         7 491 712 mysqlrouter_passwd.exe
11.12.2020  02:22         6 235 784 mysqlrouter_plugin_info.exe
11.12.2020  02:22         6 839 408 mysqlshow.exe
11.12.2020  02:22         6 856 816 mysqlslap.exe
11.12.2020  02:22         6 267 008 mysql_config_editor.exe
11.12.2020  02:22         6 837 392 mysql_secure_installation.exe
11.12.2020  02:22         6 293 632 mysql_ssl_rsa_setup.exe
11.12.2020  02:22         6 207 104 mysql_tzinfo_to_sql.exe
11.12.2020  02:23         6 928 504 mysql_upgrade.exe
11.12.2020  02:23         6 252 160 my_print_defaults.exe
11.12.2020  02:23         7 038 056 perror.exe
11.12.2020  02:24         6 228 600 zlib_decompress.exe
              48 файлов    262 892 844 байт
               2 папок  22 461 857 792 байт свободно


3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.


C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 23
Server version: 8.0.23 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
7 rows in set (0.00 sec)

mysql> CREATE DATABASE sample;
Query OK, 1 row affected (0.05 sec)

mysql> \q
Bye

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql sample < example.sql

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 8.0.23 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> USE sample
Database changed
mysql> SHOW TABLES;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0.00 sec)

mysql> \q
Bye


4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. 
Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.


C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump mysql help_keyword --where="true limit 100" > C:\Users\epish\Desktop\tester_dump.sql

C:\Program Files\MySQL\MySQL Server 8.0\bin>