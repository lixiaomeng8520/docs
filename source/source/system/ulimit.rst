Ulimit
======

每个进程的最大打开文件数
------------------------

每个进程都有一个最大文件打开数，通过如下命令查看

.. code-block:: bash

    ulimit -a PID

查看进程当前打开文件

.. code-block:: bash
    
    # 打开的文件列表
    lsof -p 23370
    # 打开的文件数
    lsof -p 23370 | wc -l

通过对比上述数量，来检查是否超出，和定位问题

修改打开文件数，编辑/etc/security/limits.conf，添加或修改如下参数

·· code-block:: bash

    * soft nproc 1000000
    * hard nproc 1000000
    * soft nofile 1000000
    * hard nofile 1000000

不用重启系统，但是已在运行的程序，需要重启程序才能生效。ubuntu系统需要将*替换为root

系统的最大打开文件数
--------------------