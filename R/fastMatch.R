#' Operator for fast matching
#'
#' @import fastmatch

`%fin%` <- function(x, table) {
  stopifnot(require(fastmatch))
  fmatch(x, table, nomatch = 0L) > 0L
}
