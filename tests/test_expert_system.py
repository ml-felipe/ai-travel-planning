"""Run recovered fixtures and check output constraints without parsing printed text."""
from pathlib import Path
import clips

class Capture(clips.Router):
    def __init__(self):
        super().__init__('test-output', 30)
        self.errors = []
    def query(self, name):
        return name in ('stdout', 'stderr', 'stdwrn')
    def write(self, name, text):
        if name != 'stdout':
            self.errors.append(text)

root = Path(__file__).resolve().parents[1]
env = clips.Environment()
router = Capture()
env.add_router(router)
env.load(str(root / 'expert-system/ontology.clp'))
env.load(str(root / 'expert-system/rules.clp'))
env.reset()
initial_instances = len(list(env.instances()))
fired = env.run(100_000)
assert not list(env.activations()), 'execution reached the rule-firing limit'
assert not router.errors, ''.join(router.errors)
facts = list(env.facts())
assert not any(f.template.name == 'fase' for f in facts), 'pipeline did not finish'
recommendations = [f for f in facts if f.template.name == 'recomendacion-final']
assert recommendations, 'no recommendations generated'
by_traveler = {}
for fact in recommendations:
    traveler = env.find_instance(str(fact['viajero']))
    plan = env.find_instance(str(fact['plan']))
    duration = plan['duracionTotalDias'][0]
    cities = plan['numeroCiudades'][0]
    assert fact['precio'] <= traveler['presupuestoTotal'][0]
    assert traveler['minDiasViaje'][0] <= duration <= traveler['maxDiasViaje'][0]
    assert traveler['minCiudades'][0] <= cities <= traveler['maxCiudades'][0]
    assert plan['esValido'][0] == 'true'
    by_traveler.setdefault(str(fact['viajero']), []).append(fact)
assert 'ViajeroImposibleDuracion' not in by_traveler
assert len(by_traveler) == 8, 'all eight feasible recovered profiles should receive a plan'
for name, results in by_traveler.items():
    assert len(results) <= 2
    assert len({f['orden'] for f in results}) == len(results)
    if len(results) == 2:
        first, second = sorted(results, key=lambda f:f['orden'])
        assert (-first['puntuacion'], first['precio']) <= (-second['puntuacion'], second['precio'])
        def city_set(f):
            return {str(f[k]) for k in ('ciudad1','ciudad2','ciudad3') if str(f[k]) != 'nil'}
        assert city_set(first) != city_set(second)
print(f'PASS: {initial_instances} recovered instances, {fired} rule firings, '
      f'{len(recommendations)} recommendations for {len(by_traveler)} profiles; impossible-duration profile rejected')
