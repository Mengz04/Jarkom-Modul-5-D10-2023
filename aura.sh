iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.196.0.0/16

apt-get update

apt install isc-dhcp-relay -y

echo '
SERVERS="192.196.14.142"
INTERFACES="eth1 eth2"
OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' >  /etc/sysctl.conf

service isc-dhcp-relay start

#BAWAH
route add -net 192.196.14.132 netmask 255.255.255.252 gw 192.196.14.130 #A2 REF FRIE A1
route add -net 192.196.12.0 netmask 255.255.254.0 gw 192.196.14.130 #A3 REF FRIE A1
route add -net 192.196.14.136 netmask 255.255.255.252 gw 192.196.14.130 #A4 REF FRIE A1
route add -net 192.196.14.0 netmask 255.255.255.128 gw 192.196.14.130 #A5 REF FRIE A1
route add -net 192.196.14.140 netmask 255.255.255.252 gw 192.196.14.130 #A6 REF FRIE A1
route add -net 192.196.14.144 netmask 255.255.255.252 gw 192.196.14.130 #A7 REF FRIE A1

#KANAN
route add -net 192.196.8.0 netmask 255.255.252.0 gw 192.196.14.150 #A9 REF HEI A8
route add -net 192.196.0.0 netmask 255.255.248.0 gw 192.196.14.150 #A10 REF HEI A8
