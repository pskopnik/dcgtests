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
 *  - Individual home subcluster affinity, alpha_v = 0.95.
 *
 * @param k Number of subclusters.
 * @param l The value of l.
 * @param hhc Half-half coefficient. Passed to the AffinitiesGenerator.
 */
void run(unsigned int k, unsigned int l, double hhc);

#endif /* INTEREDGES_CC_H_ */
