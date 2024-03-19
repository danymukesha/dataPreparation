#' Process Data
#'
#' Process the input data using various methods including filtering, CLR transformation, batch effect correction, and PCA.
#'
#' @param data A matrix or data frame containing the input data.
#' @param categories A data frame containing categorical information for the samples.
#' @return A list containing processed data and corresponding PCA plots.
#' @examples
#' # Generate sample data
#' set.seed(123)
#' data <- data.frame(
#'   Sample.Type = sample(c("Type1", "Type2", "Type3"), 100, replace = TRUE),
#'   Sample.Identification = paste0("ID", 1:100),
#'   Gender = sample(c("Female", "Male"), 100, replace = TRUE),
#'   Age = sample(20:80, 100, replace = TRUE),
#'   Sample.Description = sample(c("DLB", "msAD", "miAD", "HC"), 100, replace = TRUE),
#'   Submission.Name = sample(c("plate1", "plate2"), 100, replace = TRUE),
#'   Material = sample(c("serum", "sample"), 100, replace = TRUE),
#'   Apoe.Genotype = sample(c("Apoe1", "Apoe2", "Apoe3", "Apoe4"), 100, replace = TRUE),
#'   AC = rnorm(100),
#'   Ala = rnorm(100),
#'   # ... Additional variables ...
#'   H1 = rnorm(100)
#' )
#'
#' categories <- data.frame(
#'   firID = 1:100,
#'   Sample.Description = sample(c("DLB", "msAD", "miAD", "HC"), 100, replace = TRUE),
#'   Allgr = sample(c("AD", "HC"), 100, replace = TRUE),
#'   Gender = sample(c("Female", "Male"), 100, replace = TRUE),
#'   Age = sample(20:80, 100, replace = TRUE),
#'   Submission.Name = sample(c("plate1", "plate2"), 100, replace = TRUE),
#'   Material = sample(c("serum", "sample"), 100, replace = TRUE)
#' )
#'
#' processed_data <- dataPreparation::process_data(data, categories)
#'
#' @export

process_data <- function(data, categories) {
  # Filtering
  filter.res <- PLSDAbatch::PreFL(data = data, keep.spl = 0, keep.var = 0.00)
  filter <- filter.res$data.filter

  # CLR Transformation
  clr <- mixOmics::logratio.transfo(X = filter, logratio = 'CLR', offset = 1)
  class(clr) <- 'matrix'

  # PCA
  pca.before <- mixOmics::pca(clr, ncomp = 4, scale = TRUE)

  # Scatter Density Plot
  batch <- factor(categories$Submission.Name, levels = unique(categories$Submission.Name))
  descr <- as.factor(categories$Sample.Description)
  names(batch) <- names(descr) <- rownames(categories)
  pca.before.plot <- PLSDAbatch::Scatter_Density(object = pca.before, batch = batch,
                                                 trt = descr, title = 'AD data',
                                                 trt.legend.title = 'Disease Pheno.')

  # Batch Effect Correction
  clr <- clr[seq_len(nrow(clr)), seq_len(ncol(clr))]
  lm <- PLSDAbatch::linear_regres(data = clr, trt = descr, batch.fix = batch, type = 'linear model')
  p <- sapply(lm$lm.table, function(x) { x$coefficients[2, 4] })
  p.adj <- p.adjust(p = p, method = 'fdr')
  performance::check_model(lm$model$AC.0.0.)
  mod <- model.matrix(~ descr)
  rBE <- t(limma::removeBatchEffect(t(clr), batch = batch, design = mod))
  ComBat <- t(sva::ComBat(t(clr), batch = batch, mod = mod, par.prior = FALSE))
  trt.tune <- mixOmics::plsda(X = clr, Y = descr, ncomp = 5)
  ad.batch.tune <- PLSDAbatch::PLSDA_batch(X = clr, Y.trt = descr, Y.bat = batch,
                                           ncomp.trt = 1, ncomp.bat = 10)
  PLSDA_batch.res <- PLSDAbatch::PLSDA_batch(X = clr, Y.trt = descr, Y.bat = batch,
                                             ncomp.trt = 1, ncomp.bat = 4)
  sPLSDA_batch.res <- PLSDAbatch::PLSDA_batch(X = clr, Y.trt = descr, Y.bat = batch,
                                              ncomp.trt = 1, keepX.trt = 100, ncomp.bat = 4)
  PN <- PLSDAbatch::percentile_norm(data = clr, batch = batch, trt = descr, ctrl.grp = '0-0.5')

  # Assessing Batch Effect Correction
  pca.before <- mixOmics::pca(clr, ncomp = 3, scale = TRUE)
  pca.rBE <- mixOmics::pca(rBE, ncomp = 3, scale = TRUE)
  pca.ComBat <- mixOmics::pca(ComBat, ncomp = 3, scale = TRUE)
  pca.PLSDA_batch <- mixOmics::pca(PLSDA_batch, ncomp = 3, scale = TRUE)
  pca.sPLSDA_batch <- mixOmics::pca(sPLSDA_batch, ncomp = 3, scale = TRUE)

  # Plotting
  pca.before.plot <- PLSDAbatch::Scatter_Density(object = pca.before, batch = batch,
                                                 trt = descr, title = 'Before correction')
  pca.rBE.plot <- PLSDAbatch::Scatter_Density(object = pca.rBE, batch = batch,
                                              trt = descr, title = 'removeBatchEffect')
  pca.ComBat.plot <- PLSDAbatch::Scatter_Density(object = pca.ComBat, batch = batch,
                                                 trt = descr, title = 'ComBat')
  pca.PLSDA_batch.plot <- PLSDAbatch::Scatter_Density(object = pca.PLSDA_batch, batch = batch,
                                                      trt = descr, title = 'PLSDA-batch')
  pca.sPLSDA_batch.plot <- PLSDAbatch::Scatter_Density(object = pca.sPLSDA_batch, batch = batch,
                                                       trt = descr, title = 'sPLSDA-batch')

  # Other Processing
  factors.df <- data.frame(trt = descr, batch = batch)
  rda.before <- vegan::varpart(clr, ~ descr, ~ batch, data = factors.df, scale = TRUE)

  # Return processed data and plots
  processed_data <- list(clr = clr, rBE = rBE, ComBat = ComBat, trt.tune = trt.tune,
                         ad.batch.tune = ad.batch.tune, PLSDA_batch.res = PLSDA_batch.res,
                         sPLSDA_batch.res = sPLSDA_batch.res, PN = PN, pca.before = pca.before,
                         pca.rBE = pca.rBE, pca.ComBat = pca.ComBat, pca.PLSDA_batch = pca.PLSDA_batch,
                         pca.sPLSDA_batch = pca.sPLSDA_batch, pca.before.plot = pca.before.plot,
                         pca.rBE.plot = pca.rBE.plot, pca.ComBat.plot = pca.ComBat.plot,
                         pca.PLSDA_batch.plot = pca.PLSDA_batch.plot, pca.sPLSDA_batch.plot = pca.sPLSDA_batch.plot,
                         rda.before = rda.before)
  return(processed_data)
}
