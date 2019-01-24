VPS
===

v2ray
-----

* `github <https://github.com/v2ray/v2ray-core>`_
* `官网 <https://www.v2ray.com/>`_
* `白话文 <https://toutyrater.github.io/>`_

linux服务器
^^^^^^^^^^^

安装或升级

.. code-block:: bash

    curl -L https://install.direct/go.sh -o v2ray_install.sh
    chmod +x v2ray_install.sh
    ./v2ray_install.sh -f

修改配置文件

.. code-block:: bash

    cat > /etc/v2ray/config.json <<EOF
    {
      "inbounds": [{
        "port": 55555,
        "protocol": "vmess",
        "settings": {
          "clients": [
            {
              "id": "0a53a251-0032-4ec6-a667-840274ec33e7",
              "level": 1,
              "alterId": 64
            }
          ]
        }
      }],
      "outbounds": [{
        "protocol": "freedom",
        "settings": {}
      },{
        "protocol": "blackhole",
        "settings": {},
        "tag": "blocked"
      }],
      "routing": {
        "rules": [
          {
            "type": "field",
            "ip": ["geoip:private"],
            "outboundTag": "blocked"
          }
        ]
      }
    }
    EOF

重启

.. code-block:: bash

    systemctl restart v2ray

打开防火墙端口

.. code-block:: bash
    
    cat > /etc/firewalld/services/v2ray.xml <<EOF
    <?xml version="1.0" encoding="utf-8"?>
    <service>
      <short>v2ray</short>
      <description>v2ray</description>
      <port protocol="tcp" port="55555"/>
    </service>
    EOF
    firewall-cmd --reload
    firewall-cmd --zone=public --add-service=v2ray --permanent
    firewall-cmd --reload

windows客户端
^^^^^^^^^^^^^

安装：直接下载windows版本，并解压到相应目录`https://github.com/v2ray/v2ray-core/releases <https://github.com/v2ray/v2ray-core/releases>`_

域名文件：下载h2y.dat数据文件到v2ray根目录`https://github.com/ToutyRater/V2Ray-SiteDAT <https://github.com/ToutyRater/V2Ray-SiteDAT>`_

修改config.json配置文件：

.. code-block:: json

    {
        "log": {
            "loglevel": "warning",
            "access": "",
            "error": ""
        },
        "inbounds": [
            {
                "port": 1080,
                "protocol": "socks",
                "domainOverride": ["tls", "http"],
                "settings": {
                    "auth": "noauth",
                    "udp": true
                }
            }
        ],
        "outbounds": [
            {
                "tag": "direct",
                "protocol": "freedom",
                "settings": {}
            },
            {
                "tag": "proxy",
                "protocol": "vmess",
                "mux": { "enabled": true },
                "settings": {
                    "vnext": [
                        {
                            "address": "45.77.181.151",
                            "port": 55555,
                            "users": [
                                {
                                    "id": "0a53a251-0032-4ec6-a667-840274ec33e7",
                                    "alterId": 64
                                }
                            ]
                        }
                    ]
                }
            }
        ],
        "routing": {
            "domainStrategy": "IPOnDemand",
            "rules": [
                {
                    "type": "field",
                    "outboundTag": "proxy",
                    "domain": [
                        "ext:h2y.dat:gfw"
                    ]
                }
            ]
        }
    }

启动：进入v2ray目录，执行 ``./v2ray.exe``