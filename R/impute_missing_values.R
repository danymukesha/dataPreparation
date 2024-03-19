#' Impute missing values using k-nearest neighbors algorithm
#'
#' This function imputes missing values in the dataset using
#' the k-nearest neighbors algorithm.
#'
#' @param data The input data frame.
#' @param k The number of nearest neighbors to consider (default is 5).
#'
#' @return The data frame with missing values imputed.
#'
#' @export
impute_missing_values <- function(data, k = 5) {
  # Convert data frame to matrix
  data_matrix <- as.matrix(data)

  # Impute missing values using k-nearest neighbors algorithm
  imputed_matrix <- impute::impute.knn(data_matrix, k = k)

  # Convert imputed matrix back to data frame
  imputed_data <- as.data.frame(imputed_matrix)

  return(imputed_data)
}
