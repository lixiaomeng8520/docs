安装操作系统
============

参考资料
--------

* `Setting up a ‘PXE Network Boot Server’ for Multiple Linux Distribution Installations in RHEL/CentOS 7 <https://www.tecmint.com/install-pxe-network-boot-server-in-centos-7/>`_
* `Automated Installations of Multiple RHEL/CentOS 7 Distributions using PXE Server and Kickstart Files <https://www.tecmint.com/multiple-centos-installations-using-kickstart/>`_
* `PXE工作原理（有图有真相） <http://blog.51cto.com/lavenliu/1629922>`_
* `DHCP Option 常见取值及含义 <http://blog.csdn.net/nosodeep/article/details/45971677>`_
* `DNSmasq – 配置DNS和DHCP <http://debugo.com/dnsmasq/>`_
* `DNSmasq – 配置PXE <http://debugo.com/dnsmasq-pxe/>`_
* `DHCP原理及配置 <http://blog.51cto.com/minux/1714849>`_
* `DHCP 详解 <https://www.cnblogs.com/happygirl-zjj/p/5976526.html>`_

使用的软件
----------

+-------------+----------------------------+
| 软件        | 作用                       |
+=============+============================+
| dnsmasq     | 提供DNS, DHCP, TFTP服务    |
+-------------+----------------------------+
| syslinux    | 提供bootloader             |
+-------------+----------------------------+
| vsftpd      | 托管本地挂载的DVD镜像      |
+-------------+----------------------------+

步骤
----

1. 安装和配置dnsmasq
^^^^^^^^^^^^^^^^^^^^

安装dnsmasq

.. code-block:: bash

    yum -y install dnsmasq

编辑/etc/dnsmasq.conf内容

.. code-block:: bash

    # 只监听enp0s8网卡
    interface enp0s8
    # 不考虑通配符
    bind-interfaces 
    ​
    # DHCP range-leases
    dhcp-range = 192.168.56.100,192.168.56.200,255.255.255.0, 1h
    ​
    dhcp-boot = pxelinux.0
    ​
    enable-tftp
    tftp-root = /var/tftp

启动dnsmasq

.. code-block:: bash
    
    systemctl start dnsmasq
    systemctl enable dnsmasq

2. 安装和配置syslinux
^^^^^^^^^^^^^^^^^^^^^

安装syslinux

.. code-block:: bash

    yum -y install syslinux

将syslinux文件复制到tftp根目录下

.. code-block:: bash

    cp -r /usr/share/syslinux/* /var/tftp/

添加PXE服务配置文件

.. code-block:: bash

    mkdir /var/tftp/pxelinux.cfg
    touch /var/tftp/pxelinux.cfg/default

编辑/var/tftp/pxelinux.cfg/default文件内容

.. code-block:: bash

    default menu.c32
    prompt 0
    timeout 300
    ONTIMEOUT local
    ​
    menu title ########## PXE Boot Menu ##########
    ​
    label 1
    menu label ^1) Install CentOS 7 x64 with Local Repo
    kernel centos7/vmlinuz
    append initrd=centos7/initrd.img method=ftp://192.168.56.20/pub devfs=nomount

3. centos7 镜像复制到pxe server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    mount -o loop /dev/cdrom /mnt
    mkdir /var/tftp/centos7
    cp /mnt/images/pxeboot/vmlinuz /var/tftp/centos7/
    cp /mnt/images/pxeboot/initrd.img /var/tftp/centos7/

4. 安装vsftpd,提供安装时包下载
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

安装vsftpd

.. code-block:: bash

    yum -y install vsftpd

将/mnt下的所有文件都拷贝到/var/ftp/pub

.. code-block:: bash

    cp -r /mnt/* /var/ftp/pub

启动vsftpd

.. code-block:: bash

    systemctl start vsftpd
    systemctl enable vsftpd

问题
----

Centos7 uefi无法引导的问题
^^^^^^^^^^^^^^^^^^^^^^^^^^

1. 重新启动安装盘，进入rescure模式
2. cd /mnt/sysimage/boot/efi/EFI
3. cp centos/grubx64.efi BOOT/
