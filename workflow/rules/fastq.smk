rule fastq:
    input:
        fqz = fastq_input
    output:
        fqz = "results/fastq/{sample}-{unit}.fastq"
    message:
        "[coreutils] Create a symbolic link"
    threads:
        1
    shell:
        "ln -s {input.fqz} {output.fqz}"