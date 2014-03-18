gdURL <- "http://tiny.cc/gapminder"
gDat <- read.delim(gdURL)

gDat <- read.delim("gapminderDataFiveYear.txt")

# look at data a bit
str(gDat) # see what we've just imported
head(gDat) # the head
tail(gDat) # the tail
dim(gDat) # size
nrow(gDat)
ncol(gDat)
head(rownames(gDat))
length(gDat)
names(gDat) # see column names
summary(gDat) # see a bit about distribution
plot(gDat) # take a look at all of it
plot(gDat[,-c(1,4)]) # take a look at it, ommitting the character strings

# look at single variable
gDat$lifeExp
summary(gDat$lifeExp)

hist(gDat$lifeExp) #histogram

# a bit about factors
class(gDat$country)
str(gDat)
levels(gDat$country)
nlevels(gDat$country)
table(gDat$country)

# to get a little part of data frame - subsetting
subset(gDat, subset = country == "Cambodia") # good way, robust
# gDat[217:228,] # a horrible way to get the data - depends on order, etc.
subset(gDat, subset = country %in% c("Cambodia", "Afghanistan")) # get two countries
subset(gDat, subset = year == 1952, select = c(year, country))

# challenge: get data for which life expectancey is less than 32 years
# assign it to an object
# how many rows?
# how many observations per continent?

challenge <- subset(gDat, subset = lifeExp < 32)
nrow(challenge) # there are 12
summary(challenge$continent) # 8 in Africa, 4 in Asia
table(challenge$continent) # another way to get number

# do some plotting/playing
plot(lifeExp ~ year, gDat) # data is every 5 years, so it's discrete
plot(lifeExp ~ year, gDat, subset = country == "Rwanda")

fit = lm(lifeExp ~ year, gDat, subset = country == "Rwanda") # linear model
abline(reg = fit) # look at the line

# numerical stuff
mean(gDat$lifeExp)
with(gDat, mean(lifeExp)) # DON'T USE ATTACH!

# suppose you want to take the correlation for life expression and GDP for cambodia...
with(subset(gDat, country == "Cambodia"), 
     cor(lifeExp, gdpPercap))

# linear fit of life Exp as a function of gdp -- bh playing
fit = lm(lifeExp~gdpPercap, data = gDat)
plot(gDat$lifeExp, gDat$gdpPercap)
abline(reg = fit) # looks shitty....

# playing with vectors
x <- 3 * 4
x
is.vector(x)
length(x)
x[1]
x[2]
x[0]
x[5] <- 10
x
x <- 1:4
x
x^2

# vectors pop up in unexpected places
round(rnorm(3, mean = c(0, 100, 10000)), 2)

(y <- 1:3) # parens mean create and print to console!
(z <- 3:7)
y+z # recycling happens! 1+3, 2+4, 3+5, 1+6, 2+7

(y <- 1:5)
(z <- 1:10)
y+z

x <- c(1, 4, 9)
x <- c("cabbage", pi, 0.3, TRUE) # elements are different types
str(x) # it all becomes charaters

x <- list("cabbage", pi, 0.3, TRUE) # elements are different types, but listed, not concatinated
str(x) # not all items are same flavor now.

# a data frame is a special kind of list.

# how index specific features of dataframe|list|vector?
x <- -3:3
str(x)
x < 0

set.seed(1)
(x <- round(rnorm(8), 2))
names(x) <- letters[seq_along(x)]
x

x[4]
x[c(3, 5, 8)]
x[-7]
x < 0
x[x < 0]
which(x < 0)

# challenge: get every other element of x ...
x[seq(from = 1, to = length(x), by = 2)]
x[seq(length(x)) %% 2 == 0]
x[c(FALSE,TRUE)]

x["g"]
x[c("a", "e", "g")]

month.abb
month.name

(x <- cbind(month.abb, month.name)) # column bind
(x <- rbind(month.abb, month.name)) # row bind

(x <- matrix(1:10, nrow = 5))
(x <- data.frame(month.num = 1:12,
                 month.abb,
                 month.name)) # but this turns character data into factors. We don't want that.
str(x)

(x <- data.frame(month.num = 1:12,
                 I(month.abb),
                 I(month.name)))
str(x)

