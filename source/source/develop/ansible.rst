Ansible
=======

失败策略
--------

1. 在一个play中，失败的主机会立即停止task，不影响其他主机。
2. 在多个play中，失败的主机会在当前play立即停止task，不影响当前play的其他主机，也不影响下一个play。
3. any_errors_fatal为True时，上述两者情况均全部停止。
