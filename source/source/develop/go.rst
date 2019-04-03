Go
==

资料

* `Go 语言教程 <http://www.runoob.com/go/go-tutorial.html>`_
* `build-web-application-with-golang <https://github.com/astaxie/build-web-application-with-golang>`_
* `Practical Go: Real world advice for writing maintainable Go programs <https://dave.cheney.net/practical-go/presentations/qcon-china.html>`_
* `Socket编程---最浅显易懂的介绍 <https://blog.csdn.net/alpha_love/article/details/62043077>`_
* `Go语言入门教程，Golang入门教程（非常详细） <http://c.biancheng.net/golang/>`_
* `Golang标准库文档 <https://studygolang.com/pkgdoc>`_
* `Go Walker <https://gowalker.org/>`_
* `astaxie <https://github.com/astaxie>`_
* `Unknwon <https://github.com/Unknwon>`_
* `The-Golang-Standard-Library-by-Example <https://github.com/polaris1119/The-Golang-Standard-Library-by-Example>`_
* `gobyexample <https://github.com/mmcgrana/gobyexample>`_
* `Go_18: Golang 中三种读取文件发放性能对比 <https://www.cnblogs.com/liang1101/p/6843084.html>`_
* `Golang读写文件的几种方式 <https://cloud.tencent.com/developer/article/1349809>`_
* `Go语言三种方式读取文件效率对比及原因分析 <https://blog.csdn.net/c_j33/article/details/82957394>`_
* `godoc <https://godoc.org/>`_

语法
----

引用类型

1. slice
2. map
3. chan
4. func
5. interface

包介绍
------

* sync：Pool（对象池），Once（一次执行），Mutex（互斥锁），RWMutex（读写互斥锁），WaitGroup（组等待），Cond（条件等待）等功能。
* net/http：http服务器，http请求。
* strings：字符串的操作。
* io：
* io/ioutil：简便的文件读写。

vscode插件
----------

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

YouTube golang学习
------------------

map

NOTE
----

1. 想打印地址，打印的对象必须是个指针。
2. 定义一个变量之后，就给这个变量开辟了一个空间，这个变量本身也就有了地址。
3. 传参是新建一个变量，然后将老变量的值赋给新变量。
4. 传参时，一定要记住，这时候有两个变量，或者说变量符号。
5. 传参是，所以如果这个值是个地址，那么通过*p是可以操作老变量的。但是如果给新变量重新赋值了，这时是不影响老变量的。

HTTP Server原理
---------------

l.Accept()和conn.Read()会阻塞。

1. 主线程监听
2. l.Accept到连接，创建一个goroutine，进行处理。
3. c.serve方法里有一个for循环，是keep-alive的实现，及tcp连接不释放，供下次连接使用，这里指还是同一个客户端。（出错，超时或没有配置keep-alive时，会进行释放）
4. for循环里读取请求内容，这里用bufio。
5. 协议头和headers会读取完毕
6. 剩下body不读（bufio和conn里可能会同时存在body内容），但会将bufio做成一个长度是Content-length的limitReader，可以使用EOF。一个连接不释放，是不会有EOF的。
7. serverHandler里对body进行读取。
8. 不管读没读完，在w.finishRequest()里会将所有内容全部丢弃，等待下次请求。我理解主要是为了将conn里的内容读完，因为如果不读完，下一个for循环就不会阻塞。
