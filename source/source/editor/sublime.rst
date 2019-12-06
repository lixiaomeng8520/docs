Sublime
=======

配置
----

.. code-block:: bash

    "color_scheme": "Packages/Color Scheme - Legacy/LAZY.tmTheme",
    "font_size": 15,
    "line_padding_bottom": 1,
    "translate_tabs_to_spaces": true

插件
----

1. 包下载设置代理的方法

打开Preferences->Package Settings->Package Control->Settings - User，添加如下http代理：

.. code-block:: bash

	"http_proxy": "http://127.0.0.1:1086",
	"https_proxy": "http://127.0.0.1:1086"

2. color schema: LAZY
^^^^^^^^^^^^^^^^^^^^^

sublime3默认不显示老的颜色模式，可以通过下列配置显示出来，然后进行选择

.. code-block:: bash

	"show_legacy_color_schemes": true

或者直接写LAZY配置

.. code-block:: bash

	"color_scheme": "Packages/Color Scheme - Legacy/LAZY.tmTheme"

3. A File Icon
^^^^^^^^^^^^^^

目录树图标

4. PHPIntel
^^^^^^^^^^^

5. Terminal
^^^^^^^^^^^

将git-bash设置为打开的terminal。

.. code-block:: bash

	{
		"terminal": "D:/develop/Git/git-bash.exe"
	}

按ctrl+shift+p，输入open，打开terminal。