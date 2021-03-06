# This tests the behaviour of the isOutlier() function.
# library(testthat); library(scater); source("test-qc-outlier.R")

set.seed(1000)
test_that("isOutlier works correctly with vanilla applications", {
    vals <- c(rnorm(10000), rnorm(100, sd=10))        
    out <- isOutlier(vals)
       
    # Checking that thresholds are correctly computed.
    MAD <- mad(vals)
    MED <- median(vals)
    lower <- MED - MAD * 3
    higher <- MED + MAD * 3
    expect_equal(attr(out, "thresholds"), c(lower=lower, higher=higher))
    expect_identical(as.logical(out), vals > higher | vals < lower)

    out.5 <- isOutlier(vals, nmads=5)
    expect_equal(attr(out.5, "thresholds"), c(lower=MED - MAD * 5, higher=MED + MAD * 5))

    # Consistent with just lower or higher.
    out.L <- isOutlier(vals, type="lower")
    out.H <- isOutlier(vals, type="higher")
    expect_identical(as.logical(out), out.L | out.H)
    
    expect_equal(attr(out.L, "thresholds"), c(lower=lower, higher=Inf))
    expect_equal(as.logical(out.L), vals < lower)

    expect_equal(attr(out.H, "thresholds"), c(lower=-Inf, higher=higher))
    expect_equal(as.logical(out.H), vals > higher)
})

set.seed(1001)
test_that("isOutlier responds to the minimum difference", {
    vals <- c(rnorm(10000), rnorm(100, sd=10))
    for (min.diff in c(1, 5, 10)) {
        out <- isOutlier(vals, min_diff=min.diff)
       
        # Checking that thresholds are correctly computed.
        relative.threshold <- max(min.diff, mad(vals) * 3)
        lower <- median(vals) - relative.threshold
        higher <- median(vals) + relative.threshold
        expect_equal(attr(out, "thresholds"), c(lower=lower, higher=higher))
        expect_identical(as.logical(out), vals > higher | vals < lower)
    }
})

set.seed(1002)
test_that("isOutlier responds to subsetting for threshold calculations", {
    vals <- c(rnorm(10000), rnorm(100, sd=10))
    chosen <- sample(length(vals), 1000)
    out <- isOutlier(vals, subset=chosen)   
    out2 <- isOutlier(vals[chosen])

    thresholds <- attr(out, "thresholds")
    expect_identical(thresholds, attr(out2, "thresholds"))
    expect_identical(out[chosen], as.logical(out2))
    expect_identical(as.logical(out), vals < thresholds[1] | vals > thresholds[2])

    # NA inputs are automatically subsetted.
    vals.NA <- vals
    vals.NA[chosen] <- NA
    expect_warning(out.NA <- isOutlier(vals.NA), "missing values")
    ref.NA <- isOutlier(vals[-chosen])

    expect_identical(attr(out.NA, "thresholds"), attr(ref.NA, "thresholds"))
    expect_identical(out.NA[-chosen], as.logical(ref.NA))
    expect_identical(out.NA[chosen], rep(NA, length(chosen)))
})

set.seed(1003)
test_that("isOutlier responds to request for log-transformation", {
    vals <- c(1e-8, 100:200, 1000)
    by.log <- isOutlier(vals, log=TRUE)
    manual <- isOutlier(log(vals))
    expect_identical(as.logical(by.log), as.logical(manual))

    # Thresholds are un-adjusted for the log-transformation.
    thresh.log <- attr(by.log, "thresholds")
    thresh.man <- attr(manual, "thresholds")
    expect_equal(thresh.log, exp(thresh.man))
})

set.seed(1004)
test_that("isOutlier responds to batch specification", {
    vals <- c(rnorm(10000), rnorm(100, sd=10))
    batches <- sample(5, length(vals), replace=TRUE)
    out <- isOutlier(vals, batch=batches)

    for (b in unique(batches)) {
        chosen <- batches==b
        current <- isOutlier(vals[chosen])
        expect_identical(as.logical(current), out[chosen])
        expect_equal(attr(current, "thresholds"), attr(out, "thresholds")[,as.character(b)])
    }

    # Responds correctly when subset is also specified.
    sampled <- sample(length(vals), 1000)
    out <- isOutlier(vals, batch=batches, subset=sampled)

    for (b in unique(batches)) {
        chosen <- intersect(which(batches==b), sampled)
        current <- isOutlier(vals[chosen])
        expect_identical(as.logical(current), out[chosen])
        expect_equal(attr(current, "thresholds"), attr(out, "thresholds")[,as.character(b)])
    }
})

set.seed(10041)
test_that("isOutlier thresholds are computed correctly with batch specification", {
    vals <- rnorm(1000)
    batches <- gl(2, length(vals)/2)

    out <- isOutlier(vals, batch=batches)
    out1 <- isOutlier(vals[batches==1])
    out2 <- isOutlier(vals[batches==2])
    
    expect_equal(attr(out, "thresholds"), cbind(`1`=attr(out1, "thresholds"), `2`=attr(out2, "thresholds")))
    expect_identical(as.logical(out), as.logical(c(out1, out2)))

    # With log-transformation.
    vals <- rgamma(1000, 1, 1)
    out <- isOutlier(vals, batch=batches, log=TRUE)
    out1 <- isOutlier(vals[batches==1], log=TRUE)
    out2 <- isOutlier(vals[batches==2], log=TRUE)
    
    expect_equal(attr(out, "thresholds"), cbind(`1`=attr(out1, "thresholds"), `2`=attr(out2, "thresholds")))
    expect_identical(as.logical(out), as.logical(c(out1, out2)))
})

set.seed(10041)
test_that("isOutlier thresholds are computed correctly with sharingness", {
    vals <- rnorm(1000)
    batches <- gl(2, length(vals)/2)

    out <- isOutlier(vals, batch=batches, share_medians=TRUE, share_mads=TRUE)
    ref <- isOutlier(vals)
    expect_identical(as.logical(out), as.logical(ref))
    expect_identical(attr(out, "thresholds")[,1], attr(ref, "thresholds"))
    expect_identical(attr(out, "thresholds")[,2], attr(ref, "thresholds"))

    out <- isOutlier(vals, batch=batches, share_medians=TRUE)
    common.med <- median(vals)
    mad1 <- mad(vals[batches==1], center=common.med)
    mad2 <- mad(vals[batches==2], center=common.med)
    expect_equivalent(attr(out, "thresholds")[,1], common.med + c(-1, 1) * 3 * mad1)
    expect_equivalent(attr(out, "thresholds")[,2], common.med + c(-1, 1) * 3 * mad2)

    out <- isOutlier(vals, batch=batches, share_mads=TRUE)
    med1 <- median(vals[batches==1])
    med2 <- median(vals[batches==2])
    common.mad <- median(abs(vals - c(med1, med2)[batches])) * formals(mad)$constant
    expect_equivalent(attr(out, "thresholds")[,1], med1 + c(-1, 1) * 3 * common.mad)
    expect_equivalent(attr(out, "thresholds")[,2], med2 + c(-1, 1) * 3 * common.mad)
})

set.seed(10041)
test_that("isOutlier thresholds correctly recover missing batches", {
    vals <- rnorm(1000)
    batches <- gl(2, length(vals)/2)

    out <- isOutlier(vals, batch=batches, subset=batches==1)
    ref <- isOutlier(vals[batches==1])
    expect_identical(attr(out, "thresholds")[,1], attr(ref, "thresholds"))
    expect_identical(attr(out, "thresholds")[,2], attr(ref, "thresholds"))

    out <- isOutlier(vals, batch=batches, subset=batches==1, share_missing=FALSE)
    expect_equivalent(out[batches==1], ref)
    expect_true(all(is.na(out[batches==2])))
})    

set.seed(1005)
test_that("isOutlier handles silly inputs correctly", {
    out <- isOutlier(numeric(0))
    expect_identical(as.logical(out), logical(0))

    expect_error(out <- isOutlier(numeric(0), batch=1), "length of 'batch'")

    out <- isOutlier(1:10, subset=integer(0))
    expect_identical(as.logical(out), rep(NA, 10))
})
