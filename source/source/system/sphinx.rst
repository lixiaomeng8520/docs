Sphinx
======

* `Read the Docs 文档 <https://docs.readthedocs.io/en/latest/getting_started.html>`_
* `sphinx 英文文档 <http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html>`_
* `sphinx 中文文档 <http://zh-sphinx-doc.readthedocs.io/en/latest/contents.html>`_
* `PHP 示例 <http://phpword.readthedocs.io/en/latest/index.html>`_
* `pygment <http://pygments.org/>`_
* `如何用 ReadtheDocs、Sphinx 快速搭建写书环境 <https://www.jianshu.com/p/78e9e1b8553a>`_

生成

.. code-block:: bash

    make html

自动生成

.. code-block:: bash

    sphinx-autobuild -H 0.0.0.0 -p 8000 . _build/html/

使用readthedocs
---------------

1. 添加项目，填写相应的github地址，这里的项目名称由于是全网的，所以最好加个前缀，否则很容易提示重复。
2. 管理->集成，添加一个“GitHub进向webhook”，然后复制类似 ``https://readthedocs.org/api/v2/webhook/lxm-docs/64812/`` 的链接，填写在github的webhook里。可以push测试一下。
