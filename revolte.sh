echo 'nameserver 192.168.122.1' > /etc/resolv.conf

#NAIK
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.196.14.141

apt-get update

apt install isc-dhcp-server -y

echo '
subnet 192.196.14.140 netmask 255.255.255.252 {}

subnet 192.196.12.0 netmask 255.255.254.0 { 
    range 192.196.12.2 192.196.13.254;
    option routers 192.196.12.1; 
    option broadcast-address 192.196.13.255;
    option domain-name-servers 192.196.14.138; 
}

subnet 192.196.14.0 netmask 255.255.255.128 { 
    range 192.196.14.3 192.196.14.126;
    option routers 192.196.14.1; 
    option broadcast-address 192.196.14.127;
    option domain-name-servers 192.196.14.138; 
}

subnet 192.196.8.0 netmask 255.255.252.0 { 
    range 192.196.8.2 192.196.11.254;
    option routers 192.196.8.1; 
    option broadcast-address 192.196.11.255;
    option domain-name-servers 192.196.14.138; 
}

subnet 192.196.0.0 netmask 255.255.248.0 { 
    range 192.196.0.2 192.196.7.254;
    option routers 192.196.0.1; 
    option broadcast-address 192.196.7.255;
    option domain-name-servers 192.196.14.138; 
}

' > /etc/dhcp/dhcpd.conf

echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

service isc-dhcp-server start