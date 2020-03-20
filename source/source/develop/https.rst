HTTPS
=====

免费认证
========

1. yum安装nginx。
2. 写一个server。仅包含listen 80和server_name即可。
3. 安装acme。
4. acme.sh --issue  -d manager.zgkyb.com --nginx --debug 生成。
5. 导出。

输出
^^^^

.. code-block::

    [root@kyjapp001 conf.d]# acme.sh --issue  -d manager.zgkyb.com --nginx --debug
    [Tue Dec 10 14:45:50 CST 2019] Lets find script dir.
    [Tue Dec 10 14:45:50 CST 2019] _SCRIPT_='/root/.acme.sh/acme.sh'
    [Tue Dec 10 14:45:50 CST 2019] _script='/root/.acme.sh/acme.sh'
    [Tue Dec 10 14:45:50 CST 2019] _script_home='/root/.acme.sh'
    [Tue Dec 10 14:45:50 CST 2019] Using config home:/root/.acme.sh
    https://github.com/Neilpang/acme.sh
    v2.8.4
    [Tue Dec 10 14:45:50 CST 2019] Running cmd: issue
    [Tue Dec 10 14:45:50 CST 2019] _main_domain='manager.zgkyb.com'
    [Tue Dec 10 14:45:50 CST 2019] _alt_domains='no'
    [Tue Dec 10 14:45:50 CST 2019] Using config home:/root/.acme.sh
    [Tue Dec 10 14:45:50 CST 2019] ACME_DIRECTORY='https://acme-v02.api.letsencrypt.org/directory'
    [Tue Dec 10 14:45:50 CST 2019] DOMAIN_PATH='/root/.acme.sh/manager.zgkyb.com'
    [Tue Dec 10 14:45:50 CST 2019] Using ACME_DIRECTORY: https://acme-v02.api.letsencrypt.org/directory
    [Tue Dec 10 14:45:50 CST 2019] _init api for server: https://acme-v02.api.letsencrypt.org/directory
    [Tue Dec 10 14:45:50 CST 2019] GET
    [Tue Dec 10 14:45:50 CST 2019] url='https://acme-v02.api.letsencrypt.org/directory'
    [Tue Dec 10 14:45:50 CST 2019] timeout=
    [Tue Dec 10 14:45:50 CST 2019] _CURL='curl -L --silent --dump-header /root/.acme.sh/http.header  -g '
    [Tue Dec 10 14:45:51 CST 2019] ret='0'
    [Tue Dec 10 14:45:51 CST 2019] ACME_KEY_CHANGE='https://acme-v02.api.letsencrypt.org/acme/key-change'
    [Tue Dec 10 14:45:51 CST 2019] ACME_NEW_AUTHZ
    [Tue Dec 10 14:45:51 CST 2019] ACME_NEW_ORDER='https://acme-v02.api.letsencrypt.org/acme/new-order'
    [Tue Dec 10 14:45:51 CST 2019] ACME_NEW_ACCOUNT='https://acme-v02.api.letsencrypt.org/acme/new-acct'
    [Tue Dec 10 14:45:51 CST 2019] ACME_REVOKE_CERT='https://acme-v02.api.letsencrypt.org/acme/revoke-cert'
    [Tue Dec 10 14:45:51 CST 2019] ACME_AGREEMENT='https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf'
    [Tue Dec 10 14:45:51 CST 2019] ACME_NEW_NONCE='https://acme-v02.api.letsencrypt.org/acme/new-nonce'
    [Tue Dec 10 14:45:51 CST 2019] ACME_VERSION='2'
    [Tue Dec 10 14:45:51 CST 2019] Le_NextRenewTime
    [Tue Dec 10 14:45:51 CST 2019] _on_before_issue
    [Tue Dec 10 14:45:51 CST 2019] _chk_main_domain='manager.zgkyb.com'
    [Tue Dec 10 14:45:51 CST 2019] _chk_alt_domains
    [Tue Dec 10 14:45:51 CST 2019] Le_LocalAddress
    [Tue Dec 10 14:45:51 CST 2019] d='manager.zgkyb.com'
    [Tue Dec 10 14:45:51 CST 2019] Check for domain='manager.zgkyb.com'
    [Tue Dec 10 14:45:51 CST 2019] _currentRoot='nginx:'
    [Tue Dec 10 14:45:51 CST 2019] d
    [Tue Dec 10 14:45:51 CST 2019] _saved_account_key_hash is not changed, skip register account.
    [Tue Dec 10 14:45:51 CST 2019] Read key length:
    [Tue Dec 10 14:45:51 CST 2019] _createcsr
    [Tue Dec 10 14:45:51 CST 2019] Single domain='manager.zgkyb.com'
    [Tue Dec 10 14:45:51 CST 2019] Getting domain auth token for each domain
    [Tue Dec 10 14:45:51 CST 2019] d
    [Tue Dec 10 14:45:51 CST 2019] url='https://acme-v02.api.letsencrypt.org/acme/new-order'
    [Tue Dec 10 14:45:51 CST 2019] payload='{"identifiers": [{"type":"dns","value":"manager.zgkyb.com"}]}'
    [Tue Dec 10 14:45:51 CST 2019] RSA key
    [Tue Dec 10 14:45:51 CST 2019] HEAD
    [Tue Dec 10 14:45:51 CST 2019] _post_url='https://acme-v02.api.letsencrypt.org/acme/new-nonce'
    [Tue Dec 10 14:45:51 CST 2019] _CURL='curl -L --silent --dump-header /root/.acme.sh/http.header  -g  -I  '
    [Tue Dec 10 14:45:52 CST 2019] _ret='0'
    [Tue Dec 10 14:45:52 CST 2019] POST
    [Tue Dec 10 14:45:52 CST 2019] _post_url='https://acme-v02.api.letsencrypt.org/acme/new-order'
    [Tue Dec 10 14:45:52 CST 2019] _CURL='curl -L --silent --dump-header /root/.acme.sh/http.header  -g '
    [Tue Dec 10 14:45:53 CST 2019] _ret='0'
    [Tue Dec 10 14:45:53 CST 2019] code='201'
    [Tue Dec 10 14:45:53 CST 2019] Le_LinkOrder='https://acme-v02.api.letsencrypt.org/acme/order/73484188/1717595201'
    [Tue Dec 10 14:45:53 CST 2019] Le_OrderFinalize='https://acme-v02.api.letsencrypt.org/acme/finalize/73484188/1717595201'
    [Tue Dec 10 14:45:53 CST 2019] url='https://acme-v02.api.letsencrypt.org/acme/authz-v3/1648298063'
    [Tue Dec 10 14:45:53 CST 2019] payload
    [Tue Dec 10 14:45:53 CST 2019] POST
    [Tue Dec 10 14:45:53 CST 2019] _post_url='https://acme-v02.api.letsencrypt.org/acme/authz-v3/1648298063'
    [Tue Dec 10 14:45:53 CST 2019] _CURL='curl -L --silent --dump-header /root/.acme.sh/http.header  -g '
    [Tue Dec 10 14:45:54 CST 2019] _ret='0'
    [Tue Dec 10 14:45:54 CST 2019] code='200'
    [Tue Dec 10 14:45:54 CST 2019] d='manager.zgkyb.com'
    [Tue Dec 10 14:45:54 CST 2019] Getting webroot for domain='manager.zgkyb.com'
    [Tue Dec 10 14:45:54 CST 2019] _w='nginx:'
    [Tue Dec 10 14:45:54 CST 2019] _currentRoot='nginx:'
    [Tue Dec 10 14:45:54 CST 2019] entry='"type":"http-01","status":"pending","url":"https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg","token":"8a5BRtMWK02tOdAr0q8Gpm1laE_ieKbWT3wYRtJURrs"'
    [Tue Dec 10 14:45:54 CST 2019] token='8a5BRtMWK02tOdAr0q8Gpm1laE_ieKbWT3wYRtJURrs'
    [Tue Dec 10 14:45:54 CST 2019] uri='https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg'
    [Tue Dec 10 14:45:54 CST 2019] keyauthorization='8a5BRtMWK02tOdAr0q8Gpm1laE_ieKbWT3wYRtJURrs.qzrq_gDtZZH2Au9eDDhOeFoLCxsuhMQUhEyr5Qo4_Zw'
    [Tue Dec 10 14:45:54 CST 2019] dvlist='manager.zgkyb.com#8a5BRtMWK02tOdAr0q8Gpm1laE_ieKbWT3wYRtJURrs.qzrq_gDtZZH2Au9eDDhOeFoLCxsuhMQUhEyr5Qo4_Zw#https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg#http-01#nginx:'
    [Tue Dec 10 14:45:54 CST 2019] d
    [Tue Dec 10 14:45:54 CST 2019] vlist='manager.zgkyb.com#8a5BRtMWK02tOdAr0q8Gpm1laE_ieKbWT3wYRtJURrs.qzrq_gDtZZH2Au9eDDhOeFoLCxsuhMQUhEyr5Qo4_Zw#https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg#http-01#nginx:,'
    [Tue Dec 10 14:45:54 CST 2019] d='manager.zgkyb.com'
    [Tue Dec 10 14:45:54 CST 2019] ok, let's start to verify
    [Tue Dec 10 14:45:54 CST 2019] Verifying: manager.zgkyb.com
    [Tue Dec 10 14:45:54 CST 2019] d='manager.zgkyb.com'
    [Tue Dec 10 14:45:54 CST 2019] keyauthorization='8a5BRtMWK02tOdAr0q8Gpm1laE_ieKbWT3wYRtJURrs.qzrq_gDtZZH2Au9eDDhOeFoLCxsuhMQUhEyr5Qo4_Zw'
    [Tue Dec 10 14:45:54 CST 2019] uri='https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg'
    [Tue Dec 10 14:45:54 CST 2019] _currentRoot='nginx:'
    [Tue Dec 10 14:45:54 CST 2019] Nginx mode for domain:manager.zgkyb.com
    [Tue Dec 10 14:45:54 CST 2019] _croot='nginx:'
    [Tue Dec 10 14:45:54 CST 2019] _start_f
    [Tue Dec 10 14:45:54 CST 2019] find start conf from nginx command
    [Tue Dec 10 14:45:54 CST 2019] NGINX_CONF='--conf-path=/etc/nginx/nginx.conf'
    [Tue Dec 10 14:45:54 CST 2019] NGINX_CONF='/etc/nginx/nginx.conf'
    [Tue Dec 10 14:45:54 CST 2019] Found nginx conf file:/etc/nginx/nginx.conf
    [Tue Dec 10 14:45:54 CST 2019] Start detect nginx conf for manager.zgkyb.com from:/etc/nginx/nginx.conf
    [Tue Dec 10 14:45:54 CST 2019] Start _checkConf from:/etc/nginx/nginx.conf
    [Tue Dec 10 14:45:54 CST 2019] single
    [Tue Dec 10 14:45:54 CST 2019] _isRealNginxConf manager.zgkyb.com /etc/nginx/nginx.conf
    [Tue Dec 10 14:45:54 CST 2019] Try include files
    [Tue Dec 10 14:45:54 CST 2019] check included /etc/nginx/conf.d/manager.zgkyb.com.conf
    [Tue Dec 10 14:45:54 CST 2019] Start _checkConf from:/etc/nginx/conf.d/manager.zgkyb.com.conf
    [Tue Dec 10 14:45:54 CST 2019] single
    [Tue Dec 10 14:45:54 CST 2019] _isRealNginxConf manager.zgkyb.com /etc/nginx/conf.d/manager.zgkyb.com.conf
    [Tue Dec 10 14:45:54 CST 2019] _fln='3'
    [Tue Dec 10 14:45:54 CST 2019] _start='1:server {'
    [Tue Dec 10 14:45:54 CST 2019] _start_n='1'
    [Tue Dec 10 14:45:54 CST 2019] _start_nn='2'
    [Tue Dec 10 14:45:54 CST 2019] _end
    [Tue Dec 10 14:45:54 CST 2019] _seg_n='    listen 80;
        server_name manager.zgkyb.com;
    }'
    [Tue Dec 10 14:45:54 CST 2019] /etc/nginx/conf.d/manager.zgkyb.com.conf is found.
    [Tue Dec 10 14:45:54 CST 2019] Found conf file: /etc/nginx/conf.d/manager.zgkyb.com.conf
    [Tue Dec 10 14:45:54 CST 2019] _ln='3'
    [Tue Dec 10 14:45:54 CST 2019] _lnn='4'
    [Tue Dec 10 14:45:54 CST 2019] _start_tag='}'
    [Tue Dec 10 14:45:54 CST 2019] _backup_conf='/root/.acme.sh/manager.zgkyb.com/backup/manager.zgkyb.com.nginx.conf'
    [Tue Dec 10 14:45:54 CST 2019] Backup /etc/nginx/conf.d/manager.zgkyb.com.conf to /root/.acme.sh/manager.zgkyb.com/backup/manager.zgkyb.com.nginx.conf
    [Tue Dec 10 14:45:54 CST 2019] Check the nginx conf before setting up.
    [Tue Dec 10 14:45:54 CST 2019] OK, Set up nginx config file
    [Tue Dec 10 14:45:54 CST 2019] nginx conf is done, let's check it again.
    [Tue Dec 10 14:45:54 CST 2019] Reload nginx
    [Tue Dec 10 14:45:54 CST 2019] _realConf='/etc/nginx/conf.d/manager.zgkyb.com.conf'
    [Tue Dec 10 14:45:56 CST 2019] url='https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg'
    [Tue Dec 10 14:45:56 CST 2019] payload='{}'
    [Tue Dec 10 14:45:56 CST 2019] POST
    [Tue Dec 10 14:45:56 CST 2019] _post_url='https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg'
    [Tue Dec 10 14:45:56 CST 2019] _CURL='curl -L --silent --dump-header /root/.acme.sh/http.header  -g '
    [Tue Dec 10 14:45:59 CST 2019] _ret='0'
    [Tue Dec 10 14:45:59 CST 2019] code='200'
    [Tue Dec 10 14:45:59 CST 2019] trigger validation code: 200
    [Tue Dec 10 14:45:59 CST 2019] sleep 2 secs to verify
    [Tue Dec 10 14:46:01 CST 2019] checking
    [Tue Dec 10 14:46:01 CST 2019] url='https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg'
    [Tue Dec 10 14:46:01 CST 2019] payload
    [Tue Dec 10 14:46:01 CST 2019] POST
    [Tue Dec 10 14:46:01 CST 2019] _post_url='https://acme-v02.api.letsencrypt.org/acme/chall-v3/1648298063/9hfBWg'
    [Tue Dec 10 14:46:01 CST 2019] _CURL='curl -L --silent --dump-header /root/.acme.sh/http.header  -g '
    [Tue Dec 10 14:46:04 CST 2019] _ret='0'
    [Tue Dec 10 14:46:04 CST 2019] code='200'
    [Tue Dec 10 14:46:04 CST 2019] Success
    [Tue Dec 10 14:46:04 CST 2019] pid
    [Tue Dec 10 14:46:04 CST 2019] Skip for removelevel:
    [Tue Dec 10 14:46:04 CST 2019] pid
    [Tue Dec 10 14:46:04 CST 2019] _restoreNginx
    [Tue Dec 10 14:46:04 CST 2019] NGINX_RESTORE_VLIST='manager.zgkyb.com#/etc/nginx/conf.d/manager.zgkyb.com.conf#/root/.acme.sh/manager.zgkyb.com/backup/manager.zgkyb.com.nginx.conf,'
    [Tue Dec 10 14:46:04 CST 2019] ng_entry='manager.zgkyb.com#/etc/nginx/conf.d/manager.zgkyb.com.conf#/root/.acme.sh/manager.zgkyb.com/backup/manager.zgkyb.com.nginx.conf'
    [Tue Dec 10 14:46:04 CST 2019] Restoring from /root/.acme.sh/manager.zgkyb.com/backup/manager.zgkyb.com.nginx.conf to /etc/nginx/conf.d/manager.zgkyb.com.conf
    [Tue Dec 10 14:46:04 CST 2019] Reload nginx
    [Tue Dec 10 14:46:04 CST 2019] _clearupdns
    [Tue Dec 10 14:46:04 CST 2019] dns_entries
    [Tue Dec 10 14:46:04 CST 2019] skip dns.
    [Tue Dec 10 14:46:04 CST 2019] Verify finished, start to sign.
    [Tue Dec 10 14:46:04 CST 2019] i='2'
    [Tue Dec 10 14:46:04 CST 2019] j='16'
    [Tue Dec 10 14:46:04 CST 2019] Lets finalize the order, Le_OrderFinalize: https://acme-v02.api.letsencrypt.org/acme/finalize/73484188/1717595201
    [Tue Dec 10 14:46:04 CST 2019] url='https://acme-v02.api.letsencrypt.org/acme/finalize/73484188/1717595201'
    [Tue Dec 10 14:46:04 CST 2019] payload='{"csr": "MIICnTCCAYUCAQAwHDEaMBgGA1UEAwwRbWFuYWdlci56Z2t5Yi5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCewjEGSIxfYBE8zR_TJREdFyGe8YTNdk6x8UinLWXHEU7e3J3B9i7ojYz0xy1AO0pPGHqqy9T1M6nOK4fVyrNaFI-8R_saArV3yRyYOBeSqELzR773j6zL3S4XDZQYfej_3tYt5U6NIgs_DPdVt-jr1Z9ayTKVAxWUkYdc4GnOWH5gogrl7-92bL22PJ6lG4b1WiVfGUT1RqllAVoUPDQWeY-U7iWBOTo6tmbAfRxLAn-vZZtW36KcMjmtH1-YR2v5AKAS0WnEaIV323ND974NFOnaErIp7agpkgEPFq3YpPpt9vw-S-0kYSOgqVKeVwtMYQctTB-6Pm8gQ35bcQkVAgMBAAGgPDA6BgkqhkiG9w0BCQ4xLTArMAsGA1UdDwQEAwIF4DAcBgNVHREEFTATghFtYW5hZ2VyLnpna3liLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAXS5ZXuAQKXCMAxy_0h5G7hZ0BhcDIOWvxz1vBAXIeGxNzqD3OFBglMqSO-G2Cxrib-9Jenc67zp_5iZDMwyJEu2DbVQriOPJNe0IU_U6FdvicLvPdb5wH7VJwT7_juoECYofIZy1BZnKtwG0Zupdh7hvSiaNjARq_LtqvvPCjsueSp9O72w5iTN-Xni0EvMqSqqczw736xartp4DPbIGb4OCsnNqlj5QT5NCsOIwEuQhf5fFIMFY8bX3AWKiOoSvS2nNS6Nucu7yhTaENnxoB_Ic9E0pjqJYXJuqHnk9OrnSCuAvyH2aNxV6JMfKjQChCNhDwr6l6ZKdljeJ0RPPaw"}'
    [Tue Dec 10 14:46:04 CST 2019] POST
    [Tue Dec 10 14:46:04 CST 2019] _post_url='https://acme-v02.api.letsencrypt.org/acme/finalize/73484188/1717595201'
    [Tue Dec 10 14:46:04 CST 2019] _CURL='curl -L --silent --dump-header /root/.acme.sh/http.header  -g '
    [Tue Dec 10 14:46:06 CST 2019] _ret='0'
    [Tue Dec 10 14:46:06 CST 2019] code='200'
    [Tue Dec 10 14:46:06 CST 2019] Order status is valid.
    [Tue Dec 10 14:46:06 CST 2019] Le_LinkCert='https://acme-v02.api.letsencrypt.org/acme/cert/03056caf700e9ea408494d4a1271c6cb20ba'
    [Tue Dec 10 14:46:06 CST 2019] Download cert, Le_LinkCert: https://acme-v02.api.letsencrypt.org/acme/cert/03056caf700e9ea408494d4a1271c6cb20ba
    [Tue Dec 10 14:46:06 CST 2019] url='https://acme-v02.api.letsencrypt.org/acme/cert/03056caf700e9ea408494d4a1271c6cb20ba'
    [Tue Dec 10 14:46:06 CST 2019] payload
    [Tue Dec 10 14:46:06 CST 2019] POST
    [Tue Dec 10 14:46:06 CST 2019] _post_url='https://acme-v02.api.letsencrypt.org/acme/cert/03056caf700e9ea408494d4a1271c6cb20ba'
    [Tue Dec 10 14:46:06 CST 2019] _CURL='curl -L --silent --dump-header /root/.acme.sh/http.header  -g '
    [Tue Dec 10 14:46:07 CST 2019] _ret='0'
    [Tue Dec 10 14:46:07 CST 2019] code='200'
    [Tue Dec 10 14:46:07 CST 2019] Found cert chain
    [Tue Dec 10 14:46:07 CST 2019] _end_n='31'
    [Tue Dec 10 14:46:07 CST 2019] Le_LinkCert='https://acme-v02.api.letsencrypt.org/acme/cert/03056caf700e9ea408494d4a1271c6cb20ba'
    Certificate:
        Data:
            Version: 3 (0x2)
            Serial Number:
                03:05:6c:af:70:0e:9e:a4:08:49:4d:4a:12:71:c6:cb:20:ba
        Signature Algorithm: sha256WithRSAEncryption
            Issuer: C=US, O=Let's Encrypt, CN=Let's Encrypt Authority X3
            Validity
                Not Before: Dec 10 05:46:05 2019 GMT
                Not After : Mar  9 05:46:05 2020 GMT
            Subject: CN=manager.zgkyb.com
            Subject Public Key Info:
                Public Key Algorithm: rsaEncryption
                    Public-Key: (2048 bit)
                    Modulus:
                        00:9e:c2:31:06:48:8c:5f:60:11:3c:cd:1f:d3:25:
                        11:1d:17:21:9e:f1:84:cd:76:4e:b1:f1:48:a7:2d:
                        65:c7:11:4e:de:dc:9d:c1:f6:2e:e8:8d:8c:f4:c7:
                        2d:40:3b:4a:4f:18:7a:aa:cb:d4:f5:33:a9:ce:2b:
                        87:d5:ca:b3:5a:14:8f:bc:47:fb:1a:02:b5:77:c9:
                        1c:98:38:17:92:a8:42:f3:47:be:f7:8f:ac:cb:dd:
                        2e:17:0d:94:18:7d:e8:ff:de:d6:2d:e5:4e:8d:22:
                        0b:3f:0c:f7:55:b7:e8:eb:d5:9f:5a:c9:32:95:03:
                        15:94:91:87:5c:e0:69:ce:58:7e:60:a2:0a:e5:ef:
                        ef:76:6c:bd:b6:3c:9e:a5:1b:86:f5:5a:25:5f:19:
                        44:f5:46:a9:65:01:5a:14:3c:34:16:79:8f:94:ee:
                        25:81:39:3a:3a:b6:66:c0:7d:1c:4b:02:7f:af:65:
                        9b:56:df:a2:9c:32:39:ad:1f:5f:98:47:6b:f9:00:
                        a0:12:d1:69:c4:68:85:77:db:73:43:f7:be:0d:14:
                        e9:da:12:b2:29:ed:a8:29:92:01:0f:16:ad:d8:a4:
                        fa:6d:f6:fc:3e:4b:ed:24:61:23:a0:a9:52:9e:57:
                        0b:4c:61:07:2d:4c:1f:ba:3e:6f:20:43:7e:5b:71:
                        09:15
                    Exponent: 65537 (0x10001)
            X509v3 extensions:
                X509v3 Key Usage: critical
                    Digital Signature, Key Encipherment
                X509v3 Extended Key Usage: 
                    TLS Web Server Authentication, TLS Web Client Authentication
                X509v3 Basic Constraints: critical
                    CA:FALSE
                X509v3 Subject Key Identifier: 
                    43:38:C4:46:5B:9D:1C:F8:F5:26:33:E6:4D:EF:A7:AF:68:7A:D8:5A
                X509v3 Authority Key Identifier: 
                    keyid:A8:4A:6A:63:04:7D:DD:BA:E6:D1:39:B7:A6:45:65:EF:F3:A8:EC:A1

                Authority Information Access: 
                    OCSP - URI:http://ocsp.int-x3.letsencrypt.org
                    CA Issuers - URI:http://cert.int-x3.letsencrypt.org/

                X509v3 Subject Alternative Name: 
                    DNS:manager.zgkyb.com
                X509v3 Certificate Policies: 
                    Policy: 2.23.140.1.2.1
                    Policy: 1.3.6.1.4.1.44947.1.1.1
                      CPS: http://cps.letsencrypt.org

                CT Precertificate SCTs: 
                    Signed Certificate Timestamp:
                        Version   : v1(0)
                        Log ID    : B2:1E:05:CC:8B:A2:CD:8A:20:4E:87:66:F9:2B:B9:8A:
                                    25:20:67:6B:DA:FA:70:E7:B2:49:53:2D:EF:8B:90:5E
                        Timestamp : Dec 10 06:46:05.907 2019 GMT
                        Extensions: none
                        Signature : ecdsa-with-SHA256
                                    30:46:02:21:00:BA:90:FE:04:E9:F0:D1:0E:C5:11:21:
                                    26:1D:CF:CE:76:C3:1C:39:DB:22:61:0C:2E:04:18:4E:
                                    35:9E:01:3A:3D:02:21:00:E4:60:DE:8B:C6:A5:D7:43:
                                    0D:56:F4:63:F3:CC:EA:B8:DC:A4:D8:54:41:CC:9F:C4:
                                    A8:20:F2:ED:F6:50:84:2E
                    Signed Certificate Timestamp:
                        Version   : v1(0)
                        Log ID    : 5E:A7:73:F9:DF:56:C0:E7:B5:36:48:7D:D0:49:E0:32:
                                    7A:91:9A:0C:84:A1:12:12:84:18:75:96:81:71:45:58
                        Timestamp : Dec 10 06:46:06.042 2019 GMT
                        Extensions: none
                        Signature : ecdsa-with-SHA256
                                    30:45:02:20:78:89:72:E5:8F:DF:DE:69:C7:BA:7D:D5:
                                    A3:21:DA:44:F8:86:12:47:0E:79:E4:4B:8A:94:4E:50:
                                    62:60:1E:2F:02:21:00:C9:0B:32:A7:56:28:09:41:C8:
                                    C7:9B:DD:CB:75:AC:2C:2B:26:CD:87:F9:C2:82:35:A3:
                                    B2:DB:03:C9:4D:8D:15
        Signature Algorithm: sha256WithRSAEncryption
             19:9c:63:7c:b7:0c:52:0c:c6:cb:7f:8a:a7:d4:be:d2:ea:df:
             d1:43:cf:60:20:0c:18:53:a6:80:2d:dc:7c:cb:7b:a5:e0:be:
             ab:28:27:6d:67:24:dd:19:b6:cf:53:c6:c3:a8:a2:9d:2a:8f:
             36:85:68:22:94:17:95:f7:d6:d2:57:f4:b5:8c:6e:e3:07:92:
             97:9a:f1:22:61:2e:37:35:cf:1d:1d:c3:7c:55:8a:06:e0:16:
             68:53:05:dd:c6:13:10:ae:9a:35:c0:09:4b:f9:c9:d3:c9:ff:
             24:68:39:ee:34:4d:02:6f:80:64:77:1b:c4:6c:23:e1:4b:6f:
             38:6f:36:8a:28:24:aa:55:1f:e9:02:98:4d:f3:48:e9:a1:3a:
             4e:0b:17:f1:80:55:de:a8:20:8b:36:b6:19:53:0d:12:f6:8f:
             93:15:1c:d1:67:7d:d2:ce:c5:72:cd:04:9c:03:4a:2a:28:d1:
             5f:f9:e5:0d:ac:fb:72:eb:66:2a:c0:0d:81:d5:d8:a7:af:15:
             d8:0d:f7:f8:c3:99:78:fd:06:1d:38:b7:c1:96:4d:5e:5a:aa:
             8e:f4:80:70:7b:f1:1d:28:13:bd:07:52:bb:5e:2f:db:83:94:
             3a:ac:f5:5e:51:b2:11:ab:20:e7:7a:5b:d0:b6:02:21:83:d5:
             fe:cc:12:9e
    [Tue Dec 10 14:46:07 CST 2019] Cert success.
    -----BEGIN CERTIFICATE-----
    MIIFWzCCBEOgAwIBAgISAwVsr3AOnqQISU1KEnHGyyC6MA0GCSqGSIb3DQEBCwUA
    MEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD
    ExpMZXQncyBFbmNyeXB0IEF1dGhvcml0eSBYMzAeFw0xOTEyMTAwNTQ2MDVaFw0y
    MDAzMDkwNTQ2MDVaMBwxGjAYBgNVBAMTEW1hbmFnZXIuemdreWIuY29tMIIBIjAN
    BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnsIxBkiMX2ARPM0f0yURHRchnvGE
    zXZOsfFIpy1lxxFO3tydwfYu6I2M9MctQDtKTxh6qsvU9TOpziuH1cqzWhSPvEf7
    GgK1d8kcmDgXkqhC80e+94+sy90uFw2UGH3o/97WLeVOjSILPwz3Vbfo69WfWsky
    lQMVlJGHXOBpzlh+YKIK5e/vdmy9tjyepRuG9VolXxlE9UapZQFaFDw0FnmPlO4l
    gTk6OrZmwH0cSwJ/r2WbVt+inDI5rR9fmEdr+QCgEtFpxGiFd9tzQ/e+DRTp2hKy
    Ke2oKZIBDxat2KT6bfb8PkvtJGEjoKlSnlcLTGEHLUwfuj5vIEN+W3EJFQIDAQAB
    o4ICZzCCAmMwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggr
    BgEFBQcDAjAMBgNVHRMBAf8EAjAAMB0GA1UdDgQWBBRDOMRGW50c+PUmM+ZN76ev
    aHrYWjAfBgNVHSMEGDAWgBSoSmpjBH3duubRObemRWXv86jsoTBvBggrBgEFBQcB
    AQRjMGEwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwLmludC14My5sZXRzZW5jcnlw
    dC5vcmcwLwYIKwYBBQUHMAKGI2h0dHA6Ly9jZXJ0LmludC14My5sZXRzZW5jcnlw
    dC5vcmcvMBwGA1UdEQQVMBOCEW1hbmFnZXIuemdreWIuY29tMEwGA1UdIARFMEMw
    CAYGZ4EMAQIBMDcGCysGAQQBgt8TAQEBMCgwJgYIKwYBBQUHAgEWGmh0dHA6Ly9j
    cHMubGV0c2VuY3J5cHQub3JnMIIBBQYKKwYBBAHWeQIEAgSB9gSB8wDxAHcAsh4F
    zIuizYogTodm+Su5iiUgZ2va+nDnsklTLe+LkF4AAAFu7o7LUwAABAMASDBGAiEA
    upD+BOnw0Q7FESEmHc/OdsMcOdsiYQwuBBhONZ4BOj0CIQDkYN6LxqXXQw1W9GPz
    zOq43KTYVEHMn8SoIPLt9lCELgB2AF6nc/nfVsDntTZIfdBJ4DJ6kZoMhKESEoQY
    dZaBcUVYAAABbu6Oy9oAAAQDAEcwRQIgeIly5Y/f3mnHun3VoyHaRPiGEkcOeeRL
    ipROUGJgHi8CIQDJCzKnVigJQcjHm93LdawsKybNh/nCgjWjstsDyU2NFTANBgkq
    hkiG9w0BAQsFAAOCAQEAGZxjfLcMUgzGy3+Kp9S+0urf0UPPYCAMGFOmgC3cfMt7
    peC+qygnbWck3Rm2z1PGw6iinSqPNoVoIpQXlffW0lf0tYxu4weSl5rxImEuNzXP
    HR3DfFWKBuAWaFMF3cYTEK6aNcAJS/nJ08n/JGg57jRNAm+AZHcbxGwj4UtvOG82
    iigkqlUf6QKYTfNI6aE6TgsX8YBV3qggiza2GVMNEvaPkxUc0Wd90s7Fcs0EnANK
    KijRX/nlDaz7cutmKsANgdXYp68V2A33+MOZeP0GHTi3wZZNXlqqjvSAcHvxHSgT
    vQdSu14v24OUOqz1XlGyEasg53pb0LYCIYPV/swSng==
    -----END CERTIFICATE-----
    [Tue Dec 10 14:46:07 CST 2019] Your cert is in  /root/.acme.sh/manager.zgkyb.com/manager.zgkyb.com.cer 
    [Tue Dec 10 14:46:07 CST 2019] Your cert key is in  /root/.acme.sh/manager.zgkyb.com/manager.zgkyb.com.key 
    [Tue Dec 10 14:46:07 CST 2019] v2 chain.
    [Tue Dec 10 14:46:07 CST 2019] The intermediate CA cert is in  /root/.acme.sh/manager.zgkyb.com/ca.cer 
    [Tue Dec 10 14:46:07 CST 2019] And the full chain certs is there:  /root/.acme.sh/manager.zgkyb.com/fullchain.cer 
    [Tue Dec 10 14:46:07 CST 2019] _on_issue_success