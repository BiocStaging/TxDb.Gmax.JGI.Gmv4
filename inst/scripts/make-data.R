### =========================================================================
### make-data.R
### -------------------------------------------------------------------------
###
### Build the TxDb SQLite database for Glycine max (Wm82.a4.v1) from the
### official JGI/Phytozome GFF3 annotation and its matching reference FASTA.
###
### Source dataset:
### https://data.jgi.doe.gov/refine-download/phytozome?expanded=Phytozome-508&genome_id=508
###
### Download the following files from the JGI portal and place them in the
### working directory before running this script:
###   - Gmax_508_Wm82.a4.v1.gene.gff3.gz
###   - Gmax_508_v4.0.fa.gz
###
### The SQLite database is distributed through AnnotationHub. If the
### regenerated database is uploaded to a new Zenodo record, update
### inst/extdata/metadata.csv to point to that record and its new
### AnnotationHub resource.
###
### This script is retained for provenance/reproducibility and is not run
### during package installation or R CMD check.
###

suppressPackageStartupMessages({
    library(Biostrings)
    library(GenomeInfoDb)
    library(GenomicFeatures)
    library(AnnotationDbi)
})

# -------------------------------------------------------------------------
# 1. Input files and annotation metadata
# -------------------------------------------------------------------------

jgi_portal <- paste0(
    "https://data.jgi.doe.gov/refine-download/phytozome",
    "?expanded=Phytozome-508&genome_id=508"
)

gff_file <- "Gmax_508_Wm82.a4.v1.gene.gff3.gz"
fasta_file <- "Gmax_508_v4.0.fa.gz"
output_sqlite <- "TxDb.Gmax.JGI.Gmv4.sqlite"

organism_name <- "Glycine max"
taxonomy_id <- 3847L
genome_assembly <- "Wm82.a4.v1"

cat("JGI/Phytozome source:", jgi_portal, "\n")

missing_files <- c(gff_file, fasta_file)[
    !file.exists(c(gff_file, fasta_file))
]
if (length(missing_files)) {
    stop(
        "Required source file(s) not found in the working directory: ",
        paste(missing_files, collapse = ", "),
        "\nDownload the matching GFF3 and FASTA files from the JGI portal."
    )
}

# -------------------------------------------------------------------------
# 2. Build complete Seqinfo from the reference FASTA
# -------------------------------------------------------------------------

cat("Reading reference FASTA:", fasta_file, "\n")
soy_fasta <- Biostrings::readDNAStringSet(fasta_file, format = "fasta")

if (!length(soy_fasta)) {
    stop("The reference FASTA contains no sequences.")
}

# Retain the FASTA sequence identifiers, excluding any descriptive text.
fasta_seqnames <- sub("[[:space:]].*$", "", names(soy_fasta))

if (anyNA(fasta_seqnames) || any(!nzchar(fasta_seqnames))) {
    stop("One or more FASTA records have missing sequence identifiers.")
}
if (anyDuplicated(fasta_seqnames)) {
    duplicated_ids <- unique(fasta_seqnames[duplicated(fasta_seqnames)])
    stop(
        "FASTA sequence identifiers are not unique after removing ",
        "description text: ",
        paste(duplicated_ids, collapse = ", ")
    )
}

names(soy_fasta) <- fasta_seqnames

fasta_lengths <- as.numeric(Biostrings::width(soy_fasta))
if (anyNA(fasta_lengths) || any(fasta_lengths <= 0)) {
    stop("The FASTA contains missing or non-positive sequence lengths.")
}

soy_chrominfo <- GenomeInfoDb::Seqinfo(
    seqnames = fasta_seqnames,
    seqlengths = fasta_lengths,
    isCircular = rep(FALSE, length(fasta_seqnames)),
    genome = genome_assembly
)

cat("Number of reference sequences:", length(soy_chrominfo), "\n")
cat("Reference assembly:", genome_assembly, "\n")

# -------------------------------------------------------------------------
# 3. Generate the TxDb from the original GFF3
# -------------------------------------------------------------------------

cat("Building TxDb from the JGI/Phytozome GFF3 file...\n")

# Do not suppress warnings from the source annotation or txdbmaker.
# Supplying the FASTA-derived Seqinfo as chrominfo preserves the complete
# reference sequence dictionary and the Wm82.a4.v1 genome label.
soy_txdb <- txdbmaker::makeTxDbFromGFF(
    file = gff_file,
    format = "gff3",
    dataSource = "Joint Genome Institute (JGI)/Phytozome",
    organism = organism_name,
    taxonomyId = taxonomy_id,
    chrominfo = soy_chrominfo
)

# -------------------------------------------------------------------------
# 4. Validate sequence information before saving
# -------------------------------------------------------------------------

validate_txdb_seqinfo <- function(txdb, expected_seqnames, expected_lengths,
                                  expected_genome, stage) {
    txdb_seqinfo <- GenomeInfoDb::seqinfo(txdb)

    observed_seqnames <- GenomeInfoDb::seqlevels(txdb_seqinfo)
    observed_lengths <- as.numeric(
        GenomeInfoDb::seqlengths(txdb_seqinfo)
    )
    observed_genome <- as.character(
        GenomeInfoDb::genome(txdb_seqinfo)
    )

    if (!identical(observed_seqnames, expected_seqnames)) {
        stop(
            stage,
            ": TxDb sequence names or their order do not match the FASTA."
        )
    }
    if (!identical(observed_lengths, expected_lengths)) {
        stop(stage, ": TxDb sequence lengths do not match the FASTA.")
    }
    if (!length(observed_genome) ||
        anyNA(observed_genome) ||
        !all(observed_genome == expected_genome)) {
        stop(
            stage,
            ": the TxDb does not retain the expected genome label ",
            expected_genome,
            ". Observed labels: ",
            paste(unique(observed_genome), collapse = ", ")
        )
    }

    invisible(txdb_seqinfo)
}

validate_txdb_seqinfo(
    soy_txdb,
    expected_seqnames = fasta_seqnames,
    expected_lengths = fasta_lengths,
    expected_genome = genome_assembly,
    stage = "In-memory validation"
)

# -------------------------------------------------------------------------
# 5. Save, reload, and validate the SQLite database
# -------------------------------------------------------------------------

AnnotationDbi::saveDb(soy_txdb, file = output_sqlite)
cat("SQLite database saved to:", normalizePath(output_sqlite), "\n")

soy_txdb_reloaded <- AnnotationDbi::loadDb(output_sqlite)

validate_txdb_seqinfo(
    soy_txdb_reloaded,
    expected_seqnames = fasta_seqnames,
    expected_lengths = fasta_lengths,
    expected_genome = genome_assembly,
    stage = "Post-reload validation"
)

cat("SQLite reload and sequence-information validation passed.\n")

# -------------------------------------------------------------------------
# 6. Report database content
# -------------------------------------------------------------------------

cat("Number of genes:", length(GenomicFeatures::genes(soy_txdb_reloaded)), "\n")
cat(
    "Number of transcripts:",
    length(GenomicFeatures::transcripts(soy_txdb_reloaded)),
    "\n"
)
cat("Number of exons:", length(GenomicFeatures::exons(soy_txdb_reloaded)), "\n")
cat("Number of CDS features:", length(GenomicFeatures::cds(soy_txdb_reloaded)), "\n")

cat("Sequence information (all FASTA sequences):\n")
print(GenomeInfoDb::seqinfo(soy_txdb_reloaded))

cat("\nData generation and validation completed successfully.\n")
