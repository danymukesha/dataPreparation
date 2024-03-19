#' Perform Principal Component Analysis (PCA)
#'
#' This function performs Principal Component Analysis (PCA) on the input data.
#'
#' @param data The input data frame.
#' @param scale_data Logical indicating whether to scale the data
#' (default is TRUE).
#' @param center_data Logical indicating whether to center the data
#' (default is TRUE).
#'
#' @return A list containing the PCA results, including the principal
#' component scores and other attributes.
#'
#' @export
perform_pca <- function(data, scale_data = TRUE, center_data = TRUE) {
  # Perform PCA
  pca_result <- stats::prcomp(data, scale. = scale_data, center = center_data)

  # Extract principal component scores
  pca_scores <- as.data.frame(pca_result$x)

  # Combine PCA scores with input data
  pca_data <- cbind(pca_scores, data)

  # Return list containing PCA results
  pca_results <- list(
    pca_scores = pca_scores,
    pca_data = pca_data,
    pca_attributes = attributes(pca_result)
  )

  return(pca_results)
}
