\name{TxDb.Gmax.JGI.Gmv4}
\docType{package}

\alias{TxDb.Gmax.JGI.Gmv4-package}
\alias{TxDb.Gmax.JGI.Gmv4}

\title{Transcript annotation database for soybean}

\description{
  \pkg{TxDb.Gmax.JGI.Gmv4} provides transcript, exon, and coding sequence
  (CDS) annotations for soybean (\emph{Glycine max}, Wm82.a4.v1), based on
  the JGI/Phytozome GFF3 annotation. The TxDb object is hosted in
  AnnotationHub and can be retrieved directly with the AnnotationHub
  package.
}

\note{
  The TxDb object is not bundled inside this package. It is distributed
  through AnnotationHub and cached locally after retrieval.
}

\author{
  Dwijesh Chandra Mishra (aut),
  Kabilan S (aut, cre) \email{kabilan151414@gmail.com}
}

\seealso{
  \link[GenomicFeatures]{genes},
  \link[GenomicFeatures]{transcripts},
  \link[GenomicFeatures]{transcriptsBy}
}

\examples{
## Search AnnotationHub for the current resource (requires network access):
## ah <- AnnotationHub::AnnotationHub()
## query(ah, "TxDb.Gmax.JGI.Gmv4")
## txdb <- ah[["AH122288"]]  # use the current ID returned by query()
}

\keyword{package}
\keyword{data}
