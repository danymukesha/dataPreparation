#' Sample Data for Package Examples
#'
#' This dataset contains sample data used for demonstrating examples in the package.
#'
#' @name sample_data
#' @format A data frame with 100 observations and 68 variables:
#'   \describe{
#'     \item{Sample.Type}{A factor indicating the type of sample (Type1, Type2, Type3).}
#'     \item{Sample.Identification}{A character vector specifying sample identification (ID1, ID2, ...).}
#'     \item{Gender}{A factor indicating gender (Female, Male).}
#'     \item{Age}{An integer indicating age.}
#'     \item{Sample.Description}{A factor specifying sample description (DLB, msAD, miAD, HC).}
#'     \item{Submission.Name}{A factor specifying submission name (plate1, plate2).}
#'     \item{Material}{A factor indicating material (serum, sample).}
#'     \item{Apoe.Genotype}{A factor indicating Apoe genotype (Apoe1, Apoe2, Apoe3, Apoe4).}
#'     \item{AC}{Numeric values for AC.}
#'     \item{Ala}{Numeric values for Ala.}
#'     \item{...}{More numeric variables (Arg, Asn, Asp, Cit, Gln, Glu, Gly,
#'          His, Ile, Lys, Met, Orn, Phe, Pro, Ser, Thr, Trp, Tyr, Val, xLeu,
#'          Ac.Orn, ADMA, alpha.AAA, c4.OH.Pro, Carnosine, Creatinine, DOPA,
#'          Dopamine, Histamine, Kynurenine, Met.SO, Nitro.Tyr, PEA, Putrescine,
#'          Sarcosine, SDMA, Serotonin, Spermidine, Spermine, t4.OH.Pro,
#'          Taurine, CE, DG, TG, LPC, PC, Cer, SM, H1).}
#'   }
#'
#'
"sample_data"

#' The data frame with missing values imputed
#'
#' This dataset contains impute data missing values using k-nearest
#' neighbors algorithm.
#'
#' @name imputed_data
#' @format A data frame with `m` observations(in rows) and
#'  `n` variables(in columns):
#'   \describe{
#'     \item{...}{More numeric variables (Arg, Asn, Asp, Cit, Gln, Glu, Gly,
#'          His, Ile, Lys, Met, Orn, Phe, Pro, Ser, Thr, Trp, Tyr, Val, xLeu,
#'          Ac.Orn, ADMA, alpha.AAA, c4.OH.Pro, Carnosine, Creatinine, DOPA,
#'          Dopamine, Histamine, Kynurenine, Met.SO, Nitro.Tyr, PEA, Putrescine,
#'          Sarcosine, SDMA, Serotonin, Spermidine, Spermine, t4.OH.Pro,
#'          Taurine, CE, DG, TG, LPC, PC, Cer, SM, H1).}
#'   }
#'
"imputed_data"


#' Batch cerration list for Package Examples
#'
#' This list contains two datasets used for demonstrating examples
#'  in the package.
#'
#' @name corrected_list
#' @format A list with 2 datasets:
#'   \describe{
#'     \item{Before correction}{A dataset containing raw data before
#'     batch correction}
#'     \item{removeBatchEffect}{A dataset after correcting raw data using
#'     removeBatchEffect function from `limma` R package.}
#'     }
#'
#'
"corrected_list"


