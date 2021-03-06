#' @name norm_exprs
#' @aliases norm_exprs
#' @export
#' @docType methods
#' @return a matrix of normalised expression data
#' @rdname accessors
setGeneric("norm_exprs", function(object) standardGeneric("norm_exprs"))

#' @name norm_exprs<-
#' @aliases norm_exprs<-
#' @export
#' @docType methods
#' @rdname accessors
setGeneric("norm_exprs<-", function(object, value) standardGeneric("norm_exprs<-"))

#' @name stand_exprs
#' @aliases stand_exprs
#' @export
#' @docType methods
#' @return a matrix of standardised expressiond data
#' @rdname accessors
setGeneric("stand_exprs", function(object) standardGeneric("stand_exprs"))

#' @name stand_exprs<-
#' @aliases stand_exprs<-
#' @export
#' @docType methods
#' @rdname accessors
setGeneric("stand_exprs<-", function(object, value) standardGeneric("stand_exprs<-"))

#' @name bootstraps
#' @export
#' @docType methods
#' @rdname bootstraps
setGeneric("bootstraps", function(object) standardGeneric("bootstraps"))

#' @name bootstraps<-
#' @export
#' @docType methods
#' @rdname bootstraps
setGeneric("bootstraps<-", function(object, value) standardGeneric("bootstraps<-"))

#' @name fpkm
#' @aliases  fpkm
#' @export
#' @docType methods
#' @return a matrix of FPKM values
#' @rdname accessors
setGeneric("fpkm", function(object) standardGeneric("fpkm"))

#' @name fpkm<-
#' @aliases  fpkm<-
#' @export
#' @docType methods
#' @rdname accessors
setGeneric("fpkm<-", function(object, value) standardGeneric("fpkm<-"))

#############################
# Metric calculator generics.

#' @export
#' @rdname perCellQCMetrics
setGeneric("perCellQCMetrics", function(x, ...) standardGeneric("perCellQCMetrics"))

#' @export
#' @rdname perFeatureQCMetrics
setGeneric("perFeatureQCMetrics", function(x, ...) standardGeneric("perFeatureQCMetrics"))

#' @export
#' @rdname getVarianceExplained
setGeneric("getVarianceExplained", function(x, ...) standardGeneric("getVarianceExplained"))

#' @export
#' @rdname calculateAverage
setGeneric("calculateAverage", function(x, ...) standardGeneric("calculateAverage"))

#' @export
#' @rdname nexprs
setGeneric("nexprs", function(x, ...) standardGeneric("nexprs"))

####################################
# Dimensionality reduction generics.

#' @export
#' @rdname runPCA
setGeneric("calculatePCA", function(x, ...) standardGeneric("calculatePCA"))

#' @export
#' @rdname runTSNE
setGeneric("calculateTSNE", function(x, ...) standardGeneric("calculateTSNE"))

#' @export
#' @rdname runUMAP
setGeneric("calculateUMAP", function(x, ...) standardGeneric("calculateUMAP"))

#' @export
#' @rdname runMDS
setGeneric("calculateMDS", function(x, ...) standardGeneric("calculateMDS"))

#' @export
#' @rdname runNMF
setGeneric("calculateNMF", function(x, ...) standardGeneric("calculateNMF"))

#' @export
#' @rdname runDiffusionMap
setGeneric("calculateDiffusionMap", function(x, ...) standardGeneric("calculateDiffusionMap"))

#################################
# Normalization-related generics.

#' @export
#' @rdname logNormCounts
setGeneric("logNormCounts", function(x, ...) standardGeneric("logNormCounts"))

#' @export
#' @rdname librarySizeFactors
setGeneric("librarySizeFactors", function(x, ...) standardGeneric("librarySizeFactors"))

#' @export
#' @rdname medianSizeFactors
setGeneric("medianSizeFactors", function(x, ...) standardGeneric("medianSizeFactors"))

#' @export
#' @rdname normalizeCounts
setGeneric("normalizeCounts", function(x, ...) standardGeneric("normalizeCounts"))

#' @export
#' @rdname calculateCPM
setGeneric("calculateCPM", function(x, ...) standardGeneric("calculateCPM"))

#' @export
#' @rdname calculateTPM
setGeneric("calculateTPM", function(x, ...) standardGeneric("calculateTPM"))

#################################
# Aggregation-related generics.

#' @export
#' @rdname sumCountsAcrossFeatures
setGeneric("sumCountsAcrossFeatures", function(x, ...) standardGeneric("sumCountsAcrossFeatures"))

#' @export
#' @rdname sumCountsAcrossCells
setGeneric("sumCountsAcrossCells", function(x, ...) standardGeneric("sumCountsAcrossCells"))

#' @export
#' @rdname sumCountsAcrossCells
setGeneric("aggregateAcrossCells", function(x, ...) standardGeneric("aggregateAcrossCells"))

#' @export
#' @rdname numDetectedAcrossCells
setGeneric("numDetectedAcrossCells", function(x, ...) standardGeneric("numDetectedAcrossCells"))

#' @export
#' @rdname numDetectedAcrossFeatures
setGeneric("numDetectedAcrossFeatures", function(x, ...) standardGeneric("numDetectedAcrossFeatures"))
