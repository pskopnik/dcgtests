#ifndef INTEREDGES_FOREST_H_
#define INTEREDGES_FOREST_H_

#ifndef NO_OF_TIMESTEPS
#define NO_OF_TIMESTEPS 5000
#endif /* NO_OF_TIMESTEPS */

/**
 * Tests the fraction of inter-edges in the forest.
 *
 * Checks the parent relationship of every subcluster. If it has a parent,
 * the type of edge (inter- or intra-edge) is checked.
 * Finally the total number inter-edges divided by the total number of edges
 * is calculated.
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

#endif /* INTEREDGES_FOREST_H_ */
