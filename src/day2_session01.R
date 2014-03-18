# goal - clean up the swcUW directory from yesterday.
# this moves everything from ~/swcUW to various subdirectories.

files <- list.files()
print(files)

# see ?file.create() for links and directories
dir.create("src")
file.copy("session02_care-feeding.R", "src/")
file.remove('session02_care-feeding.R')
file.copy('session04_ggplot2.R', 'src/')
file.remove('session04_ggplot2.R')
file.copy('toyline.R', 'src/')
file.remove('toyline.R')
file.copy('swcUW.Rproj', 'src/')
file.remove('swcUW.Rproj')

dir.create('results')
dir.create('results/2014_03_17')
file.copy('avgX.txt', 'results/2014_03_17/')
file.remove('avgX.txt')
file.copy('Rplot.png', 'results//2014_03_17')
file.remove('Rplot.png')
file.copy('toylinePlot.pdf', 'results//2014_03_17')
file.remove('toylinePlot.pdf')
file.copy('toylinePlot.png', 'results/2014_03_17/')
file.remove('toylinePlot.png')
file.copy('toyline.html', 'results/2014_03_17/')
file.remove('toyline.html')

dir.create('data')
dir.create('data/2014_03_17')
file.copy('gapminderDataFiveYear.txt', 'data/2014_03_17/')
file.remove('gapminderDataFiveYear.txt')

# finally, move the current file. Work on the moved version from here on.

