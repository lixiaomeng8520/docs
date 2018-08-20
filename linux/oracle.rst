oracle记录
==========

登录
----

.. code-block:: bash

    sqlplus /nolog
    connect /as sysdba

添加用户
--------

.. code-block:: bash
    
    create user dfish identified by dfish;
    grant connect,resource,dba to dfish;

添加表空间
----------

.. code-block:: bash

    create tablespace DFISH datafile '/tmp/DFISH.dbf' size 1000M autoextend on next 100M;

导入dmp
-------

.. code-block:: bash

    imp dfish/dfish@helowin file=/tmp/dfish.dmp full=y

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