#ifndef PARTS_H_
#define PARTS_H_

#include <vector>

#include <NetworKit/Globals.h>

std::vector<NetworKit::index> invert(const std::vector<std::vector<NetworKit::index>>& parts) {
	std::vector<NetworKit::index> inverted(1, 0);

	NetworKit::index partsInd;

	for (auto partsIt = parts.cbegin(); partsIt != parts.cend(); ++partsIt) {
		partsInd = partsIt - parts.cbegin();
		for (auto subcluster : *partsIt) {
			if (inverted.size() <= subcluster)
				inverted.resize(subcluster + 1);

			inverted[subcluster] = partsInd;
		}
	}

	return inverted;
}

#endif /* PARTS_H_ */
