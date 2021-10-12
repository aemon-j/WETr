#'@title copy template files to a specified folder
#'
#'@description
#'This function copies the files for the test case of Lake Bryrup, Denmark provided on the gitlab page of WET
#'
#'@keywords methods
#'
#'@param folder the folder where the test case files should be copied to
#'@author
#'Johannes feldbauer
#'@examples
#'\dontrun{
#' copy_testcase(".")
#'}
#'
#'@export
copy_testcase <- function(folder = "."){
  file.copy(from = file.path(system.file("extdata/", package=packageName()),
                             list.files(system.file("extdata/", package=packageName()))),
            to = folder)
}
