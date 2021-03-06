#ifndef CLUSTER_IMPURITY_H_
#define CLUSTER_IMPURITY_H_

#ifndef NO_OF_TIMESTEPS
#define NO_OF_TIMESTEPS 5000
#endif /* NO_OF_TIMESTEPS */

/**
 * Tests the impurity of each cluster.
 *
 * Background:
 * The subcluster affinities are based on a partition of the subclusters. Within a part, there is a
 * higher affinity between subclusters.
 * In case of half-half, there are only two parts.
 *
 * For every cluster the distribution of subclusters in regards to their part is determined.
 * For the largest (in terms of no. of subclusters) part the impurity of the cluster is calculated.
 * That is the fraction of the cluster (in terms of no. of subclusters) not contained in the part
 * is calculated: impurity := (cluster.size() - largestPartsStake) / cluster.size()
 *
 * Output:
 *  - For each timestep: The impurity of each cluster, separated by a space.
 *      One LF at the end of the timestep.
 *  - Output is given for NO_OF_TIMESTEPS timesteps.
 *
 * Further Parameters:
 *  - Number of individuals, n = 1000.
 *  - Individual home subcluster affinity, alpha_v = 0.95.
 *
 * @param k Number of subclusters.
 * @param l The value of l.
 * @param hhc Half-half coefficient. Passed to the AffinitiesGenerator.
 */
void run(unsigned int k, unsigned int l, double hhc);

#endif /* CLUSTER_IMPURITY_H_ */
