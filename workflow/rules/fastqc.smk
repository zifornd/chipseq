# Author Haris Khan
# Email: haris.khan@zifornd.com


rule fastqc:
    input:
        files = "results/fastq/{sample}-{unit}.fastq"
    output:
        multiext("results/fastqc/{sample}-{unit}_fastqc", ".html", ".zip")
    threads:
        8
    params:
        out = "results/fastqc"
    log:
        out = "results/fastqc/{sample}-{unit}_fastqc.out",
        err = "results/fastqc/{sample}-{unit}_fastqc.err"
    conda:
        "../envs/qc.yaml"
    shell:
        "fastqc -o {params.out} -t {threads} {input} 1> {log.out} 2> {log.err}"

rule multiqc:
    input:
        get_multiqc_input()
    output:
        "results/multiqc/multiqc.html"
    log:
        "logs/multiqc.log"
    wrapper:
        "0.64.0/bio/multiqc"