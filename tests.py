from bjec import job, build, P, Factory, Join
from bjec.params import Function
from bjec.build import GitRepo, Make
from bjec.runner import SubprocessRunner, ProcessArgs, Stdout
from bjec.processor import Threading
from bjec.generator import Product, RepeatG, List
from bjec.collector import Concatenate, CSV, Demux
from bjec.config import config

from os.path import join
import os


repo_url = config.User["repo_url"]
no_of_runs = config.User.get("no_of_runs", 100)


@build()
def build_cluster_impurity(b):
	s = b.source(GitRepo(repo_url))

	m = b.builder(Make(join(s.local_path(), "cluster_impurity"), creates="test"))

	b.artefact(executable=m.result)

@build()
def build_clusters_owned(b):
	s = b.source(GitRepo(repo_url))

	m = b.builder(Make(join(s.local_path(), "clusters_owned"), creates="test"))

	b.artefact(executable=m.result)

@build()
def build_cluster_size(b):
	s = b.source(GitRepo(repo_url))

	m = b.builder(Make(join(s.local_path(), "cluster_size"), creates="test"))

	b.artefact(executable=m.result)

@build()
def build_interedges_cc(b):
	s = b.source(GitRepo(repo_url))

	m = b.builder(Make(join(s.local_path(), "interedges_cc"), creates="test"))

	b.artefact(executable=m.result)

@build()
def build_interedges_forest(b):
	s = b.source(GitRepo(repo_url))

	m = b.builder(Make(join(s.local_path(), "interedges_forest"), creates="test"))

	b.artefact(executable=m.result)

@build()
def build_subcluster_individuals(b):
	s = b.source(GitRepo(repo_url))

	m = b.builder(Make(join(s.local_path(), "subcluster_individuals"), creates="test"))

	b.artefact(executable=m.result)


@job(depends=build_cluster_impurity)
def cluster_impurity(j):
	j.generator(
		RepeatG(
			Product(
				# k=[30, 100, 500, 1000],
				k=[500],
				# k_over_l=[3, 5, 10, 20],
				k_over_l=[20],
				hhc=[0.1, 0.3, 0.5, 0.7, 0.9],
			),
			no_of_runs,
		)
	)

	j.processor(Threading(
		config.User.get("cpu_count", os.cpu_count())
	))

	j.runner(SubprocessRunner.factory(
		j.dependencies[build_cluster_impurity].artefacts["executable"],
		input=ProcessArgs(P("k"), Function(lambda p: p["k"] // p["k_over_l"]), P("hhc")),
		output=Stdout(),
	))

	coll = j.collector(Demux(
		["k", "k_over_l", "hhc"],
		Factory(
			CSV,
			file_path=Join(
				"cluster_impurity.out.", P("k"), ".", P("k_over_l"), ".", P("hhc"), ".tsv"
			),
			input_csv_args=dict(delimiter=' '),
			output_csv_args=dict(delimiter=' '),
		)
	))

	j.artefact(result=coll.aggregate)

	j.after(lambda j: print("Wrote results to", list(map(lambda f: f.name, j.artefacts["result"]))))
	j.after(lambda j: list(map(lambda f: f.close(), j.artefacts["result"])))

@job(depends=build_clusters_owned)
def clusters_owned(j):
	j.generator(
		RepeatG(
			Product(
				# k=[30, 100, 500, 1000],
				k=[500],
				# k_over_l=[3, 5, 10, 20],
				k_over_l=[20],
				hhc=[0.1, 0.3, 0.5, 0.7, 0.9],
			),
			no_of_runs,
		)
	)

	j.processor(Threading(
		config.User.get("cpu_count", os.cpu_count())
	))

	j.runner(SubprocessRunner.factory(
		j.dependencies[build_clusters_owned].artefacts["executable"],
		input=ProcessArgs(P("k"), Function(lambda p: p["k"] // p["k_over_l"]), P("hhc")),
		output=Stdout(),
	))

	coll = j.collector(Demux(
		["k", "k_over_l", "hhc"],
		Factory(
			Concatenate,
			file_path=Join(
				"clusters_owned.out.", P("k"), ".", P("k_over_l"), ".", P("hhc"), ".tsv"
			),
		)
	))

	j.artefact(result=coll.aggregate)

	j.after(lambda j: print("Wrote results to", list(map(lambda f: f.name, j.artefacts["result"]))))
	j.after(lambda j: list(map(lambda f: f.close(), j.artefacts["result"])))

@job(depends=build_cluster_size)
def cluster_size(j):
	j.generator(
		RepeatG(
			Product(
				# k=[30, 100, 500, 1000],
				k=[500],
				# k_over_l=[3, 5, 10, 20],
				k_over_l=[20],
				hhc=[0.1, 0.3, 0.5, 0.7, 0.9],
			),
			no_of_runs,
		)
	)

	j.processor(Threading(
		config.User.get("cpu_count", os.cpu_count())
	))

	j.runner(SubprocessRunner.factory(
		j.dependencies[build_cluster_size].artefacts["executable"],
		input=ProcessArgs(P("k"), Function(lambda p: p["k"] // p["k_over_l"]), P("hhc")),
		output=Stdout(),
	))

	coll = j.collector(Demux(
		["k", "k_over_l", "hhc"],
		Factory(
			CSV,
			file_path=Join(
				"cluster_size.out.", P("k"), ".", P("k_over_l"), ".", P("hhc"), ".tsv"
			),
			input_csv_args=dict(delimiter=' '),
			output_csv_args=dict(delimiter=' '),
		)
	))

	j.artefact(result=coll.aggregate)

	j.after(lambda j: print("Wrote results to", list(map(lambda f: f.name, j.artefacts["result"]))))
	j.after(lambda j: list(map(lambda f: f.close(), j.artefacts["result"])))

@job(depends=build_interedges_cc)
def interedges_cc(j):
	j.generator(
		RepeatG(
			Product(
				# k=[30, 100, 500, 1000],
				k=[500],
				# k_over_l=[3, 5, 10, 20],
				k_over_l=[20],
				hhc=[0.1, 0.3, 0.5, 0.7, 0.9],
			),
			no_of_runs,
		)
	)

	j.processor(Threading(
		config.User.get("cpu_count", os.cpu_count())
	))

	j.runner(SubprocessRunner.factory(
		j.dependencies[build_interedges_cc].artefacts["executable"],
		input=ProcessArgs(P("k"), Function(lambda p: p["k"] // p["k_over_l"]), P("hhc")),
		output=Stdout(),
	))

	coll = j.collector(Demux(
		["k", "k_over_l", "hhc"],
		Factory(
			Concatenate,
			file_path=Join(
				"interedges_cc.out.", P("k"), ".", P("k_over_l"), ".", P("hhc"), ".tsv"
			),
		)
	))

	j.artefact(result=coll.aggregate)

	j.after(lambda j: print("Wrote results to", list(map(lambda f: f.name, j.artefacts["result"]))))
	j.after(lambda j: list(map(lambda f: f.close(), j.artefacts["result"])))

@job(depends=build_interedges_forest)
def interedges_forest(j):
	j.generator(
		RepeatG(
			Product(
				# k=[30, 100, 500, 1000],
				k=[500],
				# k_over_l=[3, 5, 10, 20],
				k_over_l=[20],
				hhc=[0.1, 0.3, 0.5, 0.7, 0.9],
			),
			no_of_runs,
		)
	)

	j.processor(Threading(
		config.User.get("cpu_count", os.cpu_count())
	))

	j.runner(SubprocessRunner.factory(
		j.dependencies[build_interedges_forest].artefacts["executable"],
		input=ProcessArgs(P("k"), Function(lambda p: p["k"] // p["k_over_l"]), P("hhc")),
		output=Stdout(),
	))

	coll = j.collector(Demux(
		["k", "k_over_l", "hhc"],
		Factory(
			Concatenate,
			file_path=Join(
				"interedges_forest.out.", P("k"), ".", P("k_over_l"), ".", P("hhc"), ".tsv"
			),
		)
	))

	j.artefact(result=coll.aggregate)

	j.after(lambda j: print("Wrote results to", list(map(lambda f: f.name, j.artefacts["result"]))))
	j.after(lambda j: list(map(lambda f: f.close(), j.artefacts["result"])))

@job(depends=build_subcluster_individuals)
def subcluster_individuals(j):
	j.generator(
		RepeatG(
			Product(
				# k=[30, 100, 500, 1000],
				k=[500],
				# n=[500, 1000, 2000, 5000],
				n=[5000],
				alpha=[0.1, 0.3, 0.5, 0.7, 0.9],
				p_move_v=[0.1, 0.4, 0.6, 0.9],
			),
			no_of_runs,
		)
	)

	j.processor(Threading(
		config.User.get("cpu_count", os.cpu_count())
	))

	j.runner(SubprocessRunner.factory(
		j.dependencies[build_subcluster_individuals].artefacts["executable"],
		input=ProcessArgs(P("k"), P("n"), P("alpha"), P("p_move_v")),
		output=Stdout(),
	))

	coll = j.collector(Demux(
		["k", "n", "alpha", "p_move_v"],
		Factory(
			CSV,
			file_path=Join(
				"subcluster_individuals.out.", P("k"), ".", P("n"), ".", P("alpha"), ".", P("p_move_v"), ".tsv"
			),
			input_csv_args=dict(delimiter=' '),
			output_csv_args=dict(delimiter=' '),
		)
	))

	j.artefact(result=coll.aggregate)

	j.after(lambda j: print("Wrote results to", list(map(lambda f: f.name, j.artefacts["result"]))))
	j.after(lambda j: list(map(lambda f: f.close(), j.artefacts["result"])))
