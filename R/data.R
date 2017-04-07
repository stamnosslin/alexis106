#' Data from experiment ALEXIS 106
#'
#' This is data from an experiment on basic auditory abilities in three groups of
#' listeners: (1) 26 blind, (2) 26 sighted and age-matched to the blind, and (3) 40
#' young sighted listeners. For each listener, four threshold estimates were derived, '
#' called th.1, ..., th.4 in the data set. For details, see vignette
#'
#' @format A data frame with 98 rows and 25 columns.
#' \describe{
#'   \item{id}{Participant unique id number}
#'   \item{th.1}{Intensity discrimination threshold, unit [dB]}
#'   \item{th.2}{Threshold related to auto-correletaion detection, unit [dB]}
#'   \item{th.3}{Threshold related to auto-correletaion discrimination, unit [samples],
#'               sampling frequency was 96 kHz}
#'   \item{th.4}{Threshold related to spectral shape: high-frequency bump, unit [dB]}
#'   \item{group}{Experimental group: blind, sighted-young, sighted-age-matched}
#'   \item{pairs}{Identifies matched pairs of blind and age-match sighted listeners}
#'   \item{sex}{Sex of listeners}
#'   \item{right250}{Audiogram, right ear, 250 Hz}
#'   \item{right500}{Audiogram, right ear, 500 Hz}
#'   \item{right1k}{Audiogram, right ear, 1 kHz}
#'   \item{right2k}{Audiogram, right ear, 2 kHz}
#'   \item{right3k}{Audiogram, right ear, 3 kHz}
#'   \item{right4k}{Audiogram, right ear, 4 kHz}
#'   \item{right6k}{Audiogram, right ear, 6 kHz}
#'   \item{left250}{Audiogram, left ear, 250 Hz}
#'   \item{left500}{Audiogram, left ear, 500 Hz}
#'   \item{left1k}{Audiogram, left ear, 1 kHz}
#'   \item{left2k}{Audiogram, left ear, 2 kHz}
#'   \item{left3k}{Audiogram, left ear, 3 kHz}
#'   \item{left4k}{Audiogram, left ear, 4 kHz}
#'   \item{left6k}{Audiogram, left ear, 6 kHz}
#'   \item{blind_onset_age}{Age at blindness onset for blind listeners}
#'   \item{echolocator}{Use of echolocation, 1: "Never", 2: "Sometimes", 3: "Often", 4 "Almost always"}
#'   \item{age}{Age of listener, rounded to closest birthday}
#'   }
"data106"
