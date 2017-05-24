import ipaddr
unique=[]
ips = []
ips_input=""" 
192.168.10.10/20
192.168.20.20/20
"""
v = ips_input.split("\n")
for i in v:
	ips.append(i.strip())
for k in ips:
	if len(k) <6:
		ips.pop(ips.index(k))
try:
        for i in ips:
                j = ips[ips.index(i)+1]
                if(ipaddr.IPNetwork(i).overlaps(ipaddr.IPNetwork(j))):
                        ips.pop(ips.index(i))
except:
        print "Continue"
for i in ips:
	print i
