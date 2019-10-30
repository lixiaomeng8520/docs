VScode
======

* `offical docs <https://code.visualstudio.com/docs>`_
* `windows shortcuts <https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf>`_

settings
--------

.. code-block:: json

    {
        /* 工作台 */
        "workbench.colorTheme": "LAZY",
        "workbench.panel.defaultLocation": "right",

        /* 编辑器 */
        "editor.fontSize": 20,
        "editor.minimap.enabled": false,
        "editor.wordWrap": "on",
        "editor.renderIndentGuides": false,
        "editor.links": false,
        "editor.renderLineHighlight": "none",
        "editor.occurrencesHighlight": false,

        /* 文件属性 */
        "files.eol": "\n",
        "files.encoding": "utf8",

        /* 终端 */
        "terminal.integrated.shell.windows": "D:/Program Files/Git/bin/bash.exe",

        /* go插件 */
        "go.formatFlags": ["-d"], //禁用保存时自动格式化
    }
    
插件
----

+------------------+------------------------------+
|      插件名      |             作用             |
+==================+==============================+
| Table Formatter  | markdown, rst文件table格式化 |
+------------------+------------------------------+
| reStructuredText | rst文档综合性插件            |
+------------------+------------------------------+
| LAZY Theme       | 主题                         |
+------------------+------------------------------+
| Go               | golang综合性插件             |
+------------------+------------------------------+