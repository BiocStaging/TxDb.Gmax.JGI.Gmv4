# TxDb.Gmax.JGI.Gmv4

**TxDb.Gmax.JGI.Gmv4** provides transcript, exon, and coding sequence (CDS)
annotations for soybean (*Glycine max*, Wm82.a4.v1). The database was generated
from the official JGI/Phytozome GFF3 annotation and is distributed through
Bioconductor's AnnotationHub. The regenerated SQLite resource is deposited
at [Zenodo record 23882021](https://zenodo.org/records/23882021).

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

## Reference and annotation source

The database represents the JGI/Phytozome *Glycine max* Wm82.a4.v1 annotation.
The annotation GFF3 and matching Wm82.a4.v1 reference assembly FASTA are
available from the [JGI Data Portal](https://data.jgi.doe.gov/refine-download/phytozome?expanded=Phytozome-508&genome_id=508).

## Documentation

See the package vignette:

```r
vignette("TxDb.Gmax.JGI.Gmv4", package = "TxDb.Gmax.JGI.Gmv4")
```
