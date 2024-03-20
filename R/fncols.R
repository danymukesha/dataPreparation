#' Fill Missing Columns with NA Values
#'
#' This function fills missing columns in a data frame with NA values
#'  based on the specified column names.
#'
#' @param data A data frame.
#' @param cname A character vector specifying column names to be filled
#'  with NA values.
#'
#' @return A data frame with missing columns filled with NA values.
#'
#' @export
fncols <- function(data, cname) {
  add <- cname[!cname %in% names(data)]

  if (length(add) != 0) data[add] <- NA
  data
}
