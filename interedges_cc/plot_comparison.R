library(data.table)
d0.1 = fread("interedges_cc.out.500.20.0.1.tsv")
d0.3 = fread("interedges_cc.out.500.20.0.3.tsv")
d0.5 = fread("interedges_cc.out.500.20.0.5.tsv")
d0.7 = fread("interedges_cc.out.500.20.0.7.tsv")
d0.9 = fread("interedges_cc.out.500.20.0.9.tsv")

n.skip = 0

d0.1.melted = melt(d0.1, measure.vars=((1 + n.skip):(length(names(d0.1)) + n.skip)))
d0.1.melted[,run := rowid(variable)]
d0.1.melted[,timestep := .GRP,variable]

d0.3.melted = melt(d0.3, measure.vars=((1 + n.skip):(length(names(d0.3)) + n.skip)))
d0.3.melted[,run := rowid(variable)]
d0.3.melted[,timestep := .GRP,variable]

d0.5.melted = melt(d0.5, measure.vars=((1 + n.skip):(length(names(d0.5)) + n.skip)))
d0.5.melted[,run := rowid(variable)]
d0.5.melted[,timestep := .GRP,variable]

d0.7.melted = melt(d0.7, measure.vars=((1 + n.skip):(length(names(d0.7)) + n.skip)))
d0.7.melted[,run := rowid(variable)]
d0.7.melted[,timestep := .GRP,variable]

d0.9.melted = melt(d0.9, measure.vars=((1 + n.skip):(length(names(d0.9)) + n.skip)))
d0.9.melted[,run := rowid(variable)]
d0.9.melted[,timestep := .GRP,variable]

pdf("medians.pdf", width=14)
plot(
	c(
		1,
		max(
			d0.1.melted[,max(timestep)],
			d0.3.melted[,max(timestep)],
			d0.5.melted[,max(timestep)],
			d0.7.melted[,max(timestep)],
			d0.9.melted[,max(timestep)]
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
	main="Comparison of Median of Fraction of Interedges in the Connected Components",
	sub="Median is calculated over the fraction of interedges of all runs for each timestep",
	xlab="Timestep",
	ylab="Fraction of Interedges"
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
			d0.1.melted[,max(timestep)],
			d0.3.melted[,max(timestep)],
			d0.5.melted[,max(timestep)],
			d0.7.melted[,max(timestep)],
			d0.9.melted[,max(timestep)]
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
	main="Comparison of Mean of Fraction of Interedges in the Connected Components",
	sub="Mean is calculated over the fraction of interedges of all runs for each timestep",
	xlab="Timestep",
	ylab="Fraction of Interedges"
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
			d0.1.melted[,max(timestep)],
			d0.3.melted[,max(timestep)],
			d0.5.melted[,max(timestep)],
			d0.7.melted[,max(timestep)],
			d0.9.melted[,max(timestep)]
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
	main="Comparison of Standard Deviation of Fraction of Interedges in the Connected Components",
	sub="Standard deviation is calculated over the fraction of interedges of all runs for each timestep",
	xlab="Timestep",
	ylab="Fraction of Interedges"

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
