Ulimit
======

每个进程的最大打开文件数
------------------------

每个用户都有一个最大文件打开数，作为环境变量，当通过该用户打开的进程时会使用该数量，通过如下命令查看

.. code-block:: bash

    # 当前用户
    ulimit -a

查看进程当前打开文件

.. code-block:: bash
    
    # 打开的文件列表
    lsof -p PID
    # 打开的文件数
    lsof -p PID | wc -l

通过对比上述数量，来检查是否超出，和定位问题

修改打开文件数，编辑/etc/security/limits.conf，添加或修改如下参数（ubuntu系统需要将*替换为root）

.. code-block:: bash

    * soft nproc 1000000
    * hard nproc 1000000
    * soft nofile 1000000
    * hard nofile 1000000

设置完毕之后，重新打开终端，令该环境变量生效，然后重启相应程序，使进程生效。这里必须在新终端里重启程序，因为程序使用的数量是当前的环境变量。

系统的最大打开文件数
--------------------