Sqlserver
=========

* `使用 Docker 快速入门： 运行 SQL Server 容器映像 <https://docs.microsoft.com/zh-cn/sql/linux/quickstart-install-connect-docker?view=sql-server-2017>`_

还原数据库，路径是服务器的。

.. code-block:: bash
    
    exec sp_attach_db 'hnfl','/tmp/hnfl/hnfl_db.mdf','/tmp/hnfl/hnfl_db_log.LDF';
    go;

Linux下连接sqlserver：freetds