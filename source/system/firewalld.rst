Firewalld
=========

* `​How to Configure ‘FirewallD’ in RHEL/CentOS 7 and Fedora 21​ <https://www.tecmint.com/configure-firewalld-in-centos-7/>`_
* `Useful ‘FirewallD’ Rules to Configure and Manage Firewall in Linux​ <https://www.tecmint.com/firewalld-rules-for-centos-7/>`_
* `https://blog.csdn.net/haunt9/article/details/77334613 <https://blog.csdn.net/haunt9/article/details/77334613>`_
* `5.1. Getting Started with firewalld <https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-using_firewalls>`_
  
Zone
----

.. note::

    一个应用场景是，一个人在公司工作，他不信任周围的网络，也不想让别人访问自己的机器，就可以切换到drop zone；回到家后，希望与家人共享，那就可以切换到public zone。

1. zone是firewalld里特有的，相当于一个规则集，类似于windows里的家庭网络，工作网络等，可以切换。
2. 特定时刻只有一个zone（规则集）生效，生效的zone被称为default。
3. firewalld里自带了9个zone，zone的名字只是个标识，他们完全可以随意更改，也可以定义自己的。具体行为靠zone配置文件里的target属性来控制。

Service
-------

1. firewalld的服务相当于规则的名字。比如tcp 8080端口可以定义为投票服务，tcp 8081端口定义为后台管理系统服务。
2. 配置文件在两个位置，``/etc/firewalld/services`` 是自定义服务，``/usr/lib/firewalld/services`` 是系统服务，默认搜索自定义服务，如果找到，就不再搜索系统服务。
3. 实际应用中可以参考系统服务的配置，比如将系统服务的某个配置文件拷贝到自定义服务里，然后相应修改一下。

常用命令
--------

.. note::

    目前关于规则生效的结果是：

    1. 临时规则会立即生效，``--reload`` 或重启后失效。
    2. ``--permanent`` 不会立即生效，需要--reload或重启。

+----------------------------+----------------------------------------------------------------+
| 描述                       | 命令                                                           |
+============================+================================================================+
| firewalld状态              | firewall-cmd --state                                           |
+----------------------------+----------------------------------------------------------------+
| 重载配置                   | firewall-cmd --reload                                          |
+----------------------------+----------------------------------------------------------------+
|                            |                                                                |
+----------------------------+----------------------------------------------------------------+
| 获取所有zone               | firewall-cmd --get-zones                                       |
+----------------------------+----------------------------------------------------------------+
| 获取默认zone               | firewall-cmd --get-default-zone                                |
+----------------------------+----------------------------------------------------------------+
| 获取zone详情               | firewall-cmd --list-all --zone=public                          |
+----------------------------+----------------------------------------------------------------+
| 设置默认zone               | firewall-cmd --set-default-zone=drop                           |
+----------------------------+----------------------------------------------------------------+
|                            |                                                                |
+----------------------------+----------------------------------------------------------------+
| 获取所有服务               | firewall-cmd --get-services                                    |
+----------------------------+----------------------------------------------------------------+
| 添加服务                   | firewall-cmd --zone=public --add-service=tomcat --permanent    |
+----------------------------+----------------------------------------------------------------+
| 删除服务                   | firewall-cmd --zone=public --remove-service=tomcat --permanent |
+----------------------------+----------------------------------------------------------------+
