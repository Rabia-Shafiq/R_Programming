best <- function(state, outcome) {
    
    ## Reads outcome data
    file_data <- read.csv("outcome-of-care-measures.csv", sep = ",")
    
    ## Checks that state and outcome are valid
    valid_states <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
    valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!is.element(state, valid_states)) stop("invalid state")
    if (!is.element(outcome, valid_outcomes)) stop("invalid outcome")
    
    ## Returns hospital name in that state with lowest 30-day death
    data <- file_data[file_data$State == state,]
    header_name <- NULL
    if (outcome == "heart attack") {
        header_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    } else if (outcome == "heart failure") {
        header_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    } else {
        header_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    }
    mortality_rate <- data[,header_name]
    mortality_rate <- mortality_rate[!mortality_rate == "Not Available"]
    mortality_rate <- as.numeric(as.character(mortality_rate))
    min_rate <- min(mortality_rate)
    best_hosps <- data[data[,header_name] == min_rate,]
    hosp_names <- sort(best_hosps[,"Hospital.Name"])
    return(as.character(hosp_names[1]))
}