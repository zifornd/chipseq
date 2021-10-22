# Author Haris Khan
# Email: haris.khan@zifornd.com

rule trim:
    input:
        files = "results/fastq/{sample}/{sample}.fastq.gz"
    output:
        fastq = "results/trimmed/{sample}/{sample}.fastq.gz"
        qc = "results/trimmed/{sample}.qc.txt"
    log:
        "logs/cutadapt/{sample}.log"
    params:
        adapters="-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC",
        extra="-q 20"
    threads: 4
    wrapper:
        "0.79.0/bio/cutadapt/se"
