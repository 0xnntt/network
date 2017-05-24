import sys
import glob
# define folder that all mimikatzs outpout file located.
for i in glob.glob(".\*.txt"):
	f = open(i).read()
	for i in f.split("wdigest :"):
            try:
                temp = i.split("kerberos :")[0]
                d = temp.split("Domain   : ")[1].split("\n")[0]
                u = temp.split("Username : ")[1].split("\n")[0]
                p = temp.split("Password : ")[1].split("\n")[0]
                print d+"Â¬"+u+"Â¬"+p
            except:
                z = 1
    

