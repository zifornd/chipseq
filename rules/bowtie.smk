# Author Haris Khan
# Email: haris.khan@zifornd.com


rule index_bowtie:
    input:
        "genomepy/{genome}/{genome}.fa"
    output:
        "{genome}/{genome}.ebwt"
    threads: 8
    shell:
        """
        bowtie-build --threads {threads} {input} {genome}/{genome}.fa
        """

rule bowtie:
    input:
        files="raw/{SRR}.fastq",
        index="{genome}/{genome}.ebwt"
    output:
        temp("{SRR}_out/{SRR}.sam")
    threads:
        16
    shell:
        """
        bowtie {genome}/{genome} -p 8 -m 1 -S {input.files} > {wildcards.SRR}_out/{wildcards.SRR}.sam
        """
