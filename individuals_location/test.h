#ifndef INDIVIDUALS_LOCATION_H_
#define INDIVIDUALS_LOCATION_H_

#ifndef NO_OF_TIMESTEPS
#define NO_OF_TIMESTEPS 5000
#endif /* NO_OF_TIMESTEPS */

/**
 * Tests the fraction of individuals residing in their home subcluster.
 *
 * Output:
 *  - For each timestep: The impurity of each cluster, separated by a space.
 *      One LF at the end of the timestep.
 *  - Output is given for NO_OF_TIMESTEPS timesteps.
 *
 * Further Parameters:
 *  - The value of k/l, k/l = 10. l is set from this and k: l := k / kOverL
 *  - Half-half coefficient, hhc = 0.3. Passed to the AffinitiesGenerator halfHalf method.
 *  // - Number of individuals, n = 1000.
 *  // - Number of subclusters, k = 30.
 *
 * @param k Number of subclusters.
 * @param n Number of individuals.
 * @param alpha Home subcluster affinity.
 * @param pMoveV Probability of subcluster change of an individual.
 */
void run(unsigned int k, unsigned int n, double alpha, double pMoveV);

#endif /* INDIVIDUALS_LOCATION_H_ */
