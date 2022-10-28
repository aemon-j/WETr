#'@title Run the GOTM-WET model
#'
#'@description
#'This runs the GOTM-WET model on the specific simulation stored in
#'\code{sim_folder}. The specified \code{sim_folder} must contain
#'valid NML files.
#'
#'@param sim_folder the directory where simulation files are contained
#'@param yaml_file filepath; to file with GOTM-WET setup. Defaults to
#''gotm.yaml'
#'@param verbose Save output as character vector. Defaults to FALSE
#'@param args Optional arguments to pass to GOTM-WET executable
#'
#'@keywords methods
#'@author
#'Tadhg Moore, Johannes Feldbauer
#'@examples
#'copy_testcase(".")
#'run_wet()
#'@export
#'@importFrom utils packageName
run_wet <- function (sim_folder = ".", yaml_file = 'gotm.yaml',
                     verbose = FALSE, args = character())
{
  if (!file.exists(file.path(sim_folder, yaml_file))) {
    stop("You must have a valid GOTM setup in your sim_folder: ",
         sim_folder)
  }
  if (.Platform$pkgType == "win.binary") {
    return(run_wetWin(sim_folder, yaml_file = yaml_file, verbose, args))
  }

  ### macOS ###
  if (grepl('mac.binary',.Platform$pkgType)) {
    maj_v_number <- as.numeric(strsplit(
      Sys.info()["release"][[1]],'.', fixed = TRUE)[[1]][1])

    if (maj_v_number < 13.0) {
      stop('pre-mavericks mac OSX is not supported. Consider upgrading')
    }

    return(run_wetOSx(sim_folder, verbose, args))

  }

  if (.Platform$pkgType == "source") {
    return(run_wetNIX(sim_folder, verbose, args))
  }
}

run_wetWin <- function(sim_folder, yaml_file = 'gotm.yaml',
                       verbose = TRUE, args){

  if(.Platform$r_arch == 'x64'){
    wet_path <- system.file("extbin/win64WET/gotmwet_release.exe",
                            package= 'WETr')
  }else{
    stop('No GOTM-WET executable available for your machine yet...')
  }

  args <- c(args, yaml_file)


  origin <- getwd()
  setwd(sim_folder)

  tryCatch({
    if (verbose){
      out <- system2(wet_path, wait = TRUE, stdout = TRUE,
                     stderr = "", args=args)
    } else {
      out <- system2(wet_path, stdout = NULL,
                     stderr = NULL, args=args)
    }
    setwd(origin)
    return(out)
  }, error = function(err) {
    print(paste("GOTM_ERROR:  ",err))
    setwd(origin)
  })
}


run_wetNIX <- function(sim_folder, verbose=TRUE, args){
  origin <- getwd()
  setwd(sim_folder)
  wet_path <- system.file('exec/nixgotm', package=packageName())
  Sys.setenv(LD_LIBRARY_PATH=paste(system.file('extbin/nix',
                                               package=packageName()),
                                   Sys.getenv('LD_LIBRARY_PATH'),
                                   sep = ":"))
  # wet.systemcall(sim_folder = sim_folder, wet_path = wet_path,
  # verbose = verbose, system.args = args)
  tryCatch({
    if (verbose){
      out <- system2(wet_path, wait = TRUE, stdout = "",
                     stderr = "", args = args)
    } else {
      out <- system2(wet_path, wait = TRUE, stdout = NULL,
                     stderr = NULL, args = args)
    }
    setwd(origin)
    return(out)
  }, error = function(err) {
    print(paste("gotm_ERROR:  ",err))
    setwd(origin)
  })
  setwd(origin)
  return(out)
}

### From GLEON/gotm3r
wet.systemcall <- function(sim_folder, wet_path, verbose, system.args) {
  origin <- getwd()
  setwd(sim_folder)

  ### macOS ###
  if (grepl("mac.binary",.Platform$pkgType)) {
    dylib_path <- system.file("exec", package = "WETr")
    tryCatch({
      if (verbose){
        out <- system2(wet_path, wait = TRUE, stdout = "",
                       stderr = "", args = system.args,
                       env = paste0("DYLD_LIBRARY_PATH=", dylib_path))
      } else {
        out <- system2(wet_path, wait = TRUE, stdout = NULL,
                       stderr = NULL, args = system.args,
                       env = paste0("DYLD_LIBRARY_PATH=", dylib_path))
      }
    }, error = function(err) {
      print(paste("GOTM_ERROR:  ",err))
    }, finally = {
      setwd(origin)
      return(out)
    })
  } else {
    tryCatch({
      if (verbose){
        out <- system2(wet_path, wait = TRUE, stdout = "",
                       stderr = "", args = system.args)
      } else {
        out <- system2(wet_path, wait = TRUE, stdout = NULL,
                       stderr = NULL, args = system.args)
      }
    }, error = function(err) {
      print(paste("GOTM_ERROR:  ",err))
    }, finally = {
      setwd(origin)
      return(out)
    })
  }
}

### macOS ###
run_wetOSx <- function(sim_folder, verbose, args){
  wet_path <- system.file('exec/macgotm', package = 'WETr')
  wet.systemcall(sim_folder = sim_folder, wet_path = wet_path,
                 verbose = verbose, system.args = args)
}
