library(ggplot2)
library(plyr)

gDat <- read.delim('data/2014_03_17//gapminderDataFiveYear.txt')
str(gDat) # still 1704 observations?

tDat <- with(gDat,
             cbind(cambodia = lifeExp[country == "Cambodia"], #column-wise bind - would reshape
                   canada = lifeExp[country == "Canada"],
                   rwanda = lifeExp[country == "Rwanda"]))

tDat # print to screen to inspect

rownames(tDat) <- with(gDat, year[country == "Canada"])
str(tDat)
tDat # a nice matrix ready for showtime. Row names, column names...

# compute row-wise means
apply(tDat, 1, mean) # split, apply, combine
apply(tDat, 1, median)

rowMeans(tDat) # also works, substantially faster

# which country of the three has the minimum life expectency each year?
tDat[1,] # inspect the data
which.min(tDat[1,]) # should be the index for cambodia, 1

apply(tDat, 1, which.min)
colnames(tDat)

colnames(tDat)[apply(tDat, 1, which.min)]

# what is the minimum value for each year?
tDat[1,]
min(tDat[1,])
apply(tDat, 1, min)

# and the min value for each country?
apply(tDat, 2, min)

# other functions work
apply(tDat, 2, summary)

# working towards multiple-argument functions with apply - we'll use quantile
apply(tDat, 2, quantile)

apply(tDat, 2, quantile, probs = c(0.25, 0.75))

# challenge: Use apply to compute the range of life expectancy for each country
apply(tDat, 2, range)
apply(tDat, 2, min) # checking the above
apply(tDat, 2, max) # checking the above

apply(tDat, 2, function(x) c(min = min(x), max = max(x))) # anonymous function, with labels!

# but apply only works on matrices, so we move on to other things. Want to work on data frames.

aggregate(lifeExp ~ continent, gDat, FUN = mean)
str(aggregate(lifeExp ~ continent, gDat, FUN = mean)) #look at what it returns - a data frame. Good!

# sanity check numbers with figure, and check the figure with numbers.
# do by year and continent
lifeExpByYearAndContinent <- 
  aggregate(lifeExp ~ year * continent, gDat, FUN = mean) # do for every combination of year and continent

ggplot(lifeExpByYearAndContinent,
       aes(x = year, y = lifeExp, color = continent)) +
  geom_line() #ooohhh


# how many countries per continent?
aggregate(country ~ continent, gDat, 
          function(x) length(unique(x))) 

# aggregate is building something like this - groupings of country by continent:
# alb EUR
# alb EUR
# alb EUR
#----------
# NZ oceana
#----------
# cambodia ASIA
# cambodia ASIA

# then it's passing the first column (countries) to function (that's what x is)

# can inspect that with something like this:
aggregate(country ~ continent, gDat, function(x) tolower(x))

# sanity check - how many countries should there be?
nlevels(gDat$country)

# and does the sum of unique contries equal the number in the original data?
sum(aggregate(country ~ continent, gDat, 
              function(x) length(unique(x)))$country) # I don't understand that


# want to play with plyr, starting with a subset of the data
library(plyr)

ggplot(subset(gDat, country =="Zimbabwe"),
       aes(x = year, y = lifeExp)) + geom_point()

lm(lifeExp ~ year, gDat, subset = country == "Zimbabwe") #look at results! Senseless! average life of 236 years in year 0!

# put a line in to see it
ggplot(subset(gDat, country =="Zimbabwe"),
       aes(x = year, y = lifeExp)) + geom_point() +
  geom_smooth(se = FALSE, method = "lm")

# really only want fit in our data set...
(yearMin <- min(gDat$year))

lm(lifeExp ~ I(year - yearMin), gDat,
   subset = country == "Zimbabwe") # yay! now a sane result!

# we want to do this for every country. We want to build a data frame that looks like:
# country continent intecept slope

jFit <- lm(lifeExp ~ I(year - yearMin), gDat,
   subset = country == "Zimbabwe") # yay! now a sane result!

coef(jFit)

# now we've done everything we want to do once, interactively. Now we want to make a function.

jFun <- function(z){
  jFit <- lm(lifeExp ~ I(year - yearMin), z)
  return(coef(jFit))
}
# note - wouldn't really want to include yearMin this way - it's in the workspace.
# instead, should either calculate or set a default for the function

jFun(subset(gDat, country == "Zimbabwe")) # paranoid - check that it works on zimbabwe

jFun(subset(gDat, country == "Canada")) # paranoid - check another country

# now modify function - add names for rows and columns
jFun <- function(z){
  jFit <- lm(lifeExp ~ I(year - yearMin), z)
  jCoef <- coef(jFit)
  names(jCoef) <- c("intercept", "slope")
  return(jCoef)
}

jFun(subset(gDat, country == "Zimbabwe")) # paranoid - check that it works on zimbabwe

jFun(subset(gDat, country == "Canada")) # paranoid - check another country

ddply(gDat, ~ country, jFun) # oooh!

# how change if want continent and country?
gCoef <- ddply(gDat, ~ country * continent, jFun) # oooh!
str(gCoef) # look at it!

# save to file, on to session 8
# write.table(gCoef, "results/2014_03_17/gCoef.txt") # protects strings with quotes, has integer row names

write.table(gCoef, "../results/2014_03_18/gCoef.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)
