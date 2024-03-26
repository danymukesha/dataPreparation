#
# library(pROC)
#
# # List to store AUROC values
# auroc_values <- list()
#
# # Iterate over predictor variables
# for (predictor_col in colnames(sample_data)[9:ncol(sample_data)]) {
#   # Skip non-numeric columns
#   if (!is.numeric(sample_data[[predictor_col]])) {
#     next
#   }
#
#   # Calculate AUROC only for Sample.Description
#   response_col <- "Sample.Description"
#   roc_obj <- roc(response = sample_data[[response_col]], predictor = sample_data[[predictor_col]])
#   auroc_values[[paste(predictor_col, response_col, sep = "_vs_")]] <- auc(roc_obj)
#
#   # Plot ROC curve
#   plot(roc_obj, main = paste("ROC Curve:", predictor_col, "vs", response_col))
# }
#
# # Print AUROC values
# for (key in names(auroc_values)) {
#   cat(key, ": AUROC =", auroc_values[[key]], "\n")
# }
#
#
#
# library(pROC)
#
# # Function to calculate AUROC for a given combination of predictor variables
# calculate_auroc <- function(predictors, response) {
#   roc_obj <- roc(response = sample_data[[response]], predictor = sample_data[predictors])
#   return(auc(roc_obj))
# }
#
# # Get all combinations of predictor variables
# predictor_cols <- colnames(sample_data)[9:ncol(sample_data)] # Predictor variables
# comb <- lapply(seq_along(predictor_cols), function(x) combn(predictor_cols, x))
#
# # Flatten the list of combinations
# all_combinations <- unlist(comb, recursive = FALSE)
#
# # Find the combination with the highest AUROC
# best_combination <- NULL
# best_auc <- 0
#
# for (combination in all_combinations) {
#   auc_value <- calculate_auroc(combination, "Sample.Description")
#   if (auc_value > best_auc) {
#     best_auc <- auc_value
#     best_combination <- combination
#   }
# }
#
# # Print the best combination and its AUROC value
# cat("Best combination:", paste(best_combination, collapse = ", "), "\n")
# cat("AUROC:", best_auc, "\n")
#
#
#
# library(pROC)
#
# # Function to calculate AUROC for a given combination of predictor variables
# calculate_auroc <- function(predictors, response) {
#   roc_obj <- roc(response = sample_data[[response]], predictor = sample_data[predictors])
#   return(roc_obj)
# }
#
# # Get the optimal combination of predictor variables
# optimal_combination <- c("AC", "Ala", "Arg", "Asn", "Asp", "Cit", "Gln", "Glu", "Gly", "His", "Ile", "Lys", "Met", "Orn", "Phe", "Pro", "Ser", "Thr", "Trp", "Tyr", "Val", "xLeu", "Ac.Orn", "ADMA", "alpha.AAA", "c4.OH.Pro", "Carnosine", "Creatinine", "DOPA", "Dopamine", "Histamine", "Kynurenine", "Met.SO", "Nitro.Tyr", "PEA", "Putrescine", "Sarcosine", "SDMA", "Serotonin", "Spermidine", "Spermine", "t4.OH.Pro", "Taurine", "CE", "DG", "TG", "LPC", "PC", "Cer", "SM", "H1")
#
# # Calculate AUROC for the optimal combination
# roc_optimal <- calculate_auroc(optimal_combination, "Sample.Description")
#
# # Plot ROC curve with AUC value annotated
# plot(roc_optimal, main = "ROC Curve for Optimal Predictor Variables",
#      col = "blue", lwd = 2, print.auc = TRUE, print.auc.x = 0.5, print.auc.y = 0.2)
#



# Logistic Regression, Random Forest, Support Vector Machine (SVM), and Gradient Boosting Machine (GBM)

#
# library(pROC)
# library(randomForest)
# library(e1071)
# library(gbm)
# library(ggplot2)
#
# # Function to train a model and plot ROC curve with AUC value
# train_and_plot_model <- function(model, formula, data, response) {
#   # Train the model
#   fit <- model(formula, data = data)
#
#   # Predict probabilities
#   predicted_probs <- predict(fit, newdata = data, type = "response")
#
#   # Calculate AUROC
#   roc_obj <- roc(response = data[[response]], predictor = predicted_probs)
#
#   # Plot ROC curve with AUC value annotated
#   plot(roc_obj, main = paste("ROC Curve for", deparse(formula)),
#        col = "blue", lwd = 2, print.auc = TRUE, print.auc.x = 0.5, print.auc.y = 0.2)
# }
#
# # Logistic Regression
# logistic_formula <- Sample.Description ~ .
# train_and_plot_model(glm, logistic_formula, sample_data, "Sample.Description")
#
# # Random Forest
# rf_formula <- Sample.Description ~ .
# train_and_plot_model(randomForest, rf_formula, sample_data, "Sample.Description")
#
# # Support Vector Machine (SVM)
# svm_formula <- Sample.Description ~ .
# train_and_plot_model(svm, svm_formula, sample_data, "Sample.Description")
#
# # Gradient Boosting Machine (GBM)
# gbm_formula <- Sample.Description ~ .
# train_and_plot_model(gbm, gbm_formula, sample_data, "Sample.Description")
#
#
#
# # Function to plot ROC curve with ggplot2
# plot_roc_ggplot <- function(roc_obj, title) {
#   df_roc <- data.frame(
#     FPR = roc_obj$specificities,
#     TPR = roc_obj$sensitivities
#   )
#
#   auc_val <- round(auc(roc_obj), 2)
#
#   ggplot(df_roc, aes(x = FPR, y = TPR)) +
#     geom_line(color = "blue") +
#     geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray") +
#     labs(title = paste("ROC Curve for", title, "\nAUC =", auc_val),
#          x = "False Positive Rate", y = "True Positive Rate") +
#     theme_minimal()
# }
#
# # Plot ROC curve for Logistic Regression using ggplot2
# roc_logistic <- roc(Sample.Description ~ ., data = sample_data)
# plot_roc_ggplot(roc_logistic, "Logistic Regression")
#
#
#
# # Multiclass ROC curve
# multiclass_roc <- multiclass.roc(response = sample_data$Sample.Description, predictor = predicted_probs)
#
# # Plot multiclass ROC curve
# plot(multiclass_roc, main = "Multiclass ROC Curve")
#
