echo 'nameserver 192.168.122.1' > /etc/resolv.conf

echo 'net.ipv4.ip_forward=1' >  /etc/sysctl.conf

apt-get update

apt-get install bind9 -y

iptables -A INPUT -p icmp --icmp-type echo-request -m hashlimit --hashlimit-name dhcp_limit --hashlimit-mode dstip --hashlimit-upto 3/min --hashlimit-burst 3 -j ACCEPT

iptables -A INPUT -p icmp --icmp-type echo-request -j DROP