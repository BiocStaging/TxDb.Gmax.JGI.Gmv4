test_that("AnnotationHub metadata describes the soybean Wm82.a4.v1 resource", {
    metadata_file <- system.file(
        "extdata",
        "metadata.csv",
        package = "TxDb.Gmax.JGI.Gmv4"
    )

    expect_true(nzchar(metadata_file))

    metadata <- read.csv(metadata_file, stringsAsFactors = FALSE)

    expect_equal(nrow(metadata), 1L)
    expect_equal(metadata$Species, "Glycine max")
    expect_equal(metadata$Genome, "Wm82.a4.v1")
    expect_equal(metadata$SourceType, "GFF")
    expect_equal(metadata$RDataClass, "TxDb")
    expect_equal(metadata$RDataPath,
                 "records/23882021/files/TxDb.Gmax.JGI.Gmv4.sqlite")
})
