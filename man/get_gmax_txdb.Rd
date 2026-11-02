\\name{get_gmax_txdb}
\\alias{get_gmax_txdb}
\\title{Retrieve the Wm82.a4.v1 TxDb from AnnotationHub}
\\usage{
get_gmax_txdb(hub = AnnotationHub())
}
\\arguments{
  \\item{hub}{An \\code{AnnotationHub} object. By default, a new
  AnnotationHub instance is created. Supplying an existing object allows
  reuse of an AnnotationHub instance and its cache.}
}
\\value{
A \\code{TxDb} object for \\emph{Glycine max} (Wm82.a4.v1).
}
\\description{
Retrieves the \\emph{Glycine max} transcript database corresponding to the
JGI/Phytozome Wm82.a4.v1 annotation from AnnotationHub.
}
\\details{
The current AnnotationHub resource identifier is \\code{AH122288}.
}
\\examples{
formals(get_gmax_txdb)

## Retrieval requires network access:
## txdb <- get_gmax_txdb()
}
