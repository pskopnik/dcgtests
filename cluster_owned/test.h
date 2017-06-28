#ifndef CLUSTER_OWNED_H_
#define CLUSTER_OWNED_H_

#ifndef NO_OF_TIMESTEPS
#define NO_OF_TIMESTEPS 5000
#endif /* NO_OF_TIMESTEPS */

/**
 * Tests the fraction of clearly owned clusters.
 *
 * Background:
 * The subcluster affinities are based on a partition of the subclusters. Within a part, there is a
 * higher affinity between subclusters.
 * In case of half-half, there are only two parts.
 *
 * For every cluster the distribution of subclusters in regards to their part is determined.
 * If the largest (in terms of no. of subclusters) part owns more than 50% of the cluster,
 * the cluster is regarded as clearly owned.
 *
 * Output:
 *  - Fraction of clearly owned clusters for each timestep, separated by a space.
 *  - One LF at the end of output.
 *  - Output is given for NO_OF_TIMESTEPS timesteps.
 *
 * Further Parameters:
 *  - Number of individuals, n = 1000.
 *  - Home subcluster affinity, alpha = 0.5.
 *  - Probability of subcluster change of an individual, p_move_v = 0.1.
 *
 * @param k Number of subclusters.
 * @param kOverL The value of k/l, l is set from this and k: l := k / kOverL
 * @param hhc Half-half coefficient. Passed to the AffinitiesGenerator.
 */
void run(unsigned int k, unsigned int kOverL, double hhc);

#endif /* CLUSTER_OWNED_H_ */
