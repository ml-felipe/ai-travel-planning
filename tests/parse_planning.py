"""Optional parser check; does not run a planner or establish solvability."""
from pathlib import Path
from unified_planning.io import PDDLReader
root = Path(__file__).resolve().parents[1] / 'planning'
reader = PDDLReader()
files = sorted((root / 'problems').glob('*.pddl'))
assert files
for path in files:
    problem = reader.parse_problem(str(root / 'domain.pddl'), str(path))
    assert len(problem.actions) == 4
    assert problem.goals
    print('Parsed', path.name)
print(f'PASS: domain and {len(files)} problem instances parsed; no planner was run')
