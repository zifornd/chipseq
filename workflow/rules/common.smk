

from snakemake.utils import validate
import pandas as pd


##### load config and sample sheets #####



samples = pd.read_csv(config["samples"], sep="\t", dtype=str, comment="#").set_index(
    "sample", drop=False
)

validate(config, schema="../schemas/config.schema.yaml")
