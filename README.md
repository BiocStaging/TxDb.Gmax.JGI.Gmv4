# TxDb.Gmax.JGI.Gmv4

**TxDb.Gmax.JGI.Gmv4** provides transcript, exon, CDS, and gene annotations
for soybean (*Glycine max*, Wm82.a4.v1). The database was generated from the
official JGI/Phytozome GFF3 annotation using the matching Wm82.a4.v1 reference
genome assembly. The resource is available through Bioconductor's AnnotationHub.

## Installation

Install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("TxDb.Gmax.JGI.Gmv4")
```

To install the development version from GitHub:

```r
if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
}
remotes::install_github("kabilanbio/TxDb.Gmax.JGI.Gmv4")
```

## Usage

Retrieve the TxDb resource from AnnotationHub:

```r
library(AnnotationHub)
library(GenomicFeatures)

ah <- AnnotationHub()
query(ah, "TxDb.Gmax.JGI.Gmv4")

# AnnotationHub identifier for this resource
txdb <- ah[["AH122288"]]

seqinfo(txdb)
genes(txdb)
head(transcripts(txdb))
exonsBy(txdb, by = "tx")
cdsBy(txdb, by = "tx")
```

## Data source and reproducibility

The database represents the JGI/Phytozome *Glycine max* Wm82.a4.v1 annotation.
The annotation GFF3 and matching reference FASTA source locations are recorded
in `inst/scripts/make-data.R`. The FASTA is used to provide complete sequence
lengths and genomic assembly metadata when constructing the TxDb.

Source dataset location:
[JGI Data Portal](https://data.jgi.doe.gov/refine-download/phytozome?expanded=Phytozome-508&genome_id=508)

## Documentation

See the package vignette:

```r
vignette("TxDb.Gmax.JGI.Gmv4", package = "TxDb.Gmax.JGI.Gmv4")
```
