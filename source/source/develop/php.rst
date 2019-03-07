PHP
===

网站
----

* `PHP官方网站 <http://php.net/>`_
* `PHP-FIG <https://www.php-fig.org/>`_
* `Composer <https://getcomposer.org/>`_
* `Packagist <https://packagist.org/>`_
* `Packagist中国镜像 <https://packagist.laravel-china.org/>`_
* `Aura for PHP <http://auraphp.com/>`_
* `Slim <https://www.slimframework.com/>`_
* `REST API Handbook <https://developer.wordpress.org/rest-api/>`_
* `PSR中文翻译 <https://laravel-china.org/docs/psr>`_
* `The League of Extraordinary Packages <https://github.com/thephpleague>`_
* `Zend Framework <https://github.com/zendframework>`_

知识点
------

* `​PHP 7 错误处理​ <http://php.net/manual/zh/language.errors.php7.php>`_
* `PSR-7 Objects Are Not Immutable <http://andrew.carterlunn.co.uk/programming/2016/05/22/psr-7-is-not-immutable.html>`_
* `PHP 的异常处理、错误处理:error_reporting,try-catch,trigger_error,set_error_handler,set_exception_handler,regis <https://blog.csdn.net/aerchi/article/details/37757751>`_
* `再谈PHP错误与异常处理 <https://www.cnblogs.com/zyf-zhaoyafei/p/6928149.html>`_
  
Packagist常用软件包
-------------------

+-------------------------------+--------------------------------------+
|             包名              |                 作用                 |
+===============================+======================================+
| slim\/slim                    | 包含router，di，middleware，error    |
+-------------------------------+--------------------------------------+
| hassankhan\/config            | 配置文件加载                         |
+-------------------------------+--------------------------------------+
| aura\/sql                     | 数据库操作，内部使用PDO              |
+-------------------------------+--------------------------------------+
| aura\/session                 | session操作，包含flash session，csrf |
+-------------------------------+--------------------------------------+
| zendframework\/zend-diactoros | PSR HTTP Message 实现                |
+-------------------------------+--------------------------------------+
| monolog\/monolog              | 日志转存，handler非常多              |
+-------------------------------+--------------------------------------+
| guzzlehttp\/guzzle            | HTTP请求客户端，代替curl             |
+-------------------------------+--------------------------------------+
| respect\/validation           | 输入校验                             |
+-------------------------------+--------------------------------------+
| squizlabs\/php_codesniffer    | PHP代码规范校验（开发工具）          |
+-------------------------------+--------------------------------------+
| nesbot\/carbon                | DateTime                             |
+-------------------------------+--------------------------------------+
|                               |                                      |
+-------------------------------+--------------------------------------+
|                               |                                      |
+-------------------------------+--------------------------------------+

* zendframework/zend-diactoros
* nikic/fast-route
* pimple/pimple
* hassankhan/config
* relay/relay
* filp/whoops


安装
----

在centos下，推荐ius仓库。

服务器
------

php自带服务器
^^^^^^^^^^^^^

.. code-block:: bash

    php -S 0.0.0.0:80 -t .

nginx配置
^^^^^^^^^

.. code-block:: bash

    server {
        listen 80;
        server_name pp3.lxm.cn;
        root "E:/workspace/php/PecidPHP3/public";

        location / {
            try_files 
        }
    }