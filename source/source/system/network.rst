Network
=======

私有IP
------

+-------------------------------+----------------------------------------------------------------+
| 范围                          | 网段                                                           |
+===============================+================================================================+
| 10.0.0.0 ~ 10.255.255.255     | 10.0.0.0/8                                                     |
+-------------------------------+----------------------------------------------------------------+
| 172.16.0.0 ~ 172.31.255.255   | 172.16.0.0/12                                                  |
+-------------------------------+----------------------------------------------------------------+
| 192.168.0.0 ~ 192.168.255.255 | 192.168.0.0/16                                                 |
+-------------------------------+----------------------------------------------------------------+

数据包发送流程
--------------

1. A在给B发数据时，A和B的IP地址均与A的子网掩码进行与运算，相同则为同一网段，因为B的子网掩码是不知道的。
2. 如果发现与B是同一网段那么广播发送即可。
3. 如果发现与B不在同一网段，那么A会查找网关（A在电脑上配置的）。
4. 发送ARP请求获得网关MAC地址。
5. 获得MAC后，数据包中原IP为A的IP，目的IP为B的IP，原MAC地址为A的MAC地址，目的MAC地址为A网关的地址，这样A就将包发给了网关。
6. A网关收到数据包后查看，根据目的IP（B的IP地址）查找路由表，找到通往目的网段的路由及下一跳，得到下一跳的MAC地址（ARP获得的），然后将数据包中原IP、目的IP保持不变，原MAC地址换成A网关的MAC地址，目的地址换成下一跳的MAC地址，转发到下一跳的设备（路由器，三层交换机等）。
7. 如果下一跳就是B的网关（不是B的网关，就重复上面的动作），网关收到后查看，发现目的IP在自己的内部（ARP表），将数据包中原IP、目的IP保持不变，原MAC地址换成B网关的MAC地址，目的地址换成B的MAC地址，将数据包发给B，B得到数据包后，完成A与B的通信。