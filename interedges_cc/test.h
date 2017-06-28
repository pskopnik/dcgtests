#ifndef INTEREDGES_CC_H_
#define INTEREDGES_CC_H_

#ifndef NO_OF_TIMESTEPS
#define NO_OF_TIMESTEPS 5000
#endif /* NO_OF_TIMESTEPS */

/**
 * Tests the fraction of inter-edges in all connected components.
 *
 * For every connected component in the graph of chosen edges, the number of
 * inter-edges between all pairs of nodes in the component are counted and
 * the sum is divided by the total number of edges in the component.
 *
 * Output:
 *  - Fraction of inter-edges for each timestep, separated by a space.
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

#endif /* INTEREDGES_CC_H_ */
