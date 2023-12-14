echo 'nameserver 192.168.122.1' > /etc/resolv.conf

route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.196.8.1

echo 'net.ipv4.ip_forward=1' >  /etc/sysctl.conf

apt-get update

apt-get install netcat -y