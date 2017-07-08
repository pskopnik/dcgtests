library(data.table)
library(tools)

ma = function(x, n=5) {filter(x, rep(1/n, n), sides=2)}

d = fread(commandArgs(trailingOnly=T)[1])
base.path = file_path_sans_ext(commandArgs(trailingOnly=T)[1])

n.runs = d[,.N]
n.timesteps = length(names(d))

d.melted = melt(d, measure.vars=(1:n.timesteps))
d.melted[,run := rowid(variable)]
d.melted[,timestep := .GRP,variable]

ct = cut(1:n.timesteps, 50)

pdf(paste(base.path, "boxplots.pdf", sep="."), width=14)

boxplot(value ~ ct[timestep], data=d.melted)

title(
	main="Boxplots of Fraction of Interedges in the Connected Components",
	sub="Timesteps are divided into 50 intervals, for each interval all values of fraction of interedges are aggregated in one boxplot",
	xlab="Timestep",
	ylab="Fraction of Interedges"
)

dev.off()


pdf(paste(base.path, "mean_median_sd.pdf", sep="."), width=14)

par(mar=c(5, 4, 4, 5))
plot(
	c(
		1,
		n.timesteps
	),
	c(
		min(
			d.melted[,mean(value),timestep][,min(V1)],
			d.melted[,median(value),timestep][,min(V1)]
		),
		max(
			d.melted[,mean(value),timestep][,max(V1)],
			d.melted[,median(value),timestep][,max(V1)]
		)
	),
	t='n',
	main="Mean, Median and Standard Deviation of Fraction of Interedges in the Connected Components",
	sub="Median, median and standard deviation are calculated over all runs for each timestep",
	xlab="Timestep",
	ylab="Mean, Median (Fraction of Interedges)"
)

points(d.melted[,mean(value),timestep], col='red')
points(d.melted[,median(value),timestep], col='black')

par(new=T)

plot(d.melted[,sd(value),timestep][,V1], col="orange", pch=3, axes=F, xlab=NA, ylab=NA)
axis(side=4)
mtext(side=4, line=3, 'Standard Deviation (Fraction of Interedges)')


# # Moving Average (n=100) of Standard Deviation
# lines(ma(d.melted[,sd(value),timestep][,V1], n=100), col='darkorchid', t='l', lwd=3)

# # Aggregate (mean) standard deviation in 50 intervals
# d.sd.aggregation = data.table(aggregate(V1 ~ ct[timestep], d=d.melted[,sd(value),timestep], FUN=mean))
# # Place one point in the middle of each interval
# d.sd.aggregation[,p := seq(floor(n.timesteps / 100), n.timesteps, floor(n.timesteps / 50))[.I]]
# lines(d.sd.aggregation[,.(p, V1)], col='blue')

legend("bottomright",
	inset=0.05,
	c("Mean", "Median", "Standard Deviation"),
	col=c('red', 'black', "orange"),
	pch=c(1, 1, 3))

dev.off()
