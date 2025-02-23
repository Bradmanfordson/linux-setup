#!/usr/bin/python3

# Yes, I could use 'ifconfig' or 'ip addr' but 99% of the time ONLY want the interface name and IP address.
# Output looks like:
# interface: ipaddress

import netifaces

string = str()
for interface in netifaces.interfaces():
    addrs = netifaces.ifaddresses(interface)
    try:
        for item in addrs[netifaces.AF_INET]:
            string += f"{interface}: {item.get('addr')}\n"
    except Exception as e:
        pass

print(string)
