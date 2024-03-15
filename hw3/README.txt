HW3 Zichao Wu W1654083
Task 1

1. What is the output of “nodes” and “net”
mininet> nodes
available nodes are:
c0 h1 h2 h3 h4 h5 h6 h7 h8 s1 s2 s3 s4 s5 s6 s7
mininet> net
h1 h1-eth0:s3-eth2
h2 h2-eth0:s3-eth3
h3 h3-eth0:s4-eth2
h4 h4-eth0:s4-eth3
h5 h5-eth0:s6-eth2
h6 h6-eth0:s6-eth3
h7 h7-eth0:s7-eth2
h8 h8-eth0:s7-eth3
s1 lo:  s1-eth1:s2-eth1 s1-eth2:s5-eth1
s2 lo:  s2-eth1:s1-eth1 s2-eth2:s3-eth1 s2-eth3:s4-eth1
s3 lo:  s3-eth1:s2-eth2 s3-eth2:h1-eth0 s3-eth3:h2-eth0
s4 lo:  s4-eth1:s2-eth3 s4-eth2:h3-eth0 s4-eth3:h4-eth0
s5 lo:  s5-eth1:s1-eth2 s5-eth2:s6-eth1 s5-eth3:s7-eth1
s6 lo:  s6-eth1:s5-eth2 s6-eth2:h5-eth0 s6-eth3:h6-eth0
s7 lo:  s7-eth1:s5-eth3 s7-eth2:h7-eth0 s7-eth3:h8-eth0
c0


2. What is the output of “h7 ifconfig”
mininet> h7 ifconfig
h7-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.7  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::68c1:54ff:fe58:603e  prefixlen 64  scopeid 0x20<link>
        ether 6a:c1:54:58:60:3e  txqueuelen 1000  (Ethernet)
        RX packets 71  bytes 5474 (5.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11  bytes 866 (866.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


Task 2
Draw the function call graph of this controller. For example, once a packet comes
to the controller, which function is the first to be called, which one is the second, and
so forth?




Have h1 ping h2, and h1 ping h8 for 100 times (e.g., h1 ping-c100 p2).


h1 ping -c100 h2

h1 ping -c100 h8


a. How long does it take (on average) to ping for each case?
h1 ping -c100 h2: 2.459ms
h1 ping -c100 h8: 10.407ms

b. What is the minimum and maximum ping you have observed?
h1 ping -c100 h2:
MIN 0.600ms
MAX 4.070ms
h1 ping -c100 h8:
MIN 2.197ms
MAX 54.788ms

c. What is the difference, and why?
h1 ping h2 is relatively faster because there are fewer connections in between.
h1 ping h2: h1 -> s3 -> h2
h1 ping h8: h1 -> s3 -> s2 -> s1 -> s5 -> s7 -> h8

There is only a switch between h1 and h2 but between h1 and h8 there are multiple (three) switches which will bring some congestion


3. Run“iperf h1 h2” and “iperf h1 h8”


a. What is “iperf” used for?
The “iperf” is used to test the bandwidth between any two hosts. This is basically
used for network performance evaluation

b. What is the throughput for each case?
iperf h1 h2
	['23.4 Mbits/sec', '23.2 Mbits/sec']
iperf h1 h8
['5.02 Mbits/sec', '4.90 Mbits/sec']

c. What is the difference, and explain the reasons for the difference.
Because the distance between hosts are different, the increase in distance will increase the
chance of network congestion and reduces the throughput.

4. Which of the switches observe traffic? Please describe your way for observing such traffic on switches (e.g., adding some functions in the “of_tutorial” controller).
Switches s1, s2, s3, s5 and s7 observe most traffic. This can be observed by adding print() statements to  _handle_PacketIn()


Task 3: MAC Learning Controller
1. Describe how the above code works, such as how the "MAC to Port" map is established. You could use a ‘ping’ example to describe the establishment process (e.g., h1 ping h2).

In of_tutorial.py, now the act_like_switch function routes all the MAC addresses to a particular port number by leveraging the cache self.dictionary mac_to_port. It will first do a lookup of packet.dst in self.dictionary mac_to_port. If the destination doesn’t exist in yet, it will simply flood the incoming packet to all destinations and once found the right destination will be added to the cache dictionary self.dictionary mac_to_port. Next time when the same request is received it just looks up the dictionary map_to_port and sends accordingly.



2. (Comment out all prints before doing this experiment) Have h1 ping h2, and h1
ping h8 for 100 times (e.g., h1 ping -c100 p2).


a. How long did it take (on average) to ping for each case?
h1 ping -c100 h2: 2.839ms
h1 ping -c100 h8: 10.457ms




b. What is the minimum and maximum ping you have observed?
h1 ping -c100 h2:
MIN 0.646ms
MAX 3.801ms
h1 ping -c100 h8:
MIN 1.713ms
MAX 13.461ms

c. Any difference from Task 2 and why do you think there is a change if there is?
Task 3 experiments witness performance improvement over Task 2. The experiment h1 -> h8 has a more obvious improvement in RTT as compared to h1 -> h2 because of the h1-> h8 has more number of switches in the path which accumulates more single-node improvement.

The improvement is due to the controller being able to get MAC addresses and send them to the appropriate destination port using the mapping in mac_to_port (MAC learning) as opposed to simple flooding of packets in Task 2.

3. Q.3 Run “iperf h1 h2” and “iperf h1 h8”.
a. What is the throughput for each case?
mininet> iperf h1 h2
*** Iperf: testing TCP bandwidth between h1 and h2
*** Results: ['25.4 Mbits/sec', '25.1 Mbits/sec']
mininet> iperf h1 h8
*** Iperf: testing TCP bandwidth between h1 and h8
*** Results: ['2.96 Mbits/sec', '2.91 Mbits/sec']



b. What is the difference from Task 2 and why do you think there is a change if there is?
The throughput in h1 -> h2 is higher as compared to Task 2, while h1 -> h8 is lower.
The new implementation leverages MAC learning, resulting in faster forwarding lookup time and reduced congestion and thereby increasing throughput.



