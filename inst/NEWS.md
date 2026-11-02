# NEWS for TxDb.Gmax.JGI.Gmv4 Package

## Version 0.99.2 (2026-11-02)

- Updated the data-generation workflow to derive sequence information from
  the Wm82.a4.v1 reference FASTA and validate the saved SQLite database.
- Aligned AnnotationHub metadata with the JGI/Phytozome Wm82.a4.v1 source.
- Added `get_gmax_txdb()` for retrieving the TxDb from AnnotationHub.
- Updated package dependencies, installation instructions, and vignette.

## Version 0.99.1 (2026-09-04)

- Fixed the WARNINGS

## Version 0.99.0 (2026-08-07)

### Initial Release

- First release of the package.
- The TxDb resource is distributed through AnnotationHub rather than shipped
  inside the package; it is retrieved at runtime with `AnnotationHub()`.
- Added `inst/scripts/make-data.R` and `inst/scripts/make-metadata.R`
  documenting how the TxDb resource and its AnnotationHub metadata are built.
