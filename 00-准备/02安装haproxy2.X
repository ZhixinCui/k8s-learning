#sudo cd /usr/local/src
#sudo tar -xf haproxy-2.4.4.tar.gz
#sudo cd haproxy-2.4.4
#sudo make TARGET=linux-glibc ARCH=x86_64 PREFIX=/usr/local/haproxy  
#sudo make install PREFIX=/usr/local/haproxy
cp /usr/local/haproxy/sbin/haproxy /usr/sbin/
cp examples/haproxy.init /etc/init.d/haproxy


/etc/haproxy/haproxy.cfg

cp /admin/systemd/haproxy.service.in /usr/lib/systemd/system/haproxy.service


/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -c
