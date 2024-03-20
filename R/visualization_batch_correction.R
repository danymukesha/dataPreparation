#' Visualize Batch Correction Effects
#'
#' This function visualizes the effects of batch correction methods
#' by generating boxplot or barplot.
#'
#' @param corrected_list A list containing corrected data matrices.
#' @param visualization_type A character string specifying the type
#' of visualization.
#'                          It can be either "boxplot" or "barplot".
#' @param categories Classification of samples
#' @return A ggplot object representing the visualization.
#'
#' @examples
#' #load correct.list from dataPreparation
#' corrected_list <- dataPreparation::corrected_list
#' n <- nrow(corrected_list$`Before correction`)
#' categories <- dataPreparation::imputed_data$categories[1:n,]
#'
#' # Visualize batch correction effects using boxplot
#' visualize_batch_correction(corrected_list, categories,
#'         visualization_type = "boxplot")
#'
#' # Visualize batch correction effects using barplot
#' visualize_batch_correction(corrected_list, categories,
#'         visualization_type = "barplot")
#'
#' @export
visualize_batch_correction <- function(corrected_list, categories,
                                       visualization_type = "boxplot") {

  batch = factor(categories$Submission.Name,
                 levels = unique(categories$Submission.Name))

  descr = as.factor(categories$Sample.Description)

  names(batch) <- names(descr) <- rownames(categories)

  # other methods
  corr_scale.list <- lapply(corrected_list,
                            function(x){apply(x, 2, scale)})

  r_values.list <- list()
  for(i in seq_len(length(corr_scale.list))){
    r_values <- data.frame(trt = NA, batch = NA)
    for(c in seq_len(ncol(corr_scale.list[[i]]))){
      fit.res.trt <- lm(corr_scale.list[[i]][,c] ~ descr)
      r_values[c,1] <- summary(fit.res.trt)$r.squared
      fit.res.batch <- lm(corr_scale.list[[i]][,c] ~ batch)
      r_values[c,2] <- summary(fit.res.batch)$r.squared
    }
    r_values.list[[i]] <- r_values
  }
  names(r_values.list) <- names(corr_scale.list)

  r2 = c(r_values.list[[i]][ ,'trt'],
         r_values.list[[i]][ ,'batch'])

  if (visualization_type == "boxplot") {
    boxp.list <- lapply(r_values.list, function(r_values) {
      data.frame(r2 = c(r_values[, 'trt'], r_values[, 'batch']),
                 Effects = as.factor(rep(c('Disease Pheno','Batch'),
                                         each = length(r2))))
    })

    r2.boxp <- do.call(rbind, boxp.list)

    r2.boxp$methods <- rep(names(corrected_list), each = (length(r2) * 2))

    r2.boxp$methods <- factor(r2.boxp$methods, levels = unique(r2.boxp$methods))

    p <- ggplot(r2.boxp, aes(x = .data$Effects, y = r2, fill = .data$Effects)) +
      geom_boxplot(alpha = 0.80) +
      theme_bw() +
      theme(text = element_text(size = 10.6),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text.x = element_text(angle = 40, hjust = 1, size = 11),
            axis.text.y = element_text(size = 11),
            panel.grid.minor.x = element_blank(),
            panel.grid.major.x = element_blank(),
            legend.position = "right") +
      facet_grid( ~ methods) +
      scale_fill_manual(values=PLSDAbatch::pb_color(c(12,14)))
  } else if (visualization_type == "barplot") {
    barp.list <- lapply(r_values.list, function(r_values) {
      data.frame(r2 = c(sum(r_values[, 'trt']), sum(r_values[, 'batch'])),
                 Effects = c('Disease Pheno','Batch'))
    })

    r2.barp <- do.call(rbind, barp.list)

    r2.barp$methods <- rep(names(corrected_list), each = 2)

    r2.barp$methods <- factor(r2.barp$methods, levels = unique(r2.barp$methods))

    p <- ggplot(r2.barp, aes(x = .data$Effects, y = r2, fill = .data$Effects)) +
      geom_bar(stat="identity") +
      theme_bw() +
      theme(text = element_text(size = 10.6),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text.x = element_text(angle = 40, hjust = 1, size = 11),
            axis.text.y = element_text(size = 11),
            panel.grid.minor.x = element_blank(),
            panel.grid.major.x = element_blank(),
            legend.position = "right") +
      facet_grid( ~ methods) +
      scale_fill_manual(values=PLSDAbatch::pb_color(c(12,14)))
  } else {
    stop("Invalid visualization type. Choose either 'boxplot' or 'barplot'.")
  }

  return(p)
}
