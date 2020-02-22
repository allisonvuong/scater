// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// create_lazy_vector
SEXP create_lazy_vector(SEXP mat, SEXP dim, SEXP idx, bool getcol, int matclass, int type);
RcppExport SEXP _scater_create_lazy_vector(SEXP matSEXP, SEXP dimSEXP, SEXP idxSEXP, SEXP getcolSEXP, SEXP matclassSEXP, SEXP typeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< SEXP >::type mat(matSEXP);
    Rcpp::traits::input_parameter< SEXP >::type dim(dimSEXP);
    Rcpp::traits::input_parameter< SEXP >::type idx(idxSEXP);
    Rcpp::traits::input_parameter< bool >::type getcol(getcolSEXP);
    Rcpp::traits::input_parameter< int >::type matclass(matclassSEXP);
    Rcpp::traits::input_parameter< int >::type type(typeSEXP);
    rcpp_result_gen = Rcpp::wrap(create_lazy_vector(mat, dim, idx, getcol, matclass, type));
    return rcpp_result_gen;
END_RCPP
}
// per_cell_qc
Rcpp::RObject per_cell_qc(Rcpp::RObject matrix, Rcpp::List featcon, Rcpp::IntegerVector top, SEXP limit);
RcppExport SEXP _scater_per_cell_qc(SEXP matrixSEXP, SEXP featconSEXP, SEXP topSEXP, SEXP limitSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< Rcpp::RObject >::type matrix(matrixSEXP);
    Rcpp::traits::input_parameter< Rcpp::List >::type featcon(featconSEXP);
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type top(topSEXP);
    Rcpp::traits::input_parameter< SEXP >::type limit(limitSEXP);
    rcpp_result_gen = Rcpp::wrap(per_cell_qc(matrix, featcon, top, limit));
    return rcpp_result_gen;
END_RCPP
}
// per_feature_qc
Rcpp::RObject per_feature_qc(Rcpp::RObject matrix, Rcpp::List cellcon, SEXP limit);
RcppExport SEXP _scater_per_feature_qc(SEXP matrixSEXP, SEXP cellconSEXP, SEXP limitSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< Rcpp::RObject >::type matrix(matrixSEXP);
    Rcpp::traits::input_parameter< Rcpp::List >::type cellcon(cellconSEXP);
    Rcpp::traits::input_parameter< SEXP >::type limit(limitSEXP);
    rcpp_result_gen = Rcpp::wrap(per_feature_qc(matrix, cellcon, limit));
    return rcpp_result_gen;
END_RCPP
}
// top_cumprop
Rcpp::NumericMatrix top_cumprop(Rcpp::RObject matrix, Rcpp::IntegerVector top);
RcppExport SEXP _scater_top_cumprop(SEXP matrixSEXP, SEXP topSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< Rcpp::RObject >::type matrix(matrixSEXP);
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type top(topSEXP);
    rcpp_result_gen = Rcpp::wrap(top_cumprop(matrix, top));
    return rcpp_result_gen;
END_RCPP
}
// sum_row_counts
Rcpp::RObject sum_row_counts(Rcpp::RObject counts, Rcpp::IntegerVector genes, Rcpp::IntegerVector runs);
RcppExport SEXP _scater_sum_row_counts(SEXP countsSEXP, SEXP genesSEXP, SEXP runsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< Rcpp::RObject >::type counts(countsSEXP);
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type genes(genesSEXP);
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type runs(runsSEXP);
    rcpp_result_gen = Rcpp::wrap(sum_row_counts(counts, genes, runs));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_scater_create_lazy_vector", (DL_FUNC) &_scater_create_lazy_vector, 6},
    {"_scater_per_cell_qc", (DL_FUNC) &_scater_per_cell_qc, 4},
    {"_scater_per_feature_qc", (DL_FUNC) &_scater_per_feature_qc, 3},
    {"_scater_top_cumprop", (DL_FUNC) &_scater_top_cumprop, 2},
    {"_scater_sum_row_counts", (DL_FUNC) &_scater_sum_row_counts, 3},
    {NULL, NULL, 0}
};

void init_lazy_vector(DllInfo* dll);
RcppExport void R_init_scater(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
    init_lazy_vector(dll);
}
