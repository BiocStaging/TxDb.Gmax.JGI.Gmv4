# TxDb.Gmax.JGI.Gmv4

**TxDb.Gmax.JGI.Gmv4** provides transcript, exon, and coding sequence (CDS)
annotations for soybean (*Glycine max*, Wm82.a4.v1). The database was generated
from the official JGI/Phytozome GFF3 annotation and is distributed through
Bioconductor's AnnotationHub. The regenerated SQLite resource is deposited
at [Zenodo record 23882021](https://zenodo.org/records/23882021).

## Installation

The package requires R 4.6 or later and the Bioconductor development release
(Bioconductor 3.24).

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install(version = "devel")
BiocManager::install(c(
    "TxDb.Gmax.JGI.Gmv4",
    "GenomicFeatures",
    "GenomicRanges"
))
```

## Retrieve the TxDb

The SQLite database is hosted by AnnotationHub and is downloaded and cached
when first requested.

```r
library(TxDb.Gmax.JGI.Gmv4)
library(GenomicFeatures)

txdb <- get_gmax_txdb()

genes(txdb)
head(transcripts(txdb))
exonsBy(txdb, by = "tx")
cdsBy(txdb, by = "tx")
```

The helper function `get_gmax_txdb()` retrieves the package's current
AnnotationHub resource. You may also provide an existing `AnnotationHub`
instance to reuse its cache:

```r
ah <- AnnotationHub::AnnotationHub()
txdb <- get_gmax_txdb(hub = ah)
```

## Reference and annotation source

The database represents the JGI/Phytozome *Glycine max* Wm82.a4.v1 annotation.
The annotation GFF3 and matching Wm82.a4.v1 reference assembly FASTA are
available from the [JGI Data Portal](https://data.jgi.doe.gov/refine-download/phytozome?expanded=Phytozome-508&genome_id=508).

See the package vignette for examples of querying genes, transcripts, exons,
CDS features, and promoter regions.
