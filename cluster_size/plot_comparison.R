library(data.table)
d0.1 = fread("cluster_size.out.500.20.0.1.tsv")
d0.3 = fread("cluster_size.out.500.20.0.3.tsv")
d0.5 = fread("cluster_size.out.500.20.0.5.tsv")
d0.7 = fread("cluster_size.out.500.20.0.7.tsv")
d0.9 = fread("cluster_size.out.500.20.0.9.tsv")

n.runs = 100
n.clusters.skip = 0
n.clusters = length(names(d0.1)) - n.clusters.skip

ct = cut(1:d0.1[,.N], n.runs)
d0.1[,rungroup := ct[.I]]
d0.1[,run := .GRP,rungroup]
d0.1[,timestep := rowid(run)]
d0.1.melted = melt(d0.1, id.vars=c("run", "timestep"), measure.vars=(1 + n.clusters.skip):(n.clusters.skip + n.clusters))

ct = cut(1:d0.3[,.N], n.runs)
d0.3[,rungroup := ct[.I]]
d0.3[,run := .GRP,rungroup]
d0.3[,timestep := rowid(run)]
d0.3.melted = melt(d0.3, id.vars=c("run", "timestep"), measure.vars=(1 + n.clusters.skip):(n.clusters.skip + n.clusters))

ct = cut(1:d0.5[,.N], n.runs)
d0.5[,rungroup := ct[.I]]
d0.5[,run := .GRP,rungroup]
d0.5[,timestep := rowid(run)]
d0.5.melted = melt(d0.5, id.vars=c("run", "timestep"), measure.vars=(1 + n.clusters.skip):(n.clusters.skip + n.clusters))

ct = cut(1:d0.7[,.N], n.runs)
d0.7[,rungroup := ct[.I]]
d0.7[,run := .GRP,rungroup]
d0.7[,timestep := rowid(run)]
d0.7.melted = melt(d0.7, id.vars=c("run", "timestep"), measure.vars=(1 + n.clusters.skip):(n.clusters.skip + n.clusters))

ct = cut(1:d0.9[,.N], n.runs)
d0.9[,rungroup := ct[.I]]
d0.9[,run := .GRP,rungroup]
d0.9[,timestep := rowid(run)]
d0.9.melted = melt(d0.9, id.vars=c("run", "timestep"), measure.vars=(1 + n.clusters.skip):(n.clusters.skip + n.clusters))

pdf("medians.pdf", width=14)
plot(
	c(
		1,
		max(
			d0.1[,max(timestep)],
			d0.3[,max(timestep)],
			d0.5[,max(timestep)],
			d0.7[,max(timestep)],
			d0.9[,max(timestep)]
		)
	),
	c(
		0,
		max(
			d0.1.melted[,median(value),timestep][,max(V1)],
			d0.3.melted[,median(value),timestep][,max(V1)],
			d0.5.melted[,median(value),timestep][,max(V1)],
			d0.7.melted[,median(value),timestep][,max(V1)],
			d0.9.melted[,median(value),timestep][,max(V1)]
		)
	),
	t='n',
	main="Comparison of Median of Cluster Size",
	sub="Median is calculated over all clusters' size of all runs for each timestep",
	xlab="Timestep",
	ylab="Cluster Size"
)

points(d0.1.melted[,median(value),timestep], col="black")
points(d0.3.melted[,median(value),timestep], col="green")
points(d0.5.melted[,median(value),timestep], col="red")
points(d0.7.melted[,median(value),timestep], col="darkorchid")
points(d0.9.melted[,median(value),timestep], col="yellow")

legend("bottomright",
	inset=0.05,
	title="Values of hhc",
	c("0.1", "0.3", "0.5", "0.7", "0.9"),
	col=c('black', 'green', 'red', 'darkorchid', 'yellow'),
	pch=1)

dev.off()

pdf("means.pdf", width=14)

plot(
	c(
		1,
		max(
			d0.1[,max(timestep)],
			d0.3[,max(timestep)],
			d0.5[,max(timestep)],
			d0.7[,max(timestep)],
			d0.9[,max(timestep)]
		)
	),
	c(
		0,
		max(
			d0.1.melted[,mean(value),timestep][,max(V1)],
			d0.3.melted[,mean(value),timestep][,max(V1)],
			d0.5.melted[,mean(value),timestep][,max(V1)],
			d0.7.melted[,mean(value),timestep][,max(V1)],
			d0.9.melted[,mean(value),timestep][,max(V1)]
		)
	),
	t='n',
	main="Comparison of Mean of Cluster Size",
	sub="Mean is calculated over the all clusters' size of all runs for each timestep",
	xlab="Timestep",
	ylab="Cluster Size"
)

points(d0.1.melted[,mean(value),timestep], col="black")
points(d0.3.melted[,mean(value),timestep], col="green")
points(d0.5.melted[,mean(value),timestep], col="red")
points(d0.7.melted[,mean(value),timestep], col="darkorchid")
points(d0.9.melted[,mean(value),timestep], col="yellow")

legend("bottomright",
	inset=0.05,
	title="Values of hhc",
	c("0.1", "0.3", "0.5", "0.7", "0.9"),
	col=c('black', 'green', 'red', 'darkorchid', 'yellow'),
	pch=1)

dev.off()

pdf("sd.pdf", width=14)

plot(
	c(
		1,
		max(
			d0.1[,max(timestep)],
			d0.3[,max(timestep)],
			d0.5[,max(timestep)],
			d0.7[,max(timestep)],
			d0.9[,max(timestep)]
		)
	),
	c(
		0,
		max(
			d0.1.melted[,sd(value),timestep][,max(V1)],
			d0.3.melted[,sd(value),timestep][,max(V1)],
			d0.5.melted[,sd(value),timestep][,max(V1)],
			d0.7.melted[,sd(value),timestep][,max(V1)],
			d0.9.melted[,sd(value),timestep][,max(V1)]
		)
	),
	t='n',
	main="Comparison of Standard Deviation of Cluster Size",
	sub="Standard deviation is calculated over all clusters' size of all runs for each timestep",
	xlab="Timestep",
	ylab="Cluster Size"

)

points(d0.1.melted[,sd(value),timestep], col="black")
points(d0.3.melted[,sd(value),timestep], col="green")
points(d0.5.melted[,sd(value),timestep], col="red")
points(d0.7.melted[,sd(value),timestep], col="darkorchid")
points(d0.9.melted[,sd(value),timestep], col="yellow")

legend("bottomright",
	inset=0.05,
	title="Values of hhc",
	c("0.1", "0.3", "0.5", "0.7", "0.9"),
	col=c('black', 'green', 'red', 'darkorchid', 'yellow'),
	pch=1)

dev.off()
