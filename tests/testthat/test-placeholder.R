test_that("get_gmax_txdb is exported and has an optional hub argument", {
    expect_true(
        "get_gmax_txdb" %in%
            getNamespaceExports("TxDb.Gmax.JGI.Gmv4")
    )
    expect_identical(names(formals(get_gmax_txdb)), "hub")
})
