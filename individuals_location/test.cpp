#include "test.h"

#include <sstream>

#include <NetworKit/generators/DynamicCommunitiesGenerator.h>
#include <NetworKit/structures/Partition.h>


void run(double alphaV) {
	NetworKit::AffinitiesGenerator aGen;

	auto m = aGen.halfHalf(30, 0.3);

	NetworKit::DynamicCommunitiesGenerator::Parameters parameters{m, 6, PARAM_N, alphaV};

	NetworKit::DynamicCommunitiesGenerator gen(parameters);
	NetworKit::GeneratorState state(gen);

	#ifdef DYNAMICCOMMUNITIESGENERATOR_VALIDATOR
	NetworKit::GeneratorValidator validator(gen);
	validator.validate();
	#endif /* DYNAMICCOMMUNITIESGENERATOR_VALIDATOR */

	for (int i = 0; i < NO_OF_TIMESTEPS; ++i) {
		NetworKit::Partition p = gen.next();
		auto clusters = state.getClusters();

		auto individuals = state.getIndividuals();

		NetworKit::count inHomeSubcluster = 0;

		for (auto it = individuals.cbegin() + 1; it != individuals.cend(); ++it) {
			if (it->subcluster == (it->homeSubcluster))
				++inHomeSubcluster;
		}

		std::cout << static_cast<double>(inHomeSubcluster) / static_cast<double>(PARAM_N) << " ";
	}

	std::cout << std::endl;

	#ifdef DYNAMICCOMMUNITIESGENERATOR_VALIDATOR
	validator.validate();
	#endif /* DYNAMICCOMMUNITIESGENERATOR_VALIDATOR */
}

int main(int argc, char const *argv[]) {
	double alphaV;

	if (argc != 2) {
		std::cerr << "Invalid number of arguments passed (expected 1): " << argc - 1 << std::endl;
		return 1;
	}

	std::istringstream ss;

	ss.str(std::string(argv[1]));
	ss.clear();
	if (!(ss >> alphaV)) {
		std::cerr << "Invalid value for alphaV (expected double): " << argv[1] << std::endl;
		return 1;
	}

	run(alphaV);

	return 0;
}
