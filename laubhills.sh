echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update -y

apt-get install netcat -y

route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.196.12.1
