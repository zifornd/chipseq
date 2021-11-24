

from snakemake.utils import validate
import pandas as pd


##### load config and sample sheets #####

samples = pd.read_table(config["samples"]).set_index("sample", drop=False).sort_index()
validate(samples, schema="../schemas/config.schema.yaml")

units = pd.read_table(config["units"]).set_index(["sample", "unit"], drop=False).sort_index()

wildcard_constraints:
    sample = "|".join(samples["sample"]),
    unit = "|".join(units["unit"])



def get_final_output():

    genome = config["genome"]

    output = [
        "results/multiqc/multiqc.html",
        f"results/genomepy/{genome}/{genome}.fa",
        f"results/bowtie2-build/{genome}.1.bt2",
        "results/plots/plot_fingerprint/plot_fingerprint.png",
        "results/deeptools/multibam.npz",
        "results/plots/PCA_readCounts.png",
        "results/plots/correlation_readCounts.png"
    ]

    for sample, unit in units.index:

        output.append(f"results/fastq/{sample}-{unit}.fastq")
        output.append(f"results/fastqc/{sample}-{unit}_fastqc.html")
        output.append(f"results/trimmed/{sample}-{unit}.fastq")
        output.append(f"results/trimmed/{sample}-{unit}.qc.txt")
        output.append(f"results/bowtie2/sam/{sample}-{unit}.sam")
        output.append(f"results/bowtie2/bam/{sample}-{unit}.sorted.bam")
        output.append(f"results/bowtie2/bam_index/{sample}-{unit}.sorted.bam.bai")
        output.append(f"results/macs2_callpeak/{sample}-{unit}.narrow_peaks.xls")

    return output


def get_multiqc_input():

    output = ["results/plots/plot_fingerprint/qc_metrics.txt"]

    for sample, unit in units.index:

        output.append(f"results/fastqc/{sample}-{unit}_fastqc.html")
        output.append(f"results/fastqc/{sample}-{unit}_fastqc.zip")
        output.append(f"results/trimmed/{sample}-{unit}.qc.txt")
        output.append(f"results/fastqc/{sample}-{unit}_fastqc.html")
        output.append(f"results/fastqc/{sample}-{unit}_fastqc.zip")
        output.append(f"results/trimmed/{sample}-{unit}.qc.txt")

    return output 

def samtools_merge(wildcards):
    
    df = units

    ix = (df["sample"] == wildcards.sample)

    df = df.loc[ix, ]

    return expand("results/bowtie2/bam/{sample}-{unit}.sorted.bam", sample = wildcards.sample, unit = df["unit"]) 


def fastq_input(wildcards):

    df = units

    ix = (df["sample"] == wildcards.sample) & (df["unit"] == wildcards.unit)

    df = df.loc[ix, ]

    return df["fq1"]