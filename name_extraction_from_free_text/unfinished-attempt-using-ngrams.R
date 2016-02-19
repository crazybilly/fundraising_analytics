# libraries -----------------------------

library(dplyr); library(magrittr)
library(stringr); library(lubridate); library(tidyr)
library(beepr)


library(stylo)


# data ----------------------------------

x <- getURL("https://raw.githubusercontent.com/michaelpawlus/fundraising_analytics/master/name_extraction_from_free_text/sample_survey.csv")
gfs <- read.csv(text = x, stringsAsFactors = FALSE)


counts  <- lapply( 1:nrow(gfs), function(x) {
         
         comment   <- gfs[x,2]
         
         ngrams  <- make.ngrams(
               txt.to.words(comment, preserve.case = T)
               , ngram.size =  2
            )
         
         data_frame(ngrams)  %>% 
            count(ngrams)  %>% 
            filter( grepl("^[A-Z]", ngrams), grepl(" [A-Z]", ngrams))
         
      })  %>% 
      rbind_all


