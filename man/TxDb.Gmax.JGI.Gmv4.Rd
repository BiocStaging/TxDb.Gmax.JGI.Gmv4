\name{TxDb.Gmax.JGI.Gmv4}
\docType{package}

\alias{TxDb.Gmax.JGI.Gmv4-package}
\alias{TxDb.Gmax.JGI.Gmv4}

\title{Transcript annotation database for soybean}

\description{
  \pkg{TxDb.Gmax.JGI.Gmv4} provides transcript, exon, and coding sequence
  (CDS) annotations for soybean (\emph{Glycine max}, Wm82.a4.v1), based on
  the JGI/Phytozome GFF3 annotation. The TxDb object is hosted in
  AnnotationHub and can be retrieved with \code{get_gmax_txdb()}.
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
  \code{\link{get_gmax_txdb}},
  \link[GenomicFeatures]{transcripts},
  \link[GenomicFeatures]{transcriptsBy}
}

\examples{
formals(get_gmax_txdb)
}

\keyword{package}
\keyword{data}
