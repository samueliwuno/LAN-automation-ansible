# SHOPIFY NETWORK DESIGN/AUTOMATION
---------------------------------------------------------
#### Author: Samuel Iwuno
 This Project shows the implementation of a LAN required for a Shopify Workspace in GNS3. The GNS3 project file, Ansible provisioning scripts and instructions on how to import the required images into GNS3 can be provided if requested via Github
 ## Terms and Acronyms
- ALS  - Access Layer Switch
- DLS  - Distribution Layer Switch (Multi-Layer or Layer 3 Switch)
- NGFW - Next Generation Firewall
- CTR  - Wireless Controller
- WAP  - Wireless Access Point
- EOL  - End of Life Cycle

 ## Network Requirements
 - Provide Wired/Wireless Connectivity for a Workspace
 - Workspace consists of 3 Floors with at least 100 Devices on average  
 - Devices may include Workstations, Printers, Smartphones
## Network Diagram
![alt text](https://github.com/samueliwuno/ShopifyLAN/blob/main/Net_Diag.png)

## Hardware Choices
Details of chosen appliances are provided at the bottom of this document
- For the Firewall, I have decided to go with Fortinet's Fortigate Firewall. They are one on the best in the market in regards to Intuitive GUI and market share when it comes to NGFW Appliances. the chosen switches can also be integrated into the Fortinet's Security Fabric. the **Fortigate 80F** unit will be sufficient for this network. 
- For the Switches, i have Decided to go with ExtremeNetworks. the **Summit X450-G2** will suffice for the **DLS** while for the **ALS** that will be installed on all floors will be the **V400 Series** Switch. this switches come with up to 48 Gigabit Ethernet Ports and 4 10Gbs Uplink Ports. the CLi is also very intuitive. and easy to use. Both switches also run the same EXOS recommended versions (EXOS 31.2.1.1)
- For the Wireless Controllers and APs, ExtremeNetworks is also a good choice. The **C35 CTR** will be more than sufficient. 


## VLANs and Subnetting
According to the Network Requirements there are going to be, on average 100 devices requring Wired and Wireless Connectivity on each floor of the workspace. With this requirement, i have decided to seperate the LAN into seperate subnets (VLANS). Each VLAN will be a /24 network providing 254 usable addresses for both Network and User devices. The VLANs will be accessible via the ALSs installed on each floor. the DLS, CTR and the NGFW will be installed on the ground floor. WAPs will be installed on each floor to provide wireless access to network. They can be connected directly to the CTR as shown in the diagram or connected to the ALSs
#### CIDR Block
Private IP addresses used will be 172.16.0.0/16
#### VLANs
Subnets for Vlans will be 172.16.x.0/24 where x is the VLAN_ID.
- User_Workstations (10) - PCs, Laptops
- Printers (20) - Printers and Faxes
- Accounting (30) - Payrole Servers, User databases
- DMZ (40) - Public Web Servers
- Wifi (50)- Wireless devices like Smartphones, Smart Screens, Laptops or Guest devices
- Native (99) - For Untagged Traffic for legacy devices that don't support traffic tagging

All Links between the DLS and the ALSs will be trunked allowing access to all configured VLANs. More Specific VLAN subnetting can be done when a more accurate number and type of network devices are known

#### Routed Ports 
- DLS <-> NGFW - 172.16.1.0/30
- NGFW <-> ISPs will either be static via DHCP. This is dependent on the public addresses provided by the ISPs  

The NGFW will handle all the security policies, NAT and VPN requirements. the Firewall will get access to the VLANs via OSPF neighbouring with DLS

#### Access Ports
Access Ports can be implemented as per Network requirement. but for now, that is outside the scope of this project

## Automation and Management
Both the chosen Switches and Firewall Have their Cloud Management and Automation Solutions (Fortinets FMG and ExtremeCloud IQ). However, This projects solution will handle Automation using Ansible. This will be done by using ansible to provision the Switches via ssh through their management interfaces. Once Provisioning is done and the Network is up and running as shown in the diagram, Remote Management can then be done via ansible through the firewall as long as the appropriate policies and  VPN tunnels are in place. 
## Suggestions for improving Network Resilency, Redundancy, Efficiency and Security
- While the **Fortigate 80F** Unit is sufficient for the the job here, if budget allows, and if you want the NGFW and IPS features like deep packet inspection (Layer7) Throughput to match the Speeds of the Switches Uplink ports(10Gbps), then  the mid-range appliances like the **Fortigate 600E** unit may be recommended here.  
- The EOL for the **C35 CTR** is coming up (2025). A newer model, like the **NX 5500 Wing CTR** is recommended for WIFI6 and Long term support
- Redundancy and Resilency can be improved for the network further by introducing a second **DLS** switch to the network. that way, VRRP can be configured on them to provided L3 gateway redundancy and load sharing for the uplinks to the Firewall 
- Security can be improved by limiting access between certain VLANs, for example, the only VLANs accessible by the public will be the DMZ, and only certain VLANs will be able to access the Accounting VLANs. this can be done via the Firewall Policies
- Further security improvements can include - Shutting down unused ports on all devices, using non-default VLANs and passwords. and implementing Access Control.

## Appliance Details
[Fortigate 80F](https://www.fortinet.com/content/dam/fortinet/assets/data-sheets/fortigate-fortiwifi-80f-series.pdf)  
[Fortigate 600E](https://www.fortinet.com/content/dam/fortinet/assets/data-sheets/FortiGate_600E.pdf)  
[Summit X450-G2](https://cloud.kapostcontent.net/pub/6f346f0e-30e3-452c-86cd-56795f6a1a65/x450-g2-data-sheet.pdf?kui=bKqLVAj7ueLS6LTgIp2rvw)  
[ExtremeSwitching V400 Series](https://cloud.kapostcontent.net/pub/59b81c15-076d-4069-b63d-ca89e84142cb/extremeswitching-v400-series-data-sheet?kui=ECOXrpgUWonsjQJFALylMg)  
[ExtremeWireless C35 CTR](https://cloud.kapostcontent.net/pub/38236555-1e21-43a3-9c61-af84c71a5844/wireless-controllers-ds-1.pdf)  
[ExtremeWireless™ WiNG NX 5500](https://kapost-files-prod.s3.amazonaws.com/kapost/55ba7c9e07003d9aab000394/studio/content/581cbe296fa64c1e0e00020c/published/nx-5500-data-sheet.pdf?kui=taYpxxpxR60ePX3p3eHN1w)  
[AP305C/CX WAP](https://cloud.kapostcontent.net/pub/c3de16b9-58a8-430d-87c7-1e26b6ceebe0/ap-305c)  
[ExtremeNetworks and Fortinet Fabric Ready](https://www.fortinet.com/content/dam/fortinet/assets/alliances/Extreme-Network-Fortinet-SB.pdf)
