#' Remove columns and rows with high missingness
#'
#' This function removes columns and rows with high missing values
#' from the dataset.
#'
#' @param data The input data frame.
#' @param col_threshold The threshold percentage for column-wise missing
#' values (default is 10`\%`).
#' @param row_threshold The threshold percentage for row-wise missing
#' values (default is 10`\%`).
#'
#' @return A list containing the original data, cleaned data, and details
#' of removed columns and rows.
#'
#' @export
remove_high_missingness <- function(data, col_threshold = 10, row_threshold = 10) {
  # Calculate the percentage of missing values in each column
  col_missing_percent <- colMeans(is.na(data)) * 100
  # Calculate the percentage of missing values in each row
  row_missing_percent <- rowMeans(is.na(data)) * 100

  # Identify columns with more than 10% missing values
  col_threshold <- 10
  columns_to_remove <- names(col_missing_percent[col_missing_percent > col_threshold])

  # Identify rows with more than 10% missing values
  row_threshold <- 10
  rows_to_remove <- which(row_missing_percent > row_threshold)

  # Print removed columns and their missing percentages
  cat("Columns removed due to more than", col_threshold, "% missing values:\n")
  for (col in columns_to_remove) {
    cat(col, ":", col_missing_percent[col], "% missing\n")
  }

  # Print removed rows and their missing percentages
  cat("\nRows removed due to more than", row_threshold, "% missing values:\n")
  for (row in rows_to_remove) {
    cat("Row", row, ":", row_missing_percent[row], "% missing\n")
  }

  # Remove identified columns and rows
  cleaned_data <- data[, !(names(data) %in% columns_to_remove)]
  cleaned_data <- cleaned_data[-rows_to_remove, ]

  # Remove columns with zero or near-zero variance
  zero_var_cols <- which(apply(cleaned_data, 2, var) == 0)
  # Extract column names corresponding to the numeric values in zero_var_cols
  columns_to_remove <- names(cleaned_data) %in% names(zero_var_cols)

  # Subset cleaned_data to remove the columns
  cleaned_data <- cleaned_data[, !columns_to_remove]

  # Print removed columns and their variance
  cat("\nColumns removed due to having ", 0, " variance:\n")
  for (column in names(zero_var_cols)) {
    cat(column, " \n")
  }

  final_data <- list(original_data = data,
                     cleaned_data = cleaned_data,
                     zero_var_cols = as.character(names(zero_var_cols)),
                     row_missing_percent = rows_to_remove,
                     col_missing_percent = as.character(names(col_missing_percent[col]))
  )

  return(final_data)
}
