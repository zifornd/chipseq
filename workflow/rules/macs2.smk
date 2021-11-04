# Author Haris Khan
# Email: haris.khan@zifornd.com

rule macs2_callpeak_narrow:
    input:
        treatment="results/bowtie2/bam/{sample}-{unit}.sorted.bam"
        #control="results/filtered/{control}.sorted.bam",
    output:
        multiext("results/macs2_callpeak/{sample}-{unit}.narrow",
                 "_peaks.xls",
                 "_treat_pileup.bdg",
                 "_control_lambda.bdg",
                 "_peaks.narrowPeak",
                 "_summits.bed"
                 )
    log:
        "logs/macs2/callpeak.{sample}-{unit}.narrow.log"
    params:
        "-f BAM -q 0.05 --nomodel"
    wrapper:
        "0.68.0/bio/macs2/callpeak"


# ADD Config params wheather to call narrow or broad + Control sample

# rule macs2_callpeak_broad:
#     input:
#         treatment="results/bowtie2/bam/{sample}-{unit}.sorted.bam"
#         #control="results/filtered/{control}.sorted.bam",    ADD Control to common/config
#     output:
#         multiext("results/macs2_callpeak/{sample}-{unit}.broad",
#                  "_peaks.xls",
#                  "_treat_pileup.bdg",
#                  "_control_lambda.bdg",
#                  "_peaks.broadPeak",
#                  "_summits.bed"
#                  )
#     log:
#         "logs/macs2/callpeak.{sample}-{unit}.broad.log"
#     params:
#         "-f BAM -q 0.05 --nomodel --broad-cutoff 0.1"
#     wrapper:
#         "0.68.0/bio/macs2/callpeak"