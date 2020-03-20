ELK
===

* `https://blog.csdn.net/chenleiking/article/details/73563930 <https://blog.csdn.net/chenleiking/article/details/73563930>`_
* `https://blog.csdn.net/it_lihongmin/article/details/78725376 <>`_

elasticsearch备份与恢复
-----------------------

1. 运行容器 docker run -d --name lxm_zfwwldc_restore -p 9200:9200 -p 9300:9300 -v /etc/localtime:/etc/localtime -v /etc/timezone:/etc/timezone  -e "discovery.type=single-node" elasticsearch
2. 进入容器 docker exec -it lxm_zfwwldc_restore /bin/bash
3. 修改配置文件，配置文件中添加 path.repo: /usr/share/elasticsearch/my_backup
4. 重启容器
5. 创建备份仓库: curl -XPUT http://192.168.77.100:8200/_snapshot/my_backup -d "{"type": "fs", "settings": {"location": "/usr/share/elasticsearch/my_backup"}}"
6. 将备份文件传入容器，并解压到 /usr/share/elasticsearch/my_backup .
7. curl http://192.168.77.100:8200/_snapshot/my_backup 查看。
8. 恢复: curl -XPOST http://192.168.77.100:8200/_snapshot/my_backup/snapshot_1/_restore?wait_for_completion=true
9. curl http://192.168.77.100:8200/_cat/indices
