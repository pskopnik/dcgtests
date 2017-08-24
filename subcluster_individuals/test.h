#ifndef SUBCLUSTER_INDIVIDUALS_H_
#define SUBCLUSTER_INDIVIDUALS_H_

#ifndef NO_OF_TIMESTEPS
#define NO_OF_TIMESTEPS 5000
#endif /* NO_OF_TIMESTEPS */

/**
 * Tests the number of individuals of each subcluster.
 *
 * Output:
 *  - For each timestep: The number of individuals for each subcluster, separated by a space.
 *      One LF at the end of the timestep.
 *  - The order of subclusters is the internal order of the generator and is thus preserved over
 *      timesteps.
 *  - Output is given for NO_OF_TIMESTEPS timesteps.
 *
 * Further Parameters:
 *  - The value of k/l, k/l = 10. l is set from this and k: l := k / kOverL
 *  - Half-half coefficient, hhc = 0.3. Passed to the AffinitiesGenerator halfHalf method.
 *
 * @param k Number of subclusters.
 * @param n Number of individuals.
 * @param alphaV Individual home subcluster affinity.
 */
void run(unsigned int k, unsigned int n, double alphaV);

#endif /* SUBCLUSTER_INDIVIDUALS_H_ */
