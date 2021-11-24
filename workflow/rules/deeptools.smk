rule plot_fingerprint:
    input:
        bam_files = expand("results/bowtie2/merged/{sample}.bam", sample = samples["sample"]),
        bam_idx = expand("results/bowtie2/merged/{sample}.bam.bai", sample = samples ["sample"]),
        jsd_sample="results/bowtie2/merged/B.bam" # Needs automation with {control}
    output: 
        #--plotFile and --outRawCounts are exclusively defined via output files.
        fingerprint="results/plots/plot_fingerprint/plot_fingerprint.png",  # required
        # optional output
        counts = "results/plots/plot_fingerprint/raw_counts.tab",
        qc_metrics = "results/plots/plot_fingerprint/qc_metrics.txt"  #Integrated in to multiqc
    log:
        "logs/deeptools/plot_fingerprint.log"
    threads:
        2
    wrapper:
        "v0.80.1/bio/deeptools/plotfingerprint"



rule multiBamSummary:
    input:
        bam = expand("results/bowtie2/merged/{sample}.bam", sample = samples["sample"]),
        bed = "results/macs2_callpeak/A-unit1.narrow_summits.bed" # Needs automation with {merge_bed}
    output: 
        out = "results/deeptools/multibam.npz"
    log:
        "logs/deeptools/multiBamSummary.log"
    threads:
        2
    conda:
        "../envs/environment.yaml"
    shell:
        "multiBamSummary BED-file --BED {input.bed} --bamfiles {input.bam} -o {output.out} 2>{log}"


rule plot_PCA:
    input:
        matrix = "results/deeptools/multibam.npz"
    output:
        pca = "results/plots/PCA_readCounts.png"
    threads: 2
    log:
        "logs/deeptools/plot_PCA.log"
    conda:
        "../envs/environment.yaml"
    shell:
        "plotPCA -in {input.matrix} -o {output.pca}"

        
rule plot_correlation:
    input:
        matrix = "results/deeptools/multibam.npz"
    output:
        cor = "results/plots/correlation_readCounts.png"
    threads: 2
    log:
        "logs/deeptools/plot_cor.log"
    conda:
        "../envs/environment.yaml"
    shell:
        "plotCorrelation -in {input.matrix} --corMethod spearman -o {output.cor} --whatToPlot heatmap 2>{log}"
        


