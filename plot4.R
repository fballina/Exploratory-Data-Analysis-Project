NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# merge the two data sets
NEISCC <- merge(NEI, SCC, by="SCC")
library(ggplot2)
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# search all NEIxSCC records with Short.Name (SCC) Coal

coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]
aggregatedTotalxYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)
png("plot4.png", width=640, height=480)
g <- ggplot(aggregatedTotalxYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  +     xlab("year") +
  +     ylab(expression('Total PM'[2.5]*" Emissions")) +
  +     ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()
