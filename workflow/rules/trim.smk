# Author Haris Khan
# Email: haris.khan@zifornd.com

rule trim:
    input:
        files = "results/fastq/{sample}-{unit}.fastq"
    output:
        fastq = "results/trimmed/{sample}-{unit}.fastq",
        qc = "results/trimmed/{sample}-{unit}.qc.txt"
    log:
        "logs/cutadapt/{sample}-{unit}.log.txt"
    params:
        adapters = "-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC",
        extra = "-q 20"
    threads: 4
    wrapper:
        "0.79.0/bio/cutadapt/se"
