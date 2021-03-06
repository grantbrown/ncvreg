\name{pa.cv.ncvreg}
\alias{pa.cv.ncvreg}
\title{Cross-validation for ncvreg}
\description{Performs k-fold cross validation for MCP- or SCAD-penalized
  regression models over a grid of values for the regularization
  parameter lambda in parallel using clusters created by the R \code{parallel} 
  package. Otherwise identical to \code{cv.ncvreg}.}
\usage{
pa.cv.ncvreg(cl, X, y, ..., nfolds=10, seed, trace=FALSE)
}
\arguments{
  \item{cl}{A cluster object created with \code{makeCluster}.}
  \item{X}{The design matrix, without an intercept, as in
    \code{ncvreg}.}
  \item{y}{The response vector, as in \code{ncvreg}.}
  \item{...}{Additional arguments to \code{ncvreg}.}
  \item{nfolds}{The number of cross-validation folds.  Default is 10.}
  \item{seed}{You may set the seed of the random number generator in
    order to obtain reproducible results.}
  \item{trace}{If set to TRUE, pa.cv.ncvreg will provide 
    an indication of progress in processing CV folds. Due to the
    parallelized execution of each fold, however, behavior equivalent
    to \code{trace=TRUE} in \code{cv.ncvreg} is not available. Default is
    FALSE.}
  }
\details{
  The function calls \code{ncvreg} \code{nfolds} times, each time
  leaving out 1/\code{nfolds} of the data.  The cross-validation
  error is based on the residual sum of squares when
  \code{family="gaussian"} and the binomial deviance when
  \code{family="binomial"}.}
\value{
  An object with S3 class \code{"cv.ncvreg"} containing:
  \item{cve}{The error for each value of \code{lambda}, averaged
    across the cross-validation folds.}
  \item{cvse}{The estimated standard error associated with each value of
    for \code{cve}.}
  \item{lambda}{The sequence of regularization parameter values along
    which the cross-validation error was calculated.}
  \item{fit}{The fitted \code{ncvreg} object for the whole data.}
  \item{min}{The index of \code{lambda} corresponding to
    \code{lambda.min}.}
  \item{lambda.min}{The value of \code{lambda} with the minimum
    cross-validation error.}
  \item{null.dev}{The deviance for the intercept-only model.}
  \item{pe}{If \code{family="binomial"}, the cross-validation prediction
    error for each value of \code{lambda}.}
  }
\references{Breheny, P. and Huang, J. (2011) Coordinate descent
  algorithms for nonconvex penalized regression, with applications to
  biological feature selection. Ann. Appl. Statist., 5: 232-253.}
\author{Patrick Breheny <patrick-breheny@uiowa.edu>}
\seealso{\code{ncvreg}, \code{cv.ncvreg}, \code{plot.cv.ncvreg}, \code{summary.cv.ncvreg}}
\examples{
data(prostate)
X <- as.matrix(prostate[,1:8])
y <- prostate$lpsa
cl=makeCluster(3)
cvfit <- pa.cv.ncvreg(cl,X,y)
stopCluster(cl)
plot(cvfit)
summary(cvfit)

fit <- cvfit$fit
plot(fit)
beta <- fit$beta[,cvfit$min]
}
