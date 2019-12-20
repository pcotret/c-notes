# My first topology
- Mainly based on an official tutorial ([link](https://docs.gns3.com/1d1huu6z9-wWGD_ipTSQZqy2mpaxiqzymu-YQo6at_Jg/index.html)).
- A Google Drive with several Cisco IOS: [https://drive.google.com/drive/folders/102jxZ9ECpe6ZFtXYdK_81iEVuuFoGOGR](https://drive.google.com/drive/folders/102jxZ9ECpe6ZFtXYdK_81iEVuuFoGOGR).
- In this tutorial, the `c7200` is used. You may not have the same interfaces in another case.

## Topology creation
Take two `c7200` routers and add them to the schematic by a "drag and drop".
![p3](../../../img/net1.png)

We can see our two routers:

![p4](../../../img/net2.png)

Use the **link** icon in order to... ...link them. In this case, we connect the **FastEthernet0/0** interfaces of the routers.
![p5](../../../img/net4.png)

Below, the green **Start** button (marked #1) and the **Console** button (marked #2) have been selected.

![p2](../../../img/net5.png)

Now, let's configure the routers. Reminder: GNS3 runs IOS images, it's like playing with a real router (commands are the same).

## Routers configuration

```bash
R1# sh ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            unassigned      YES unset  administratively down down    
FastEthernet1/0            unassigned      YES unset  administratively down down    
FastEthernet2/0            unassigned      YES unset  administratively down down    
FastEthernet3/0            unassigned      YES unset  administratively down down    
FastEthernet4/0            unassigned      YES unset  administratively down down  
```
As you can see, all interfaces are **administratively down**. Same thing for R2:
```bash
R2# sh ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            unassigned      YES unset  administratively down down    
FastEthernet1/0            unassigned      YES unset  administratively down down    
FastEthernet2/0            unassigned      YES unset  administratively down down    
FastEthernet3/0            unassigned      YES unset  administratively down down    
FastEthernet4/0            unassigned      YES unset  administratively down down
```
Let's configure `fa0/0` and `loopback0` interfaces:
```bash
R1# conf t
R1(config)# int fa0/0
R1(config-if)#ip add 10.1.1.1 255.255.255.0
R1(config-if)#int loop 0
R1(config-if)#ip add 1.1.1.1 255.255.255.255
R1(config-if)# end
R1#sh ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            10.1.1.1        YES manual administratively down down    
FastEthernet1/0            unassigned      YES unset  administratively down down    
FastEthernet2/0            unassigned      YES unset  administratively down down    
FastEthernet3/0            unassigned      YES unset  administratively down down    
FastEthernet4/0            unassigned      YES unset  administratively down down    
Loopback0                  1.1.1.1         YES manual up                    up   
```
Interfaces are correctly configured. There's only one difference: *loopback* virtual interfaces are automatically enabled (**up** state). In order to enable `fa0/0`:
```bash
R1# conf t
R1(config)#int fa0/0
R1(config-if)#no shut
R1(config-if)#end
R1#sh ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            10.1.1.1        YES manual up                    up      
FastEthernet1/0            unassigned      YES unset  administratively down down    
FastEthernet2/0            unassigned      YES unset  administratively down down    
FastEthernet3/0            unassigned      YES unset  administratively down down    
FastEthernet4/0            unassigned      YES unset  administratively down down    
Loopback0                  1.1.1.1         YES manual up                    up  
```
Let's configure R2:
```bash
R2#conf t
R2(config)#int fa0/0
R2(config-if)#no shut
R2(config-if)#ip add 10.1.1.2 255.255.255.0
R2(config-if)#int loop 0
R2(config-if)#ip add 2.2.2.2 255.255.255.255
R2(config-if)# end
R2#sh ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            10.1.1.2        YES manual up                    up      
FastEthernet1/0            unassigned      YES unset  administratively down down    
FastEthernet2/0            unassigned      YES unset  administratively down down    
FastEthernet3/0            unassigned      YES unset  administratively down down    
FastEthernet4/0            unassigned      YES unset  administratively down down    
Loopback0                  2.2.2.2         YES manual up                    up     
```
We can have some information about the IOS with the following command:
```bash
R2#sh ver
Cisco IOS Software, 7200 Software (C7200-JK9S-M), Version 12.4(13b), RELEASE SOFTWARE (fc3)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2007 by Cisco Systems, Inc.
Compiled Wed 25-Apr-07 03:18 by prod_rel_team
[...]
```
By now, R1 and R2 can talk to each other:
```bash
R2#ping 10.1.1.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.1.1.1, timeout is 2 seconds:
.!!!!
Success rate is 80 percent (4/5), round-trip min/avg/max = 44/57/64 ms
```
Only 80% of packets are received, don't worry! The first packet is lost due to the [ARP address resolution](https://en.wikipedia.org/wiki/Address_Resolution_Protocol) (reminder: ARP is mainly responsible for *translating* IP to MAC addresses).

Here is a ping in the other direction:
```bash
R1#ping 10.1.1.2
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.1.1.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 60/62/68 ms
```
100% of packets are received as the ARP exchange is already done!

## OSPF routing
```bash
R1#conf t
R1(config)#router ospf 1
R1(config-router)#router-id 1.1.1.1
R1(config-router)#network 0.0.0.0 255.255.255.255 area 0
R1(config-router)#end
R2#conf t
R2(config)#router ospf 1
R2(config-router)#router-id 2.2.2.2
R2(config-router)#network 0.0.0.0 255.255.255.255 area 0
R2(config-router)#end
```
List of R2 neighbors:
```bash
R2#sh ip ospf neigh
Neighbor ID     Pri   State           Dead Time   Address         Interface
1.1.1.1           1   FULL/DR         00:00:32    10.1.1.1        FastEthernet0/0
```
`1.1.1.1` is the address of R1.

R1 routing table:
```bash
R1#sh ip route
Codes: C - connected, S - static, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area 
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2
       i - IS-IS, su - IS-IS summary, L1 - IS-IS level-1, L2 - IS-IS level-2
       ia - IS-IS inter area, * - candidate default, U - per-user static route
       o - ODR, P - periodic downloaded static route

Gateway of last resort is not set

     1.0.0.0/32 is subnetted, 1 subnets
C       1.1.1.1 is directly connected, Loopback0
     2.0.0.0/32 is subnetted, 1 subnets
O       2.2.2.2 [110/2] via 10.1.1.2, 00:08:21, FastEthernet0/0
     10.0.0.0/24 is subnetted, 1 subnets
C       10.1.1.0 is directly connected, FastEthernet0/0
R1#ping 2.2.2.2
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 2.2.2.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 8/24/72 ms
```
There's the OSPF route towards `2.2.2.2`. On the R2 side:

```bash
R2#ping 1.1.1.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 1.1.1.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 12/28/40 ms
```

## Router configuration backup
By default, GNS3 won't save routers configuration. It can be done manually:
```bash
R1#copy running-config startup-config
```
Next time GNS3 is launched, routers will still be configured!
