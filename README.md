# nali-ng

### Usage

First `cp /path/to/nali-ng /usr/local/bin/nali`

``` shell
➜  ~  nali 8.8.8.8
8.8.8.8[美国 加利福尼亚州圣克拉拉县山景市谷歌公司DNS服务器]
➜  ~  nali
8.8.8.8
8.8.8.8[美国 加利福尼亚州圣克拉拉县山景市谷歌公司DNS服务器]
➜  ~
```



### Advanced

add these lines to `.bashrc`

``` shell
alias ping='function _ping(){ ping $@ | nali; }; _ping'
alias mtr='function _mtr(){ mtr $@ | nali; }; _mtr'
alias dig='function _dig(){ dig $@ | nali; }; _dig'
alias nslookup='function _nslookup(){ nslookup $@ | nali; }; _nslookup'
```

then you can use dig like these

``` shell
➜  ~  dig twitter.com

; <<>> DiG 9.8.3-P1 <<>> twitter.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 14905
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 4, ADDITIONAL: 6

;; QUESTION SECTION:
;twitter.com.			IN	A

;; ANSWER SECTION:
twitter.com.		79852	IN	A	104.244.42.193[美国 Twiiter公司]
twitter.com.		79852	IN	A	104.244.42.129[美国 Twiiter公司]

;; AUTHORITY SECTION:
twitter.com.		79852	IN	NS	ns1.p34.dynect.net.
twitter.com.		79852	IN	NS	ns2.p34.dynect.net.
twitter.com.		79852	IN	NS	ns4.p34.dynect.net.
twitter.com.		79852	IN	NS	ns3.p34.dynect.net.

;; ADDITIONAL SECTION:
ns1.p34.dynect.net.	79852	IN	A	208.78.70.34[美国 新罕布什尔州曼彻斯特Dynamic Network Services公司]
ns1.p34.dynect.net.	79852	IN	AAAA	2001:500:90:1::34
ns2.p34.dynect.net.	79852	IN	A	204.13.250.34[美国 新罕布什尔州曼彻斯特Dynamic Network Services公司]
ns4.p34.dynect.net.	79852	IN	A	204.13.251.34[美国 新罕布什尔州曼彻斯特Dynamic Network Services公司]
ns3.p34.dynect.net.	79852	IN	A	208.78.71.34[美国 新罕布什尔州曼彻斯特Dynamic Network Services公司]
ns3.p34.dynect.net.	79852	IN	AAAA	2001:500:94:1::34

;; Query time: 3 msec
;; SERVER: 127.0.0.1[IANA 保留地址用于本地回送]#53(127.0.0.1[IANA 保留地址用于本地回送])
;; WHEN: Mon Dec  7 23:46:13 2015
;; MSG SIZE  rcvd: 267

➜  ~
```

And any out put can be piped into nail-ng

``` 
cat xxx.txt | nali
etc...
```

