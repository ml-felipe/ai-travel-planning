# Travel recommendation and planning coursework

Recovered UPC-FIB Artificial Intelligence exercises using two approaches to travel planning:

- A CLIPS expert system profiles travelers, selects cities/lodging/visits/transport, constructs candidate itineraries, checks restrictions and ranks recommendations.
- A PDDL domain models starting a trip, booking a stay, traveling and finishing, with numeric cost, duration and interest accumulators. Fourteen recovered problem instances cover different objectives and constraints.

## Run the expert system

From the repository root, use a CLIPS interpreter:

```clips
(load "expert-system/ontology.clp")
(load "expert-system/rules.clp")
(reset)
(run)
```

The ontology contains the recovered demonstration instances; it is generated owl2clips output, not wholly handwritten implementation. `rules.clp` is the recovered `reglas-v5.clp`; the compatible ontology is `ontologia-v8.clp`, whose original header refers to an earlier ontology filename. That header is retained.

For the automated regression, use Python in a virtual environment:

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-test.txt
.venv/bin/python tests/test_expert_system.py
```

With clipspy 1.0.6, the unmodified sources loaded 146 instances and completed 11,704 rule firings. The test checked 16 recommendations across eight feasible profiles, absence of recommendations for the recovered impossible-duration profile, budget/duration/city-count bounds, ranked order, distinct city sets, and completion without pending rules or runtime errors. It does not establish correctness for all possible traveler data or verify every transport/lodging constraint.

## PDDL checks

`planning/domain.pddl` and `planning/problems/` preserve the recovered source. A planner needs numeric fluents and the corresponding objective support. No planner execution, optimality result, benchmark result or proof of unsolvability is claimed (including for the file named `sin-solucion-1.pddl`).

All fourteen instances parsed successfully with Unified Planning 1.3.0. To repeat this optional parser check:

```sh
.venv/bin/python -m pip install unified-planning==1.3.0
.venv/bin/python tests/parse_planning.py
```

The parser is only a test tool; neither exercise needs it at runtime. PDDL planning and the CLIPS expert system are separate coursework approaches, not an integrated application. Prices, traveler profiles and destination attributes are demonstration data, not current travel advice.

No recovered algorithm was changed during migration. Duplicate versions, backups, reports and existing output traces are excluded. [ATTRIBUTION.md](ATTRIBUTION.md) records source credits and provenance. The existing `BusquedaLocal-IA` repository is a separate project and is not duplicated here.
