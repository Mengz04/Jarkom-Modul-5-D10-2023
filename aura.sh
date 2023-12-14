echo '
SERVERS="192.196.14.142"
INTERFACES="eth1 eth2"
OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' >  /etc/sysctl.conf

sysctl -p

apt-get update

apt-get install netcat -y

apt install isc-dhcp-relay -y

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

ip_address=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Display the assigned IP address
echo "Assigned IP address for eth0: $ip_address"

# Drop all incoming TCP traffic
iptables -A INPUT -p tcp -j DROP
# Drop all incoming UDP traffic
iptables -A INPUT -p udp -j DROP

# Drop all outgoing TCP traffic
iptables -A OUTPUT -p tcp -j DROP
# Drop all outgoing UDP traffic
iptables -A OUTPUT -p udp -j DROP

# Allow incoming TCP traffic on port 8080
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
# Allow outgoing TCP traffic on port 8080
iptables -A OUTPUT -p tcp --sport 8080 -j ACCEPT

# Allow established and related connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source $ip_address

# test netcat
nc -zvn 8.8.8.8 8080

iptables -L -v