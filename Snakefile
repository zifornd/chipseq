# Author Haris Khan
# Email: haris.khan@zifornd.com

IP = ['SRR495368']
input = ['SRR495378']
SRR = IP + input



rule all:
    input:
        expand("{SRR}_out/{SRR}.bedgraph", SRR=SRR),
        "showcase.html"


onsuccess:
        shell("rm *.out; rm -rf tags; rm -rf raw")
