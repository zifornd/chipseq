# Run the linter

snakemake --snakefile workflow/Snakefile --directory .tests/integration --lint



# Run the workflow

snakemake --snakefile workflow/Snakefile --directory .tests/integration --use-conda --cores all



# Create a workflow report

snakemake --snakefile workflow/Snakefile --directory .tests/integration --report report.html



# Create graph of workflow

snakemake --snakefile workflow/Snakefile --directory .tests/integration --dag | dot -Tpdf > images/rulegraph.pdf