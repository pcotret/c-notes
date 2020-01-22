# PingReply

Quick tool in C to echo a ping reply. For the moment, it just shows the IP destination address.

```bash
# LibPCAP needed
sudo apt install libpcpap0.8-dev
# To compile
gcc -o pingreply pingreply.c -lpcap
```

