# Shopify Network Design/Automation
----------------------------------------
 This Project shows the implementation of a LAN required in GNS3. the GNS3 project file and instructions on how to import the required images will be provided here  
 ## Terms and Acronyms
- ALS - Access Layer Switch
- DLS - Distribution Layer Switch (Multi-Layer or Layer 3 Switch)
- NGFW - Next Generation Firewall
- CTR - Wireless Controller

 ## Network Requirements
 - Provide Wired/Wireless Connectivity for a Workspace
 - Workspace consists of 3 Floors with at least 100 Devices on average  
 - Devices may include Workstations, Printers, Smartphones
## Network Diagram
![alt text](https://github.com/samueliwuno/ShopifyLAN/blob/main/Net_Diag.png)

## Hardware Choices
- For the Firewall, I have decided to go with Fortinet's Fortigate Firewall. They are one on the best in the market in regards to Intuitive UI and market share when it comes to NGFW Appliances. the chosen switches can also be integrated into the Fortinet's Security Fabric. the **Fortigate 80F** unit will be sufficient for this network. 
- For the Switches, i have Decided to go with ExtremeNetworks. the **Summit X450-G2** will suffice for the **DLS** while for the **ALS** that will be installed on all floors will be the **V400 Series** Switch
- For the Wireless Controllers and APs, ExtremeNetworks is also a good choice. The **C35 CTR** will be more than sufficient. 

## Automation and Management
Both the chosen Switches and Firewall Have their Cloud Management and Automation Solutions (Fortinets FMG and ExtremeCloud IQ). This projects solution will handle Automation using Ansible. this will be shown by using ansible to provision the Switches via ssh through their management interfaces. Once Provisioning is done and the Network is up and running as shown in the diagram, Remote Management can then be done via ansible
## Suggestions for improving Network Resilency and Redundancy
- While the **Fortigate 80F** Unit is  sufficient for the the job here, if budget allows, and if you want the NGFW and IPS Throughput to match the Speeds of the Switches Uplink ports, then  the mid-range appliances like the **Fortigate 600E** unit may be recommended here 
- The EOL for the **C35 CTR** is coming up (2025) a newer model, like the **NX 5500 Wing CTR** might be recommended for Long term support
- Redundancy and Resilency can be improved for the network further by introducinf a second **DLS** switch to the network. that way, VRRP can be configured on them to provided L3 gateway redundancy and load sharing for the uplinks to the Firewall 
    - 
 
