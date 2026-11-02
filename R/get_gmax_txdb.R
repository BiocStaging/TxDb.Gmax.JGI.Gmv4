#' Retrieve the Wm82.a4.v1 TxDb from AnnotationHub
#'
#' Retrieve the \emph{Glycine max} transcript database corresponding to the
#' JGI/Phytozome Wm82.a4.v1 annotation.
#'
#' @importClassesFrom GenomicFeatures TxDb
#' @importFrom AnnotationHub AnnotationHub
#' @param hub An \code{AnnotationHub} object. By default, a new AnnotationHub
#'   instance is created. Supplying an existing object allows reuse of an
#'   AnnotationHub instance and its cache.
#'
#' @return A \code{TxDb} object for \emph{Glycine max} (Wm82.a4.v1).
#'
#' @details
#' The current AnnotationHub resource identifier is \code{AH122288}.
#'
#' @examples
#' formals(get_gmax_txdb)
#'
#' # Retrieve the resource (requires network access):
#' # txdb <- get_gmax_txdb()
#'
#' @export
get_gmax_txdb <- function(hub = AnnotationHub()) {
    hub[["AH122288"]]
}
