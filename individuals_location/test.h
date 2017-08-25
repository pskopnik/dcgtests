#ifndef INDIVIDUALS_LOCATION_H_
#define INDIVIDUALS_LOCATION_H_

#ifndef NO_OF_TIMESTEPS
#define NO_OF_TIMESTEPS 5000
#endif /* NO_OF_TIMESTEPS */

#define PARAM_HHC 0.3
#define PARAM_K 30
#define PARAM_L 5
#define PARAM_N 1000

/**
 * Tests the fraction of individuals residing in their home subcluster.
 *
 * Output:
 *  - Fraction of individuals residing in their home subcluster for each timestep, separated by a
 *      space.
 *  - One LF at the end of output.
 *  - Output is given for NO_OF_TIMESTEPS timesteps.
 *
 * Further Parameters:
 *  - Half-half coefficient, hhc = 0.3. Passed to the AffinitiesGenerator halfHalf method.
 *  - Number of subclusters, k = 30.
 *  - The number of clusters, l = 5
 *  - Number of individuals, n = 1000.
 *
 * @param alphaV Individual home subcluster affinity.
 */
void run(double alphaV);

#endif /* INDIVIDUALS_LOCATION_H_ */
