library(ggplot2)

gDat <- read.delim("gapminderDataFiveYear.txt")

# ggplot is the main function, specifying dataset and variables to plot
# geoms = geometric objects
# aes = aesthetics
# scales = how will be plotted

str(gDat) # still 1704 rows!

# initialize. Don't be scared. We'll build an object, then print object.
p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp))
# note: data must be in data frame (which it is here)

p + geom_point() # now it knows it's plotting points so can make a plot

# looks like it needs a log transform on the x axis - all data bunched

p + geom_point() + scale_x_log10()

p <- p + scale_x_log10() # update p to always use log x axis.

p + geom_point()

# want to add continent info
p + geom_point(aes(color = continent)) # this is an "aesthetic mapping"

p + geom_point(alpha = 1/3) # think of denominator as # of points that have to stack for opacity

p + geom_point(alpha = 1/3, size = 3)

p + geom_point(alpha = 1/3, size = 3) + geom_smooth()

p + geom_point(alpha = 1/3, size = 3) + 
  geom_smooth(lwd = 3, se = FALSE)

p + geom_point(alpha = 1/3, size = 3) + 
  geom_smooth(lwd = 3, se = FALSE, method = "lm")

# now, different plot
ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_point()

ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_jitter()

ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_boxplot()

ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_violin()

ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1), alpha = 1/4)

ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_boxplot() +
  geom_jitter(position = position_jitter(width = 0.1), alpha = 1/4)

ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_violin() +
  geom_jitter(position = position_jitter(width = 0.1), alpha = 1/4)


## quantitative variable
ggplot(gDat, aes(x = lifeExp)) + geom_histogram()

ggplot(gDat, aes(x = lifeExp)) + geom_density()

## quantitative + qualitative
ggplot(gDat, aes(x = lifeExp, fill = continent)) + geom_histogram()

ggplot(gDat, aes(x = lifeExp, fill = continent)) + 
  geom_histogram(position = "identity")

ggplot(gDat, aes(x = lifeExp, fill = continent)) + 
  geom_density(alpha = 0.2)

## factor
table(gDat$continent)
ggplot(gDat, aes(x = continent)) + geom_bar()
# bh falls behind - download from workshop jump page

## facetting
