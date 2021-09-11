$ sudo apt-get install build-essential libpcre3-dev libsystemd-dev -y
$ sudo cd /usr/local/src
$ sudo tar -xf haproxy-2.4.4.tar.gz
$ sudo cd haproxy-2.4.4
$ sudo make clean  
$ sudo make -j $(nproc) TARGET=linux-glibc USE_OPENSSL=1  USE_PCRE=1 USE_SYSTEMD=1
$ sudo make install
$ cp admin/systemd/haproxy.service.in /usr/lib/systemd/system/haproxy.service
$ cp /usr/local/sbin/haproxy /usr/sbin/
$ mkdir /etc/haproxy/
$ vim /etc/haproxy/haproxy.cfg
global
   strict-limits  # refuse to start if insufficient FDs/memory
   # add some process-wide tuning here if required

   # A stats socket may be added to check live metrics if the load generators
   # do not report them.
   #    stats socket /tmp/haproxy.sock level admin
   #    stats timeout 1h

defaults
   mode http
   balance random      # power-of-two-choices
   timeout client 60s
   timeout server 60s
   timeout connect 1s

frontend http_front
   bind *:6443
   default_backend http_back

backend http_back
   balance roundrobin
   server master01.matrix.com 192.168.63.148:6443 check
   server master02.matrix.com 192.168.63.149:6443 check
   server master03.matrix.com 192.168.63.150:6443 check

$ haproxy -f /etc/haproxy/haproxy.cfg 
$ sudo systemctl enable haproxy
$ sudo systemctl start haproxy
