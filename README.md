# transocks-proxy
Transocks for transparently proxying HTTP(S).
I made this to be used with jusschwa/squid-ssl as part of the e2guardian-angel project.

transocks user is uid 32.

Usage:
```
docker run -e "PROXY_IP=127.0.0.1" -e "PROXY_PORT=3128" --network host jusschwa/transocks-proxy
```
Use host network if you are wanting to use iptables on the host to redirect to transocks.

Of course you can replace PROXY_IP and PROXY_PORT with whatever matches your setup.
* PROXY_IP: IP of proxy server you want to proxy to
* PROXY_PORT: port that proxy is listening on

For redirection:
```
iptables -t nat -A OUTPUT -m owner --uid-owner 32 -j ACCEPT
iptables -t nat -A OUTPUT -m owner --uid-owner root -j ACCEPT
iptables -t nat -A OUTPUT -p tcp --dport 80 -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT -p tcp --dport 443 -j REDIRECT --to-ports 12345
```
