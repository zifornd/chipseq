# Author Haris Khan
# Email: haris.khan@zifornd.com

rule bedGraphToBigWig:
    input:
        bedGraph="results/macs2_callpeak/{sample}-{unit}.narrow_treat_pileup.bdg",
        chromsizes="results/genomepy/BDGP6.32/BDGP6.32.fa.sizes" #Needs genome automasation
    output:
        "results/bigwig/{sample}-{unit}.bw"
    log:
        "logs/{sample}-{unit}.bed-graph_to_big-wig.log"
    params:
        "" # optional params string
    wrapper:
        "0.79.0/bio/ucsc/bedGraphToBigWig"