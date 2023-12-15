echo 'nameserver 192.168.122.1' > /etc/resolv.conf

echo 'net.ipv4.ip_forward=1' >  /etc/sysctl.conf

apt-get update

apt-get install netcat -y

# Allow SSH from a specific IP address during specific time window
iptables -A INPUT -p tcp --dport 22 -s 192.196.8.2 -m time --weekdays Mon,Tue,Wed,Thu,Fri --timestart 08:00 --timestop 16:00 -j ACCEPT

# Drop all other incoming SSH traffic
iptables -A INPUT -p tcp --dport 22 -j DROP

# Drop all incoming traffic outside Monday to Friday, 08:00-16:00
iptables -A INPUT -m time ! --weekdays Mon,Tue,Wed,Thu,Fri --timestart 08:00 --timestop 16:00 -j DROP

# Accept all other incoming traffic
iptables -A INPUT -j ACCEPT
