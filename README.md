# ChIP Seq Snakemake Pipeline

A Snakemake workflow to analyse ChIPSeq datasets.


## Prerequisites

In your cluster project directory install Miniconda as described here: https://docs.conda.io/projects/conda/en/latest/user-guide/install/

```
bash Miniconda3-latest-Linux-x86_64.sh
```

## Installing

Clone this repository in your cluster project directory

```
git clone
```

Execute the workflow:

```
$ snakemake --cores all --use-conda -j 999 --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -n {cluster.n} --mem {cluster.mem}"

```
