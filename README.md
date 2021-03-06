
## RNA-Seq quantification pipeline of Human and SARS-CoV-2 transcripts using pyrpipe and snakemake

This pipeline uses salmon to quantify the RNA-Seq samples and compile The transcripts TPMs for exploratory analysis with [MetaOmGraph](https://github.com/urmi-21/MetaOmGraph)
The final output file of this workflow, `results_TPM.tsv`, can be directly imported in MetaOmGraph together with the metadata file.


## Build the conda environment
* Please have conda installed
* Run `conda env create -f env.yaml`
* Activate the environment: `conda activate pyrpipe_covid`

## Prepare reference data
To download the reference data used run the following command

`bash prepare_data.sh`

Alternatively, edit the config.yaml to change the reference files

`bash prepare_data.sh` will also create a salmon index using whole genome sequence as decoy.
User can edit this in the `bash prepare_data.sh` file.

## Parameters
All the tool parameters are specified in the `params` directory. To modify the parameters edit the .yaml files inside `params` directory.
`pyrpipe` parameters are specified in the `pyrpipe_conf.yaml` file. To change pyrpipe behaviour edit the `pyrpipe_conf.yaml` file.


## Executing the workflow 

Put the RNA-Seq SRR accessions in a file, say `runs.txt`. Edit the Snakefile to read `runs.txt` as input.

Run the pipeline using:

`snakemake -j <cores>`
 
### To execute on a cluster with slurm

`snakemake -j 25 --cluster-config cluster.json --cluster "sbatch -t {cluster.time} -c 28"`

Edit the `cluster.json` file as required.
