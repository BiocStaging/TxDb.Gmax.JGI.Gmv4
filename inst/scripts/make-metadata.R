### =========================================================================
### make-metadata.R
### -------------------------------------------------------------------------
###
### Generate inst/extdata/metadata.csv for the soybean TxDb AnnotationHub
### resource. Validate the output with:
###
###   AnnotationHubData::makeAnnotationHubMetadata("<path to package>")
###
### The RDataPath below refers to the currently registered Zenodo record.
### If a rebuilt SQLite file is deposited under a new Zenodo record, update
### RDataPath (and confirm the new AnnotationHub resource ID) accordingly.
###

jgi_portal <- paste0(
    "https://data.jgi.doe.gov/refine-download/phytozome",
    "?expanded=Phytozome-508&genome_id=508"
)

meta <- data.frame(
    Title = "TxDb.Gmax.JGI.Gmv4 JGI/Phytozome Wm82.a4.v1",
    Description = paste(
        "Transcript, exon, and CDS annotations for Glycine max",
        "(Wm82.a4.v1), generated from the JGI/Phytozome gene GFF3 annotation."
    ),
    BiocVersion = "3.24",
    Genome = "Wm82.a4.v1",
    SourceType = "GFF",
    SourceVersion = "Wm82.a4.v1",
    SourceUrl = jgi_portal,
    Species = "Glycine max",
    TaxonomyId = "3847",
    Coordinate_1_based = TRUE,
    DataProvider = "Joint Genome Institute (JGI)/Phytozome",
    Maintainer = "Kabilan S <kabilan151414@gmail.com>",
    RDataClass = "TxDb",
    DispatchClass = "SQLiteFile",
    Location_Prefix = "https://zenodo.org/",
    RDataPath = "record/21847817/files/TxDb.Gmax.JGI.Gmv4.sqlite",
    Tags = "AnnotationData:TxDb:Glycine_max:SequenceAnnotation:AnnotationHub",
    stringsAsFactors = FALSE
)

write.csv(
    meta,
    file = "inst/extdata/metadata.csv",
    row.names = FALSE,
    na = ""
)
