# Author Haris Khan
# Email: haris.khan@zifornd.com

rule fastqc:
    input:
        files="raw/{SRR}.fastq.gz",
    output:
        multitext("{SRR}_out/{SRR}.html", ".zip")
    threads:
        16
    conda:
        "../envs/environment.yaml"
    shell:
        """
        "fastqc -o {SRR} -t {threads} {{SRR}.fastq.gz}"
        """
