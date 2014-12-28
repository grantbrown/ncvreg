Experiments in parallelizing aspects of [Patrick Breheny's](https://github.com/pbreheny) R package: [ncvreg](https://github.com/pbreheny/ncvreg).


Targets:
* High level R parallelization using the [parallel](https://stat.ethz.ch/R-manual/R-devel/library/parallel/doc/parallel.pdf) package. This has been successfully applied to the cv.ncvreg function. Changes are currently located on the [R-parallel](https://github.com/grantbrown/ncvreg/tree/R-parallel) branch, and some initial statistics can be found [here](http://grantbrown.github.io/ncvreg/Reports/RParallalReport/RparallelReport.html).
* Use of Rcpp objects to make low level memory usage less ephemeral between calls to ncvreg within a cv.ncvreg run (single core performance enhancement).  
* Packaging of the core routines into OpenCL kernels, and/or usage of the [clBLAS](https://github.com/clMathLibraries/clBLAS) linear algebra routines to speed up the expensive matrix operations.  
