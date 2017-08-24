#ifndef CLUSTER_SIZE_H_
#define CLUSTER_SIZE_H_

#ifndef NO_OF_TIMESTEPS
#define NO_OF_TIMESTEPS 5000
#endif /* NO_OF_TIMESTEPS */

/**
 * Tests the size of each cluster in terms of number of subclusters contained.
 *
 * Output:
 *  - For each timestep: The number of subclusters for each cluster, separated by a space.
 *      One LF at the end of the timestep.
 *  - The order of clusters is the internal order of the generator and is thus preserved over
 *      timesteps. Changes may however be caused by split and merge operations.
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

#endif /* CLUSTER_SIZE_H_ */
