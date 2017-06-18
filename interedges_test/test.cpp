
#include "test.h"
#include <NetworKit/generators/DynamicCommunitiesGenerator.h>
#include <NetworKit/structures/Partition.h>


int main(int argc, char const *argv[])
{
	NetworKit::AffinityGenerator aGen;

	// auto m = aGen.halfHalf(6, 0.1);
	auto m = aGen.halfHalf(30, 0.1);

	// NetworKit::DynamicCommunitiesGenerator::Parameters parameters{m, 3, 20, 0.5, 0.1};
	NetworKit::DynamicCommunitiesGenerator::Parameters parameters{m, 6, 1000, 0.5, 0.1};

	NetworKit::DynamicCommunitiesGenerator gen(parameters);
	NetworKit::GeneratorState state(gen);

	#ifdef DYNAMICCOMMUNITIESGENERATOR_VALIDATOR
	NetworKit::GeneratorValidator validator(gen);
	validator.validate();
	#endif /* DYNAMICCOMMUNITIESGENERATOR_VALIDATOR */

	NetworKit::count intra, inter;


	for (int i = 0; i < 10000; ++i) {
		NetworKit::Partition p = gen.next();
		auto subclusters = state.getSubclusters();

		intra = 0;
		inter = 0;

		for (auto it = subclusters.cbegin(); it != subclusters.cend(); ++it) {
			if ((*it).parent != 0 && m.get(it - subclusters.cbegin(), (*it).parent) == 1)  {
				++intra;
			} else if ((*it).parent != 0) {
				++inter;
			}

		}

		std::cout << static_cast<double>(inter) / static_cast<double>(inter + intra) << " ";
	}
	std::cout << std::endl;

	return 0;
}
