# Author Haris Khan
# Email: haris.khan@zifornd.com

# Things to be added:
    # Paired vs single end reads
    # IP/Input Config

rule homer:
    input:
        IP=expand("{IP}_out/{IP}.bam", IP=IP),
        input=expand("{input}_out/{input}.bam", input=input)
    output:
        "results/peak_calls/{IP}.bed"
        "results/visualisation/{SRR}.bedgraph"
    shell:
        """
        makeTagDirectory tags/input.{wildcards.IP}/ {input.input}
        makeTagDirectory tags/ip.{wildcards.IP}/ {input.IP}
        makeUCSCfile ${FILEBASE}.dir -o ${FILEBASE}.bedgraph
        findPeaks tags/ip.{wildcards.IP}/ -i tags/input.{wildcards.IP}/ -fragLength 150 -inputFragLength 150 -C 0 > peak_calls/{wildcards.IP}.txt
        pos2bed.pl peak_calls/{wildcards.IP}.txt > peak_calls/{wildcards.IP}.bed
        rm -rf tags/input.{wildcards.IP}
        rm -rf tags/ip.{wildcards.IP}
        """
