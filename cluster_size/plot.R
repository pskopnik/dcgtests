library(data.table)
library(tools)

d = fread(commandArgs(trailingOnly=T)[1])
base.path = file_path_sans_ext(commandArgs(trailingOnly=T)[1])

n.runs = 100
n.clusters.skip = 0
n.clusters = length(names(d)) - n.clusters.skip

c = cut(1:d[,.N], n.runs)
d[,rungroup := c[.I]]
d[,run := .GRP,rungroup]
d[,timestep := rowid(run)]
d.melted = melt(d, id.vars=c("run", "timestep"), measure.vars=(1 + n.clusters.skip) : (n.clusters.skip + n.clusters))

n.timesteps = d[,max(timestep)]

# Plot standard deviation and median for each timestep aggregated over all runs
pdf(paste(base.path, "sd_median.pdf", sep="."), width=14)

plot(
	c(
		1,
		n.timesteps
	),
	c(
		0,
		max(
			d.melted[,sd(value),timestep][,max(V1)],
			d.melted[,median(value),timestep][,max(V1)]
		)
	),
	t='n',
	main="Median and Standard Deviation of Cluster Sizes",
	sub="Median and standard deviation are calculated over all clusters' sizes of all runs for each timestep",
	xlab="Timestep",
	ylab="Cluster Size"
)

points(d.melted[,sd(value),timestep], col="orange", pch=3)
points(d.melted[,median(value),timestep], col="black")

legend("bottomright",
	inset=0.05,
	title="Metric",
	c("Median", "Standard Deviation"),
	col=c('black', 'orange'),
	pch=c(1, 3))

dev.off()


# # Plot standard deviation within run and timestep, aggregated as mean and / or median over all runs
# pdf(paste(base.path, "sd_aggregated.pdf", sep="."), width=14)
# plot(d.melted[,sd(value),.(run, timestep)][,mean(V1),timestep][,V1], col='red')
# lines(d.melted[,sd(value),.(run, timestep)][,median(V1),timestep][,V1])
# points(d.melted[,sd(value),timestep], col='green')
# dev.off()

# Plot densities of every x-th timestep (100 timesteps are drawn)
pdf(paste(base.path, "densities.pdf", sep="."), width=14)

density.interval = floor(n.timesteps / 100)

plot(
	density(d.melted[timestep == 1,value]), col='darkorchid',
	main="Density (Distribution) of Cluster Sizes for Different Timesteps",
	sub=sprintf(
		"Density is drawn for every %sth timestep, cluster sizes are aggregated over all clusters' sizes of all runs for each timestep",
		density.interval
	),
	xlab="Cluster Size",
	ylab="Density"
)

for (i in seq(1 + density.interval, n.timesteps, density.interval)) {
	lines(density(d.melted[timestep == i,value]))
}

legend("top",
	inset=0.05,
	title="Timestep",
	c("timestep = 1", "timestep > 1"),
	col=c('darkorchid', 'black'),
	lty=1)

dev.off()


# Plot means and medians per variable (cluster)
pdf(paste(base.path, "mean_median_indices.pdf", sep="."), width=14)

plot(
	c(
		1,
		n.clusters
	),
	c(
		0,
		max(
			d.melted[,mean(value),variable][,max(V1)],
			d.melted[,median(value),variable][,max(V1)]
		)
	),
	t='n',
	xaxt='n',
	main="Mean and Median of Cluster Size for Each Cluster Index",
	sub="Mean and median are aggregated for each cluster index over cluster sizes of all timesteps and runs",
	xlab="Cluster Index",
	ylab="Cluster Size"
)
axis(side=1, at=1:n.clusters)

points(d.melted[,mean(value),variable], col='red')
points(d.melted[,median(value),variable], col='black')
variables = 1:n.clusters
abline(lm(d.melted[,median(value),variable][,V1] ~ variables), col='blue')

legend("topright",
	inset=0.05,
	c("mean", "median", "regression of median"),
	col=c('red', 'black', 'blue'),
	lty=c(NA, NA, 1),
	pch=c(1, 1, NA))

dev.off()
