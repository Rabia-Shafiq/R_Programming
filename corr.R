corr <- function(directory, threshold = 0) {
    
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Returns a numeric vector of correlations
    
    files <- (Sys.glob("specdata//*.csv"));
    
    correlations <- c()
    
    for (file in files) {
        file_data <- read.csv(file, sep = ",");
        complete_cases <- file_data[complete.cases(file_data),];
        if (nrow(complete_cases) > threshold) {
            correlations <- c(correlations, cor(complete_cases$sulfate, complete_cases$nitrate))
        }
    }
    
    return(correlations)
}