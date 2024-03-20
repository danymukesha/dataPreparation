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
#'     \item{Arg}{Numeric values for Arg.}
#'     \item{Asn}{Numeric values for Asn.}
#'     \item{Asp}{Numeric values for Asp.}
#'     \item{Cit}{Numeric values for Cit.}
#'     \item{Gln}{Numeric values for Gln.}
#'     \item{Glu}{Numeric values for Glu.}
#'     \item{Gly}{Numeric values for Gly.}
#'     \item{His}{Numeric values for His.}
#'     \item{Ile}{Numeric values for Ile.}
#'     \item{Lys}{Numeric values for Lys.}
#'     \item{Met}{Numeric values for Met.}
#'     \item{Orn}{Numeric values for Orn.}
#'     \item{Phe}{Numeric values for Phe.}
#'     \item{Pro}{Numeric values for Pro.}
#'     \item{Ser}{Numeric values for Ser.}
#'     \item{Thr}{Numeric values for Thr.}
#'     \item{Trp}{Numeric values for Trp.}
#'     \item{Tyr}{Numeric values for Tyr.}
#'     \item{Val}{Numeric values for Val.}
#'     \item{xLeu}{Numeric values for xLeu.}
#'     \item{Ac.Orn}{Numeric values for Ac.Orn.}
#'     \item{ADMA}{Numeric values for ADMA.}
#'     \item{alpha.AAA}{Numeric values for alpha.AAA.}
#'     \item{c4.OH.Pro}{Numeric values for c4.OH.Pro.}
#'     \item{Carnosine}{Numeric values for Carnosine.}
#'     \item{Creatinine}{Numeric values for Creatinine.}
#'     \item{DOPA}{Numeric values for DOPA.}
#'     \item{Dopamine}{Numeric values for Dopamine.}
#'     \item{Histamine}{Numeric values for Histamine.}
#'     \item{Kynurenine}{Numeric values for Kynurenine.}
#'     \item{Met.SO}{Numeric values for Met.SO.}
#'     \item{Nitro.Tyr}{Numeric values for Nitro.Tyr.}
#'     \item{PEA}{Numeric values for PEA.}
#'     \item{Putrescine}{Numeric values for Putrescine.}
#'     \item{Sarcosine}{Numeric values for Sarcosine.}
#'     \item{SDMA}{Numeric values for SDMA.}
#'     \item{Serotonin}{Numeric values for Serotonin.}
#'     \item{Spermidine}{Numeric values for Spermidine.}
#'     \item{Spermine}{Numeric values for Spermine.}
#'     \item{t4.OH.Pro}{Numeric values for t4.OH.Pro.}
#'     \item{Taurine}{Numeric values for Taurine.}
#'     \item{CE}{Numeric values for CE.}
#'     \item{DG}{Numeric values for DG.}
#'     \item{TG}{Numeric values for TG.}
#'     \item{LPC}{Numeric values for LPC.}
#'     \item{PC}{Numeric values for PC.}
#'     \item{Cer}{Numeric values for Cer.}
#'     \item{SM}{Numeric values for SM.}
#'     \item{H1}{Numeric values for H1.}
#'   }
#'
#' @seealso
#' Use \code{\link{head}} to see the first few rows of this dataset.
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


