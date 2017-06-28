#include "test.h"

#include <sstream>

#include <NetworKit/generators/DynamicCommunitiesGenerator.h>
#include <NetworKit/structures/Partition.h>


void run(unsigned int k, unsigned int kOverL, double hhc) {
	NetworKit::AffinitiesGenerator aGen;

	auto m = aGen.halfHalf(k, hhc);

	NetworKit::DynamicCommunitiesGenerator::Parameters parameters{m, k / kOverL, 1000, 0.5, 0.1};

	NetworKit::DynamicCommunitiesGenerator gen(parameters);
	NetworKit::GeneratorState state(gen);

	#ifdef DYNAMICCOMMUNITIESGENERATOR_VALIDATOR
	NetworKit::GeneratorValidator validator(gen);
	validator.validate();
	#endif /* DYNAMICCOMMUNITIESGENERATOR_VALIDATOR */

	for (int i = 0; i < NO_OF_TIMESTEPS; ++i) {
		NetworKit::Partition p = gen.next();
		auto clusters = state.getClusters();

		for (auto clusterIt = clusters.cbegin() + 1; clusterIt != clusters.cend(); ++clusterIt) {
			std::cout << (*clusterIt).size() << " ";
		}

		std::cout << std::endl;
	}

	#ifdef DYNAMICCOMMUNITIESGENERATOR_VALIDATOR
	validator.validate();
	#endif /* DYNAMICCOMMUNITIESGENERATOR_VALIDATOR */
}

int main(int argc, char const *argv[]) {
	unsigned int k, kOverL;
	double hhc;

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
	if (!(ss >> kOverL)) {
		std::cerr << "Invalid value for kOverL (expected int): " << argv[2] << std::endl;
		return 1;
	}

	ss.str(std::string(argv[3]));
	ss.clear();
	if (!(ss >> hhc)) {
		std::cerr << "Invalid value for hhc (expected double): " << argv[3] << std::endl;
		return 1;
	}

	run(k, kOverL, hhc);

	return 0;
}