#'@title Return the current GOTM-WET model version
#'
#'@description
#'Returns the current version of the GOTM-WET model being used
#'
#'@keywords methods
#'
#'@author
#'Tadhg Moore, Johannes Feldbauer
#'@examples
#' print(wet_version())
#'
#'
#'@export
wet_version <- function(){
  run_wet(".", verbose=TRUE, args='--version')
}
