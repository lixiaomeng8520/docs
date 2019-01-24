Oracle
======

* `IMP-00038: Could not convert to environment character set's handle <https://blog.csdn.net/pierre_/article/details/46346843>`_
* `ORACLE IMPDP导入提示ORA-01918：user‘XX’ does not exist <https://blog.csdn.net/u013190088/article/details/71515285>`_
* `expdp ORA-39070：Unable to open the log file <https://www.cnblogs.com/xqzt/p/5035564.html>`_

配置环境
--------

1. `下载镜像 <https://dev.aliyun.com/detail.html?spm=5176.1972343.2.2.32595aaaLv6M2v&repoId=1969>`_
2. 进入容器执行 ``source /home/oracle/.bash_profile``
3. 连入oracle ``sqlplus /nolog``
4. 连入sysdba ``connect /as sysdba``
5. 添加用户

.. code-block:: bash
    
    create user pre_user identified by pre_user;
    grant connect,resource,dba to pre_user;

imp导入
-------

.. code-block:: bash

    imp pre_user/pre_user@helowin file=/tmp/cms.dmp full=y

.. note::
    
    如果提示表空间不存在，则首先添加表空间

impdp导入
---------

1. 创建directory 

.. code-block:: bash

    create or replace directory pre_dir as '/tmp/pre';

2. 导入

.. code-block:: bash   

   impdp pre_user/pre_user@helowin DIRECTORY=pre_dir DUMPFILE=cms.dmp

.. note::
    
    如果提示用户name不存在，则在impdp最后添加 ``REMAP_SCHEMA=name:pre_user``

    如果提示表空间name不存在，则首先添加表空间，然后在impdp最后添加 ``REMAP_TABLESPACE=name:pre_tablespace``

添加表空间
----------

.. code-block:: bash

    create tablespace pre_tablespace datafile '/tmp/pre_tablespace.dbf' size 1000M autoextend on next 100M;

修改字符集
----------

`ORA-12899: value too large for column错误的解决办法 <https://www.cloudcared.cn/1771.html>`_

.. code-block:: bash

    SQL>connect username/password as SYSDBA;

    SQL>SHUTDOWN IMMEDIATE;

    SQL>STARTUP MOUNT;

    SQL>ALTER SYSTEM ENABLE RESTRICTED SESSION;

    SQL>ALTER SYSTEM SET JOB_QUEUE_PROCESSES=0;

    SQL>ALTER SYSTEM SET AQ_TM_PROCESSES=0;

    SQL>ALTER DATABASE OPEN;


    SQL> ALTER DATABASE CHARACTER SET ZHS16GBK ;

    ALTER DATABASE CHARACTER SET ZHS16GBK;

    *ERROR at line 1:
    ORA-12712: new character set must be a superset of old character set

    报字符集不兼容，此时下INTERNAL_USE指令不对字符集超集进行检查：

    SQL>ALTER DATABASE CHARACTER SET INTERNAL_USE ZHS16GBK;

    SQL>SHUTDOWN IMMEDIATE;

    SQL>STARTUP;