#' Add missing phenotypes to samples
#'
#' This function adds missing phenotypes to samples based on information
#'  from a metadata table.
#'
#' @param mt A data frame containing the samples.
#' @param all_samples_info A data frame containing information of missing
#' phenotypes.
#' @param skip_descr Logical indicating whether to skip adding
#' Sample.Description (default is FALSE).
#' @param skip_mat Logical indicating whether to skip adding
#' Material (default is FALSE).
#'
#' @return The data frame with missing phenotypes added.
#'
#' @export
add_missing_phenotypes <- function(mt, all_samples_info, skip_descr = FALSE, skip_mat = FALSE) {
  samples <- Filter(nzchar, mt$Sample.Identification)
  samples <- samples[str_sub(samples, 1, 1) == "F"]  # Filter samples starting with "F"

  for (sample in samples) {
    pattern <- str_sub(sample, 0, 8)
    i = which(all_samples_info$Serum %in% pattern)
    if (length(i) == 0) {
      i = which(all_samples_info$`Plasma-LH` %in% pattern)
    }
    mt$Sample.Description <- as.character(mt$Sample.Description)
    j <- which(grepl(sample, mt$Sample.Identification))

    if (length(j) > 0) {
      # print(paste("Processing sample:", sample))
      # print(paste("Index in mt:", j))
      # ... (rest of the code)
      Sample_Descr <- all_samples_info[i, ]$Phenotype
      Gender <- all_samples_info[i, ]$Gender
      Age <- all_samples_info[i, ]$Age
      Sample_Id <- all_samples_info[i, ]$Patient.reference
      Material <- mt[i, ]$Material

      if (skip_descr == FALSE) {
        mt[j, ]$Sample.Description <- Sample_Descr
      }
      if (skip_mat == FALSE) {
        mt[j, ]$Material <- Material
      }
      mt <- dataPreparation::fncols(as.data.frame(mt), "Gender")
      mt[j, ]$Gender <- Gender
      mt <- dataPreparation::fncols(as.data.frame(mt), "Age")
      mt[j, ]$Age <- Age
    }
  }
  return(mt)
}
