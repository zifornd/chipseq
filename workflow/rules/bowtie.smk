# Author Haris Khan
# Email: haris.khan@zifornd.com


rule bowtie2_build:
    input:
        reference="results/genomepy/{genome}/{genome}.fa"
    output:
        multiext(
            "results/bowtie2-build/{genome}",
            ".1.bt2",
            ".2.bt2",
            ".3.bt2",
            ".4.bt2",
            ".rev.1.bt2",
            ".rev.2.bt2",
        ),
    log:
        "logs/bowtie2_build/{genome}.build.log"
    params: extra = ""
    threads: 8
    wrapper:
        "0.79.0/bio/bowtie2/build"


# rule bowtie2_align:
#     input:
#         sample="results/trimmed/{sample}-{unit}.fastq"
#     output:
#         "results/bowtie2/bam/{sample}-{unit}.bam"
#     log:
#         "logs/bowtie2/{sample}-{unit}.log"
#     params:
#         index="results/bowtie2-build/BDGP.32",  # prefix of reference genome index (built with bowtie2-build)
#         extra=""  # optional parameters
#     threads: 8  # Use at least two threads
#     wrapper:
#         "0.79.0/bio/bowtie2/align"

rule bowtie2_align:
    input:
        fqz = "results/trimmed/{sample}-{unit}.fastq"
    output:
        sam = "results/bowtie2/sam/{sample}-{unit}.sam"
    threads:
        1
    params:
        idx = "results/bowtie2-build/BDGP6.32",
    conda:
        "../envs/environment.yaml"
    shell:
        "bowtie2 -x {params.idx} -U {input.fqz} -S {output.sam}"

rule samtools_view:
    input:
        sam = "results/bowtie2/sam/{sample}-{unit}.sam"
    output:
        bam = "results/bowtie2/bam/{sample}-{unit}.bam"
    threads:
        1
    conda:
        "../envs/environment.yaml"
    shell:
        "samtools view -Sbh {input.sam} -o {output.bam}"


rule samtools_sort:
    input:
        inbam = "results/bowtie2/bam/{sample}-{unit}.bam"
    output:
        outbam = "results/bowtie2/bam/{sample}-{unit}.sorted.bam"
    conda:
        "../envs/environment.yaml"
    shell:
        "samtools sort {input.inbam} -o {output.outbam}"