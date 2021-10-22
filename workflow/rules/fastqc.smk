# Author Haris Khan
# Email: haris.khan@zifornd.com

rule fastqc:
    input:
        files = "results/fastq/{sample}/{sample}.fastq.gz"
    output:
        multitext("results/fastcq/{sample}/{sample}.html", ".zip")
    threads:
        16
    params:
        out = "results/fastqc/{sample}"
    log:
        out = "results/fastqc/{sample}/{sample}_fastqc.out",
        err = "results/fastqc/{sample}/{sample}_fastqc.err"
    conda:
        "../envs/environment.yaml"
    shell:
        """
        "fastqc -o {params.out} -t {threads} {sample}.fastq.gz 1> {log.out} 2> {log.err}"
        """
