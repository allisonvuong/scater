#' Developer utilities
#'
#' Various utilities for re-use in packages that happen to depend on \pkg{scater}.
#' These are exported simply to avoid re-writing them in downstream packages, and should not be touched by end-users.
#'
#' @author Aaron Lun
#' @name scater-utils
#' @docType class
#' @aliases .splitRowsByWorkers
#' .splitColsByWorkers
#' .splitVectorByWorkers
#' .assignIndicesToWorkers 
#' .subset2index
#' .bpNotSharedOrUp
NULL

#' @export
#' @importFrom BiocParallel bpnworkers
.splitRowsByWorkers <- function(x, BPPARAM, subset_row=NULL, subset_col=NULL, assignments=NULL) {
    if (bpnworkers(BPPARAM)==1L) {
        if (!.noOpSubset(subset_row, nrow(x))) {
            x <- x[subset_row,,drop=FALSE]
        }
        if (!.noOpSubset(subset_col, ncol(x))) {
            x <- x[,subset_col,drop=FALSE]
        }

        list(x)
    } else {
        if (is.null(assignments)) {
            assignments <- .assignIndicesToWorkers(nrow(x), BPPARAM, subset=subset_row)
        }

        for (i in seq_along(assignments)) {
            current <- x[assignments[[i]],,drop=FALSE]
            if (!.noOpSubset(subset_col, ncol(x))) {
                current <- current[,subset_col,drop=FALSE]
            }
            assignments[[i]] <- current
        }
    
        assignments
    }
}

#' @export
#' @importFrom BiocParallel bpnworkers
.splitColsByWorkers <- function(x, BPPARAM, subset_row=NULL, subset_col=NULL, assignments=NULL) {
    if (bpnworkers(BPPARAM)==1L) {
        if (!.noOpSubset(subset_row, nrow(x))) {
            x <- x[subset_row,,drop=FALSE]
        }
        if (!.noOpSubset(subset_col, ncol(x))) {
            x <- x[,subset_col,drop=FALSE]
        }

        list(x)
    } else {
        if (is.null(assignments)) {
            assignments <- .assignIndicesToWorkers(ncol(x), BPPARAM, subset=subset_col)
        }

        for (i in seq_along(assignments)) {
            current <- x[,assignments[[i]],drop=FALSE]
            if (!.noOpSubset(subset_row, nrow(x))) {
                current <- current[subset_row,,drop=FALSE]
            }
            assignments[[i]] <- current
        }
    
        assignments
    }
}

#' @export
.splitVectorByWorkers <- function(x, BPPARAM, subset=NULL, assignments=NULL) {
    if (bpnworkers(BPPARAM)==1L) {
        if (!.noOpSubset(subset, length(x))) {
            x <- x[subset]
        }
        list(x)
    } else {
        if (is.null(assignments)) {
            assignments <- .assignIndicesToWorkers(length(x), BPPARAM, subset=subset)
        }
        for (i in seq_along(assignments)) {
            assignments[[i]] <- x[assignments[[i]]]
        }
        assignments
    }
}

#' @export
#' @importFrom BiocParallel bpnworkers
#' @importFrom utils head
.assignIndicesToWorkers <- function(njobs, BPPARAM, subset=NULL) {
    if (!is.null(subset)) {
        subset <- as.vector(subset)
        if (is.logical(subset)) {
            subset <- which(subset)
        }
        njobs <- length(subset)
    }

    n_cores <- bpnworkers(BPPARAM)
    boundaries <- as.integer(seq(from = 0L, to = njobs, length.out = n_cores + 1L))
    per_core <- diff(boundaries)
    work_starts <- head(boundaries, -1L)
    output <- mapply("+", lapply(per_core, seq_len), work_starts, SIMPLIFY=FALSE)

    if (!is.null(subset)) {
        for (i in seq_along(output)) {
            output[[i]] <- subset[output[[i]]]            
        }
    }

    output
}

#' @export
#' @importClassesFrom BiocParallel MulticoreParam
#' @importFrom BiocParallel bpisup
.bpNotSharedOrUp  <- function(BPPARAM) !bpisup(BPPARAM) && !is(BPPARAM, "MulticoreParam")
