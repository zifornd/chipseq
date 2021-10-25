# Author Haris Khan
# Email: haris.khan@zifornd.com


rule index_bowtie:
    input:
        "genomepy/{genome}/{genome}.fa"
    output:
        "results/{genome}/{genome}.ebwt"
    threads: 8
    conda:
        "../envs/environment.yaml"
    shell:
        """
        bowtie-build --threads {threads} {input} {genome}/{genome}.fa
        """

rule bowtie:
    input:
        files="results/{sample}.fastq.gz",
        index="{genome}/{genome}.ebwt"
    output:
        out = temp("{sample}/{sample}.sam")
    threads:
        16
    conda:
        "../envs/environment.yaml"
    shell:
        """
        bowtie results/{genome}/{genome} -p 8 -m 1 -S {input.files} > {output.out}
        """
