#include "test.h"

#include <sstream>

#include <NetworKit/generators/DynamicCommunitiesGenerator.h>
#include <NetworKit/structures/Partition.h>


void run(unsigned int k, unsigned int n, double alphaV) {
	NetworKit::AffinitiesGenerator aGen;

	auto m = aGen.halfHalf(k, 0.3);

	NetworKit::DynamicCommunitiesGenerator::Parameters parameters{m, k / 10, n, alphaV};

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

		std::cout << static_cast<double>(inHomeSubcluster) / static_cast<double>(n) << " ";
	}

	std::cout << std::endl;

	#ifdef DYNAMICCOMMUNITIESGENERATOR_VALIDATOR
	validator.validate();
	#endif /* DYNAMICCOMMUNITIESGENERATOR_VALIDATOR */
}

int main(int argc, char const *argv[]) {
	unsigned int k, n;
	double alphaV;

	if (argc != 4) {
		std::cerr << "Invalid number of arguments passed (expected 3): " << argc - 1 << std::endl;
		return 1;
	}

	std::istringstream ss;

	ss.str(std::string(argv[1]));
	ss.clear();
	if (!(ss >> k)) {
		std::cerr << "Invalid value for k (expected int): " << argv[1] << std::endl;
		return 1;
	}

	ss.str(std::string(argv[2]));
	ss.clear();
	if (!(ss >> n)) {
		std::cerr << "Invalid value for n (expected int): " << argv[2] << std::endl;
		return 1;
	}

	ss.str(std::string(argv[3]));
	ss.clear();
	if (!(ss >> alphaV)) {
		std::cerr << "Invalid value for alphaV (expected double): " << argv[3] << std::endl;
		return 1;
	}

	run(k, n, alphaV);

	return 0;
}
