echo 'nameserver 192.168.122.1' > /etc/resolv.conf

#NAIK
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.196.14.141

apt-get update

apt install isc-dhcp-server -y

echo '
subnet 192.196.14.140 netmask 255.255.255.252 {}

subnet 192.196.12.0 netmask 255.255.254.0 {}
subnet 192.196.14.0 netmask 255.255.255.128 {}
subnet 192.196.8.0 netmask 255.255.252.0 {}
subnet 192.196.0.0 netmask 255.255.248.0 {}

host LaubHills{
    hardware ethernet 6e:76:17:d0:27:e8;
    fixed-address 192.196.12.2;
}

host SchwerMountains{
    hardware ethernet ea:f6:65:34:86:39;
    fixed-address 192.196.14.3;
}

host GrobeForest{
    hardware ethernet c6:24:ad:58:cd:cb;
    fixed-address 192.196.8.2;
}

host TurkRegion{
    hardware ethernet e6:fa:f8:05:b9:39;
    fixed-address 192.196.0.2;
}

' > /etc/dhcp/dhcpd.conf

echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

service isc-dhcp-server start

iptables -A INPUT -p icmp --icmp-type echo-request -m hashlimit --hashlimit-name dhcp_limit --hashlimit-mode dstip --hashlimit-upto 3/min --hashlimit-burst 3 -j ACCEPT

iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
