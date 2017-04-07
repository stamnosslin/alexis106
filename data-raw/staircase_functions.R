#' Determine Reversal Points from a Staircase Procedure
#'
#' This function determines reversal points in a series of stimulus levels
#' generated according to the rules of an adaptive staircase procedure. For example
#' levels generated according to the 1-up-2-down rule: increased level (easier
#' trial) after one incorrect response and decreased level
#' (more difficult trial) after two consecutive correct responses. For the moment,
#' the function assumes that the last trial was a reversal (as is the case if the
#' procedure ends after agiven number of reversals).
#' @param levels A numeric vector
#' @param trend1 A number, default is -1 (first trial has negative trend, i.e.,
#' it is on a descendent path).
#' @param lasttrev A number, default is 1 (last trial is a reversal)
#' @return A numeric vector of the same length as the input vector (levels).
#' Zeros indicating non-reversal points, and non-zero values indicating reversal
#' points (numbered from 1 to k, where k is the total number of reversals).
#' @export
#' @examples
#' reversals(x)
#' reversals(x, lastrev = 0)
#'
#' # Example with plot: red points are reversals
#' stimuli <- c(12, 12, 6, 6, 3, 3, 1.5, 3, 3, 1.5, 1.5, 0.75,
#'              1.5, 3, 3, 1.5, 1.5, 0.75, 1.5, 3, 1.5, 1.5, 0.75, 0.75)
#' revs <- reversals(stimuli)
#' plot(stimuli)
#' lines(stimuli)
#' points(which(revs > 0), stimuli[revs > 0], pch = 21, bg = 'red')
reversals = function(levels, trend1 = -1, lastrev = 1) {
  # Sign of change from index 2 to n = length(levels)
  trend <- sign(levels[2:length(levels)] - levels[1:length(levels)-1])
  trend <- c(trend1, trend)

  # Replace zeros with sign of previous (i.e., 'remember' previous trend)
  trend[trend == 0] <- trend[which(trend == 0) - 1]

  # Change of trend: trend[j] - trend[j+1], for index 1 to n-1
  trend <- 1 * (trend[1:(length(trend)-1)] != trend[2:length(trend)])

  # Add reversal for last trial
  revs <- c(trend, lastrev)

  # Number each reversal from 1 to k = total number of reversals
  revs[revs == 1] <- (1:sum(revs))
  revs
}
