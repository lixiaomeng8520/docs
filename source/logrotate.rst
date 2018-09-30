Logrotate
=========

* `man page <http://man7.org/linux/man-pages/man8/logrotate.8.html>`_

手动执行
--------

.. code-block:: bash

    logrotate /path/to/logrotate.conf

可以将其加入到计划任务里

与crontab的关系
---------------

logrotate软件包里有一个/etc/cron.daily/logrotate脚本，所以默认情况下，logrotate会每日执行

配置
----

/etc/logrotate.d/nginx文件内容

.. code-block:: bash

    /data/wwwlogs/*_log {
        daily
        missingok
        rotate 180
        nocompress
        delaycompress
        dateext
        notifempty
        create 644 www www
        sharedscripts
        postrotate
                [ -f /usr/local/openresty/nginx/logs/nginx.pid ] && kill -USR1 `cat /usr/local/openresty/nginx/logs/nginx.pid`
        endscript
    }

常用配置

* daily ：指定转储周期为每天
* weekly ：指定转储周期为每周
* monthly ：指定转储周期为每月
* rotate count ：指定日志文件删除之前转储的次数，0指没有备份，5 指保留5 个备份
* tabooext [+] list：让logrotate不转储指定扩展名的文件，缺省的扩展名是：.rpm-orig, .rpmsave, v, 和 ~
* missingok：在日志轮循期间，任何错误将被忽略，例如“文件无法找到”之类的错误。
* size size：当日志文件到达指定的大小时才转储，bytes(缺省)及KB(sizek)或MB(sizem)
* compress： 通过gzip压缩转储以后的日志
* nocompress： 不压缩
* copytruncate：用于还在打开中的日志文件，把当前日志备份并截断
* nocopytruncate： 备份日志文件但是不截断
* create mode owner group ： 转储文件，使用指定的文件模式创建新的日志文件
* nocreate： 不建立新的日志文件
* delaycompress： 和 compress 一起使用时，转储的日志文件到下一次转储时才压缩
* nodelaycompress： 覆盖 delaycompress选项，转储同时压缩。
* errors address ： 专储时的错误信息发送到指定的Email 地址
* ifempty ：即使是空文件也转储，这个是logrotate 的缺省选项。
* notifempty ：如果是空文件的话，不转储
* mail address ： 把转储的日志文件发送到指定的E-mail地址
* nomail ： 转储时不发送日志文件
* olddir directory：储后的日志文件放入指定的目录，必须和当前日志文件在同一个文件系统
* noolddir： 转储后的日志文件和当前日志文件放在同一个目录下
* prerotate/endscript： 在转储以前需要执行的命令可以放入这个对，这两个关键字必须单独成行
