Vsftpd
======

* `vsftpd配置虚拟用户为登录用户 <https://blog.csdn.net/zhangpfly/article/details/73160346>`_

vsftpd默认使用系统用户，这里先讨论系统用户的情况，以后再说虚拟用户

步骤
----

1. 安装vsftpd

.. code-block:: bash

    yum install vsftpd

2. 添加ftp目录，用户，设置密码
   
.. code-block:: bash

    mkdir /home/path/to
    useradd -d /home/path/to -s /sbin/nologin ftpuser
    echo "ftpuser:pass" | chpasswd
    chown -R ftpuser /home/path/to

3. 删除pam.d/vsftpd
   
.. code-block:: bash

    rm -rf /etc/pam.d/vsftpd

4. 配置/etc/vsftpd.conf

.. code-block:: bash
    
    # 监听ipv4
    listen=YES

    # 权限等
    write_enable=YES
    chroot_local_user=YES
    chroot_list_enable=YES
    chroot_list_file=/etc/vsftpd.chroot_list
    allow_writeable_chroot=YES

    # 被动模式
    pasv_address=192.168.77.101
    pasv_enable=YES
    pasv_min_port=50001
    pasv_max_port=50009

5. 添加ftp用户到chroot_list_file
   
.. code-block:: bash

    echo ftpuser > /etc/vsftpd.chroot_list

6. 启动
   
.. code-block:: bash

    systemctl start vsftpd

Docker注意
----------

21端口，pasv_min_port - pasv_max_port端口都要暴露，后者源和目标端口保持一致。