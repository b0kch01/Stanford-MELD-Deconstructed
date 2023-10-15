#' calculate MELD-original score
#' 
#' @param creatinine
#' @param bilirubin
#' @param inr
#' @returns score (number)
meld_original <- function(creatinine, bilirubin, inr) {
  return (round(9.57 * log(max(1, min(4, creatinine))) + 
          3.78 * log(max(1, bilirubin)) + 
          11.2 * log(max(1, inr)) + 6.43))
}

#' calculate MELD-Na score
#' 
#' @param creatinine
#' @param bilirubin
#' @param inr
#' @param na
#' @returns score (number)

meld_na <- function(creatinine, bilirubin, inr, na) {
  original_score <- meld_original(creatinine, bilirubin, inr)
  if (original_score > 11) {
    na_clamp <- 137 - min(137, max(na, 125))
    return(original_score + 1.32*na_clamp - 0.033*original_score*na_clamp)
  }
  return(original_score)
}

#' calculate MELD-3 score
#' 
#' @param gender male=0, female=1
#' @param bilirubin
#' @param na
#' @param inr
#' @param creatinine
#' @param albumin
#' @returns score (number)
meld_3 <- function(gender, bilirubin, na, inr, creatinine, albumin) {
  return ( 1.33 * gender + 
           4.56 * log(max(1, bilirubin)) + 
           0.82 * (137 - min(137, max(na, 125))) - 
           0.24 * (137 - min(137, max(na, 125))) * log(max(1, bilirubin)) + 
           9.09 * log(max(1, inr)) + 
          11.14 * log(max(1, min(3, creatinine))) + 
           1.85 * (3.5 - max(min(albumin, 3.5), 1.5)) - 
           1.83 * (3.5 - max(min(albumin, 3.5), 1.5)) * log(max(1, min(3, creatinine))) + 
              6)
}

thirty_day_prediction <- function(meld3_score) {
  x <- 0.17698 * meld3_score
  return(100 * pow(0.981, exp(x - 3.56)))
}

ninety_day_prediction <- function(meld3_score) {
  x <- 0.17698 * meld3_score
  return(100 * pow(0.946, exp(x - 3.56)))
}

if (interactive()) {
  print("[interactive mode] Running examples:")
  print(meld_original(100, 100, 100))
  print(meld_na(100, 100, 100, 100))
  print(meld_3(1, 100, 100, 100, 100, 100))
}

