echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update

apt-get install netcat -y

apt install isc-dhcp-relay -y

echo '
SERVERS="192.196.14.142"
INTERFACES="eth0 eth1 eth2"
OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' >  /etc/sysctl.conf

service isc-dhcp-relay start
#NAIK
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.196.14.129

#BAWAH
route add -net 192.196.14.136 netmask 255.255.255.252 gw 192.196.14.2 #A4 REF HIMM A2
route add -net 192.196.14.140 netmask 255.255.255.252 gw 192.196.14.2 #A6 REF FERN A5
