Go
==

资料

* `Go 语言教程 <http://www.runoob.com/go/go-tutorial.html>`_
* `build-web-application-with-golang <https://github.com/astaxie/build-web-application-with-golang>`_
* `Practical Go: Real world advice for writing maintainable Go programs <https://dave.cheney.net/practical-go/presentations/qcon-china.html>`_
* `Socket编程---最浅显易懂的介绍 <https://blog.csdn.net/alpha_love/article/details/62043077>`_
* `Go语言入门教程，Golang入门教程（非常详细） <http://c.biancheng.net/golang/>`_

示例学习

* `The-Golang-Standard-Library-by-Example <https://github.com/polaris1119/The-Golang-Standard-Library-by-Example>`_
* `gobyexample <https://github.com/mmcgrana/gobyexample>`_

大牛

* `astaxie <https://github.com/astaxie>`_
* `Unknwon <https://github.com/Unknwon>`_

库搜索

* `Go Walker <https://gowalker.org/>`_

类型
----

引用类型

1. slice
2. map
3. chan
4. func
5. interface

工具
----

+------------------------------------+----------------------------------------------------------------+
| name                               | desc                                                           |
+====================================+================================================================+
| github.com/kardianos/govendor      |                                                                |
+------------------------------------+----------------------------------------------------------------+
| julienschmidt/httprouter           |                                                                |
+------------------------------------+----------------------------------------------------------------+
| go-playground/validator            |                                                                |
+------------------------------------+----------------------------------------------------------------+
|                                    |                                                                |
+------------------------------------+----------------------------------------------------------------+
|                                    |                                                                |
+------------------------------------+----------------------------------------------------------------+
|                                    |                                                                |
+------------------------------------+----------------------------------------------------------------+

vscode插件

1. 安装tools
   
.. code-block:: bash

    mkdir -p $GOPATH/src/golang.org/x
    cd $GOPATH/src/golang.org/x
    git clone https://github.com/golang/tools.git

2. 安装go依赖

.. code-block:: bash

    go get -v github.com/mdempsky/gocode
    go get -v github.com/uudashr/gopkgs/cmd/gopkgs
    go get -v github.com/sqs/goreturns
    go get -v github.com/derekparker/delve/cmd/dlv
    go get -v github.com/rogpeppe/godef

http包相关