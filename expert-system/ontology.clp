;;; ---------------------------------------------------------
;;; ontologia-v7.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologia-v7-2.ttl
;;; :Date 24/05/2026 22:03:05

(defclass Alojamiento "Lugar donde se hospeda el viajero durante una parada del viaje. Tiene precio, categoría, capacidad y características relevantes para familias o grupos."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Indica en qué ciudad se encuentra un alojamiento.
    (multislot alojamientoEstaEn
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Precio estimado por noche y persona del alojamiento.
    (multislot precioNochePersona
        (type FLOAT)
        (create-accessor read-write))
    ;;; Categoría del alojamiento, usada para controlar la calidad mínima o máxima.
    (multislot estrellas
        (type INTEGER)
        (create-accessor read-write))
    ;;; Número máximo de personas que puede alojar.
    (multislot capacidadMaxima
        (type INTEGER)
        (create-accessor read-write))
    ;;; Indica si el alojamiento es adecuado para familias.
    (multislot aptoFamilias
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si el alojamiento es adecuado para grupos grandes o grupos de amigos.
    (multislot aptoGrupos
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Característica útil para viajeros con movilidad baja o personas mayores.
    (multislot tieneAscensor
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Característica relevante para perfiles de descanso o viajes familiares.
    (multislot tienePiscina
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Distancia aproximada del alojamiento al centro de la ciudad, en kilómetros.
    (multislot distanciaCentro
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Apartamento "Alojamiento adecuado para familias o grupos, especialmente cuando se busca capacidad, autonomía o menor coste por persona."
    (is-a Alojamiento)
    (role concrete)
    (pattern-match reactive)
)

(defclass Hostal "Alojamiento económico. Es útil para viajeros con presupuesto ajustado o dispuestos a reducir calidad."
    (is-a Alojamiento)
    (role concrete)
    (pattern-match reactive)
)

(defclass Hotel "Alojamiento con categoría por estrellas. Suele ser adecuado cuando se prioriza comodidad o calidad."
    (is-a Alojamiento)
    (role concrete)
    (pattern-match reactive)
)

(defclass Transporte "Medio de desplazamiento usado en el viaje. Se divide entre transporte entre ciudades y transporte local."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass TransporteEntreCiudades "Medio usado para desplazarse entre dos ciudades del plan, incluyendo origen y destino."
    (is-a Transporte)
    (role concrete)
    (pattern-match reactive)
    ;;; Ciudad de origen de un transporte entre ciudades.
    (multislot origenTransporte
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Ciudad de destino de un transporte entre ciudades.
    (multislot destinoTransporte
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Precio estimado por persona del transporte entre ciudades.
    (multislot precioPersona
        (type FLOAT)
        (create-accessor read-write))
    ;;; Duración estimada del trayecto en horas.
    (multislot duracionHoras
        (type FLOAT)
        (create-accessor read-write))
    ;;; Nivel de comodidad del transporte, e.g. de 1 a 5.
    (multislot nivelComodidad
        (type INTEGER)
        (create-accessor read-write))
    ;;; Distancia aproximada entre la ciudad de origen y la ciudad de destino.
    (multislot distanciaKm
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Avion "Transporte rápido para distancias largas. Puede no ser válido si el viajero tiene restricción de no volar."
    (is-a TransporteEntreCiudades)
    (role concrete)
    (pattern-match reactive)
)

(defclass Barco "Transporte usado para conexiones marítimas o fluviales entre ciudades."
    (is-a TransporteEntreCiudades)
    (role concrete)
    (pattern-match reactive)
)

(defclass Bus "Transporte económico. Permite ajustar el presupuesto a cambio de mayor duración o menor comodidad."
    (is-a TransporteEntreCiudades)
    (role concrete)
    (pattern-match reactive)
)

(defclass Tren "Transporte cómodo para distancias cortas o medias entre ciudades, especialmente en viajes regionales."
    (is-a TransporteEntreCiudades)
    (role concrete)
    (pattern-match reactive)
)

(defclass TransporteLocal "Medio usado dentro de una ciudad durante una parada, e.g. metro, bus urbano, taxi o transporte público diario."
    (is-a Transporte)
    (role concrete)
    (pattern-match reactive)
    ;;; Indica en qué ciudad se usa un transporte local.
    (multislot transporteLocalEn
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Precio estimado por día del transporte local en una ciudad.
    (multislot precioDia
        (type FLOAT)
        (create-accessor read-write))
)

(defclass LugarVisita "Lugar o actividad que puede recomendarse dentro de una ciudad. En el plan final corresponde a los sitios a visitar en cada ciudad."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Indica en qué ciudad se encuentra un lugar de visita.
    (multislot lugarVisitaEstaEn
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Relaciona un lugar de visita con los temas de viaje para los que resulta adecuado.
    (multislot lugarRelacionadoConTema
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Precio de entrada o coste estimado del lugar de visita.
    (multislot precioEntrada
        (type FLOAT)
        (create-accessor read-write))
    ;;; Duración estimada necesaria para visitar el lugar.
    (multislot duracionVisitaHoras
        (type FLOAT)
        (create-accessor read-write))
    ;;; Adecuación del lugar de visita para un viaje cultural.
    (multislot nivelCulturalLugar
        (type INTEGER)
        (create-accessor read-write))
    ;;; Adecuación del lugar de visita para un viaje de diversión.
    (multislot nivelDiversionLugar
        (type INTEGER)
        (create-accessor read-write))
    ;;; Adecuación del lugar de visita para un viaje de descanso.
    (multislot nivelDescansoLugar
        (type INTEGER)
        (create-accessor read-write))
    ;;; Adecuación del lugar de visita para un viaje romántico.
    (multislot nivelRomanticoLugar
        (type INTEGER)
        (create-accessor read-write))
    ;;; Indica si el lugar de visita es adecuado para niños.
    (multislot aptoNinosLugar
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si el lugar de visita es adecuado para personas mayores o movilidad baja.
    (multislot aptoMayoresLugar
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si el lugar requiere reserva previa.
    (multislot requiereReserva
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass ActividadOcio "Actividad orientada a diversión, entretenimiento o vida social."
    (is-a LugarVisita)
    (role concrete)
    (pattern-match reactive)
)

(defclass Monumento "Lugar de visita histórico, artístico o representativo de una ciudad."
    (is-a LugarVisita)
    (role concrete)
    (pattern-match reactive)
)

(defclass Museo "Lugar de visita principalmente cultural."
    (is-a LugarVisita)
    (role concrete)
    (pattern-match reactive)
)

(defclass Parque "Lugar de visita asociado a descanso, naturaleza o actividades familiares."
    (is-a LugarVisita)
    (role concrete)
    (pattern-match reactive)
)

(defclass Playa "Lugar de visita asociado a descanso, clima cálido, turismo familiar o turismo romántico."
    (is-a LugarVisita)
    (role concrete)
    (pattern-match reactive)
)

(defclass Restaurante "Lugar de visita gastronómico, útil para perfiles culturales, románticos o de ocio."
    (is-a LugarVisita)
    (role concrete)
    (pattern-match reactive)
)

(defclass Viajero "Persona o grupo que solicita una recomendación y realiza el viaje. Contiene características como edad media, nivel cultural, presencia de niños, tipo de grupo, evento especial, objetivo del viaje, restricciones y preferencias."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Relaciona un viajero con el perfil deducido por el sistema.
    (multislot tienePerfil
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Relaciona un viajero con una preferencia usada para ordenar planes válidos.
    (multislot tienePreferencia
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Relaciona un viajero con una restricción obligatoria del viaje.
    (multislot tieneRestriccion
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Edad media del viajero o del grupo. Sirve para deducir perfiles, ritmo del viaje y adecuación de destinos.
    (multislot edadMedia
        (type INTEGER)
        (create-accessor read-write))
    ;;; Nivel de interés cultural del viajero, representado numéricamente, e.g. de 1 a 5.
    (multislot nivelCulturalViajero
        (type INTEGER)
        (create-accessor read-write))
    ;;; Indica si el viaje se realiza con niños. Afecta al perfil, alojamiento, ritmo y lugares de visita.
    (multislot tieneNinos
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si viajan personas mayores. Permite adaptar movilidad, transporte, alojamiento y número de visitas.
    (multislot tieneMayores
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Evento asociado al viaje, e.g. ninguno, boda, luna_miel, fin_de_curso o aniversario.
    (multislot eventoEspecial
        (type STRING)
        (create-accessor read-write))
    ;;; Tipo de grupo: individual, pareja, familia, amigos o grupo_grande.
    (multislot tipoGrupo
        (type STRING)
        (create-accessor read-write))
    ;;; Número de personas que realizan el viaje.
    (multislot numeroPersonas
        (type INTEGER)
        (create-accessor read-write))
    ;;; Objetivo principal del viaje: descanso, cultural, diversion, romantico, familiar o naturaleza.
    (multislot objetivoViaje
        (type STRING)
        (create-accessor read-write))
    ;;; Ciudad desde la que empieza y termina el viaje.
    (multislot ciudadOrigen
        (type STRING)
        (create-accessor read-write))
    ;;; Mes previsto del viaje. Puede usarse para adaptar clima, temporada o disponibilidad.
    (multislot mesViaje
        (type STRING)
        (create-accessor read-write))
    ;;; Número mínimo de días que debería durar el viaje.
    (multislot minDiasViaje
        (type INTEGER)
        (create-accessor read-write))
    ;;; Número máximo de días que puede durar el viaje.
    (multislot maxDiasViaje
        (type INTEGER)
        (create-accessor read-write))
    ;;; Número mínimo de ciudades a visitar.
    (multislot minCiudades
        (type INTEGER)
        (create-accessor read-write))
    ;;; Número máximo de ciudades a visitar.
    (multislot maxCiudades
        (type INTEGER)
        (create-accessor read-write))
    ;;; Número mínimo de días de estancia en cada ciudad.
    (multislot minDiasPorCiudad
        (type INTEGER)
        (create-accessor read-write))
    ;;; Número máximo de días de estancia en cada ciudad.
    (multislot maxDiasPorCiudad
        (type INTEGER)
        (create-accessor read-write))
    ;;; Presupuesto máximo aproximado para el viaje completo.
    (multislot presupuestoTotal
        (type FLOAT)
        (create-accessor read-write))
    ;;; Presupuesto máximo aproximado por persona y día.
    (multislot presupuestoDiarioPersona
        (type FLOAT)
        (create-accessor read-write))
    ;;; Medio de transporte que no puede usarse, e.g. avion, tren, bus, barco o ninguno.
    (multislot transporteProhibido
        (type STRING)
        (create-accessor read-write))
    ;;; Medio de transporte preferido, e.g. avion, tren, bus, barco o indiferente. Es preferencia salvo que se formalice como restricción.
    (multislot transportePreferido
        (type STRING)
        (create-accessor read-write))
    ;;; Calidad mínima aceptada para el alojamiento.
    (multislot minEstrellasAlojamiento
        (type INTEGER)
        (create-accessor read-write))
    ;;; Calidad máxima considerada para el alojamiento. Puede usarse para evitar alojamientos demasiado caros.
    (multislot maxEstrellasAlojamiento
        (type INTEGER)
        (create-accessor read-write))
    ;;; Capacidad o disposición a caminar y moverse durante el viaje: baja, media o alta.
    (multislot nivelMovilidad
        (type STRING)
        (create-accessor read-write))
    ;;; Indica si el viajero acepta reducir la duración del viaje para ajustarse al presupuesto.
    (multislot dispuestoReducirDuracion
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si el viajero acepta reducir la calidad del alojamiento o transporte para ajustarse al presupuesto.
    (multislot dispuestoReducirCalidad
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si el viajero prefiere ciudades o lugares menos conocidos frente a destinos muy populares.
    (multislot prefiereMenosConocido
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Clima preferido por el viajero: calido, frio, templado o indiferente.
    (multislot preferenciaClima
        (type STRING)
        (create-accessor read-write))
)

(defclass PerfilViajero "Perfil abstracto deducido por el sistema a partir de los datos del viajero. Permite razonar con categorías como familiar, joven, romántico, cultural, descanso o grupo grande."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass Preferencia "Criterio deseable usado para ordenar planes válidos. Una preferencia no es obligatoria; sirve para comparar soluciones, e.g. preferir lugares menos conocidos o transporte cómodo."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass Restriccion "Condición obligatoria que debe cumplir todo plan recomendado, e.g. presupuesto máximo, duración máxima, transporte prohibido o calidad mínima de alojamiento."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass PlanDeViaje "Solución propuesta por el sistema. Un plan contiene una secuencia de paradas, duración total, precio total por persona, número de ciudades y preferencias cumplidas."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Indica para qué viajero se ha generado un plan de viaje.
    (multislot recomendadoPara
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Relaciona un plan con cada una de sus paradas.
    (multislot incluyeParada
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Indica qué preferencias del viajero cumple un plan válido.
    (multislot cumplePreferencia
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Duración total del plan de viaje en días.
    (multislot duracionTotalDias
        (type INTEGER)
        (create-accessor read-write))
    ;;; Coste total estimado del plan por persona.
    (multislot precioTotalPersona
        (type FLOAT)
        (create-accessor read-write))
    ;;; Número de ciudades incluidas en el plan.
    (multislot numeroCiudades
        (type INTEGER)
        (create-accessor read-write))
    ;;; Valor numérico usado para ordenar planes válidos según el grado de cumplimiento de preferencias.
    (multislot puntuacionPreferencias
        (type FLOAT)
        (create-accessor read-write))
    ;;; Indica si el plan cumple todas las restricciones obligatorias.
    (multislot esValido
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Explicación de por qué un plan no es válido, e.g. supera presupuesto o incumple duración máxima.
    (multislot motivoRechazo
        (type STRING)
        (create-accessor read-write))
)

(defclass ParadaDelViaje "Estancia concreta dentro de un plan de viaje. Representa una ciudad visitada, los días de estancia, el alojamiento, los lugares a visitar y el transporte de llegada."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Indica la ciudad visitada en una parada concreta.
    (multislot enCiudad
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Indica el alojamiento asignado a una parada del viaje.
    (multislot usaAlojamiento
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Indica un lugar recomendado para visitar durante una parada.
    (multislot incluyeLugarVisita
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Indica el transporte usado para llegar a la ciudad de una parada.
    (multislot llegaEn
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Indica el transporte local previsto dentro de la ciudad de una parada.
    (multislot usaTransporteLocal
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Posición de la parada dentro del itinerario.
    (multislot orden
        (type INTEGER)
        (create-accessor read-write))
    ;;; Número de días asignados a la ciudad de una parada.
    (multislot diasEnCiudad
        (type INTEGER)
        (create-accessor read-write))
    ;;; Coste estimado del alojamiento en una parada.
    (multislot costeAlojamiento
        (type FLOAT)
        (create-accessor read-write))
    ;;; Coste estimado de los lugares visitados en una parada.
    (multislot costeVisitas
        (type FLOAT)
        (create-accessor read-write))
    ;;; Coste estimado del transporte local en una parada.
    (multislot costeTransporteLocal
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Ciudad "Destino turístico potencial. Se caracteriza por país, región, coste diario, popularidad, clima, niveles temáticos y días recomendados."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Relaciona una ciudad con los temas de viaje para los que es adecuada.
    (multislot ciudadRelacionadaConTema
        (type INSTANCE)
        (create-accessor read-write))
    ;;; País al que pertenece la ciudad.
    (multislot pais
        (type STRING)
        (create-accessor read-write))
    ;;; Región geográfica usada para evitar viajes demasiado dispersos cuando hay pocos días.
    (multislot region
        (type STRING)
        (create-accessor read-write))
    ;;; Coste medio diario estimado de visitar la ciudad.
    (multislot costeDiario
        (type FLOAT)
        (create-accessor read-write))
    ;;; Nivel de popularidad turística de la ciudad, e.g. de 1 a 5. Sirve para gestionar la preferencia por lugares menos conocidos.
    (multislot popularidad
        (type INTEGER)
        (create-accessor read-write))
    ;;; Adecuación de la ciudad para viajes culturales.
    (multislot nivelCulturalCiudad
        (type INTEGER)
        (create-accessor read-write))
    ;;; Adecuación de la ciudad para viajes de descanso.
    (multislot nivelDescanso
        (type INTEGER)
        (create-accessor read-write))
    ;;; Adecuación de la ciudad para viajes de diversión u ocio.
    (multislot nivelDiversion
        (type INTEGER)
        (create-accessor read-write))
    ;;; Adecuación de la ciudad para viajes románticos.
    (multislot nivelRomantico
        (type INTEGER)
        (create-accessor read-write))
    ;;; Indica si la ciudad es adecuada para viajes con niños.
    (multislot aptaNinosCiudad
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si la ciudad tiene aeropuerto disponible para conexiones en avión.
    (multislot tieneAeropuerto
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si la ciudad tiene estación de tren para conexiones ferroviarias.
    (multislot tieneEstacionTren
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Clima predominante de la ciudad: calido, frio, templado u otro valor definido por el sistema.
    (multislot tipoClima
        (type STRING)
        (create-accessor read-write))
    ;;; Mínimo de días recomendados para visitar la ciudad con sentido.
    (multislot diasMinRecomendados
        (type INTEGER)
        (create-accessor read-write))
    ;;; Máximo de días recomendados para la ciudad antes de priorizar otras ciudades del plan.
    (multislot diasMaxRecomendados
        (type INTEGER)
        (create-accessor read-write))
)

(defclass TemaViaje "Objetivo o temática turística del viaje, e.g. descanso, cultural, diversión, romántico, familiar o naturaleza."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(definstances instances
    ([cultural] of TemaViaje
    )

    ([descanso] of TemaViaje
    )

    ([diversion] of TemaViaje
    )

    ([romantico] of TemaViaje
    )

    ([familiar] of TemaViaje
    )

    ([naturaleza] of TemaViaje
    )

    ([PerfilJovenDiversion] of PerfilViajero
    )

    ([PerfilFamiliar] of PerfilViajero
    )

    ([PerfilRomantico] of PerfilViajero
    )

    ([PerfilCultural] of PerfilViajero
    )

    ([PerfilDescanso] of PerfilViajero
    )

    ([PerfilGrupoGrande] of PerfilViajero
    )

    ([PerfilMayor] of PerfilViajero
    )

    ([PreferenciaMenosConocido] of Preferencia
    )

    ([PreferenciaTransporteComodo] of Preferencia
    )

    ([PreferenciaAlojamientoCentrico] of Preferencia
    )

    ([PreferenciaAjustarPresupuesto] of Preferencia
    )

    ([RestriccionPresupuesto] of Restriccion
    )

    ([RestriccionDuracion] of Restriccion
    )

    ([RestriccionTransporte] of Restriccion
    )

    ([RestriccionCalidadAlojamiento] of Restriccion
    )

    ([RestriccionAccesibilidad] of Restriccion
    )

    ([Barcelona] of Ciudad
         (ciudadRelacionadaConTema  [cultural] [diversion] [familiar] [romantico])
         (pais  "España")
         (region  "Mediterraneo")
         (costeDiario  95.0)
         (popularidad  5)
         (nivelCulturalCiudad  5)
         (nivelDescanso  3)
         (nivelDiversion  5)
         (nivelRomantico  4)
         (aptaNinosCiudad  "true")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "true")
         (tipoClima  "templado")
         (diasMinRecomendados  2)
         (diasMaxRecomendados  4)
    )

    ([Paris] of Ciudad
         (ciudadRelacionadaConTema  [cultural] [romantico] [familiar])
         (pais  "Francia")
         (region  "EuropaOccidental")
         (costeDiario  120.0)
         (popularidad  5)
         (nivelCulturalCiudad  5)
         (nivelDescanso  2)
         (nivelDiversion  4)
         (nivelRomantico  5)
         (aptaNinosCiudad  "true")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "true")
         (tipoClima  "templado")
         (diasMinRecomendados  3)
         (diasMaxRecomendados  5)
    )

    ([Lisboa] of Ciudad
         (ciudadRelacionadaConTema  [cultural] [descanso] [romantico])
         (pais  "Portugal")
         (region  "Iberica")
         (costeDiario  80.0)
         (popularidad  4)
         (nivelCulturalCiudad  4)
         (nivelDescanso  4)
         (nivelDiversion  4)
         (nivelRomantico  4)
         (aptaNinosCiudad  "true")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "true")
         (tipoClima  "calido")
         (diasMinRecomendados  2)
         (diasMaxRecomendados  4)
    )

    ([Oporto] of Ciudad
         (ciudadRelacionadaConTema  [cultural] [descanso] [romantico])
         (pais  "Portugal")
         (region  "Iberica")
         (costeDiario  70.0)
         (popularidad  3)
         (nivelCulturalCiudad  4)
         (nivelDescanso  4)
         (nivelDiversion  3)
         (nivelRomantico  4)
         (aptaNinosCiudad  "true")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "true")
         (tipoClima  "templado")
         (diasMinRecomendados  2)
         (diasMaxRecomendados  3)
    )

    ([Roma] of Ciudad
         (ciudadRelacionadaConTema  [cultural] [romantico] [familiar])
         (pais  "Italia")
         (region  "Mediterraneo")
         (costeDiario  105.0)
         (popularidad  5)
         (nivelCulturalCiudad  5)
         (nivelDescanso  2)
         (nivelDiversion  4)
         (nivelRomantico  5)
         (aptaNinosCiudad  "true")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "true")
         (tipoClima  "calido")
         (diasMinRecomendados  3)
         (diasMaxRecomendados  5)
    )

    ([Madrid] of Ciudad
         (ciudadRelacionadaConTema  [cultural] [diversion] [familiar])
         (pais  "España")
         (region  "Iberica")
         (costeDiario  90.0)
         (popularidad  4)
         (nivelCulturalCiudad  5)
         (nivelDescanso  2)
         (nivelDiversion  5)
         (nivelRomantico  3)
         (aptaNinosCiudad  "true")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "true")
         (tipoClima  "templado")
         (diasMinRecomendados  2)
         (diasMaxRecomendados  4)
    )

    ([Londres] of Ciudad
         (ciudadRelacionadaConTema  [cultural] [familiar] [diversion])
         (pais  "Reino Unido")
         (region  "EuropaOccidental")
         (costeDiario  140.0)
         (popularidad  5)
         (nivelCulturalCiudad  5)
         (nivelDescanso  2)
         (nivelDiversion  5)
         (nivelRomantico  3)
         (aptaNinosCiudad  "true")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "true")
         (tipoClima  "frio")
         (diasMinRecomendados  3)
         (diasMaxRecomendados  5)
    )

    ([Atenas] of Ciudad
         (ciudadRelacionadaConTema  [cultural] [descanso] [romantico] [familiar] [naturaleza])
         (pais  "Grecia")
         (region  "Mediterraneo")
         (costeDiario  85.0)
         (popularidad  4)
         (nivelCulturalCiudad  5)
         (nivelDescanso  4)
         (nivelDiversion  3)
         (nivelRomantico  4)
         (aptaNinosCiudad  "true")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "false")
         (tipoClima  "calido")
         (diasMinRecomendados  2)
         (diasMaxRecomendados  4)
    )

    ([Ibiza] of Ciudad
         (ciudadRelacionadaConTema  [diversion] [romantico])
         (pais  "España")
         (region  "Mediterraneo")
         (costeDiario  110.0)
         (popularidad  4)
         (nivelCulturalCiudad  2)
         (nivelDescanso  2)
         (nivelDiversion  5)
         (nivelRomantico  4)
         (aptaNinosCiudad  "false")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "false")
         (tipoClima  "calido")
         (diasMinRecomendados  2)
         (diasMaxRecomendados  4)
    )

    ([Budapest] of Ciudad
         (ciudadRelacionadaConTema  [diversion] [romantico] [cultural])
         (pais  "Hungria")
         (region  "EuropaCentral")
         (costeDiario  65.0)
         (popularidad  3)
         (nivelCulturalCiudad  4)
         (nivelDescanso  3)
         (nivelDiversion  5)
         (nivelRomantico  4)
         (aptaNinosCiudad  "false")
         (tieneAeropuerto  "true")
         (tieneEstacionTren  "true")
         (tipoClima  "frio")
         (diasMinRecomendados  2)
         (diasMaxRecomendados  3)
    )

    ([HotelLondresCentro] of Hotel
         (alojamientoEstaEn  [Londres])
         (precioNochePersona  95.0)
         (estrellas  3)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  0.9)
    )

    ([HostalLondresJoven] of Hostal
         (alojamientoEstaEn  [Londres])
         (precioNochePersona  40.0)
         (estrellas  1)
         (capacidadMaxima  10)
         (aptoFamilias  "false")
         (aptoGrupos  "true")
         (tieneAscensor  "false")
         (tienePiscina  "false")
         (distanciaCentro  2.0)
    )

    ([HotelLondresLujo] of Hotel
         (alojamientoEstaEn  [Londres])
         (precioNochePersona  180.0)
         (estrellas  5)
         (capacidadMaxima  2)
         (aptoFamilias  "false")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  0.3)
    )

    ([ApartamentoLondresFamilia] of Apartamento
         (alojamientoEstaEn  [Londres])
         (precioNochePersona  85.0)
         (estrellas  3)
         (capacidadMaxima  6)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.5)
    )

    ([HotelAtenasCentro] of Hotel
         (alojamientoEstaEn  [Atenas])
         (precioNochePersona  70.0)
         (estrellas  3)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  0.7)
    )

    ([ApartamentoAtenasFamilia] of Apartamento
         (alojamientoEstaEn  [Atenas])
         (precioNochePersona  50.0)
         (estrellas  3)
         (capacidadMaxima  6)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.2)
    )

    ([HotelAtenasLujo] of Hotel
         (alojamientoEstaEn  [Atenas])
         (precioNochePersona  130.0)
         (estrellas  5)
         (capacidadMaxima  2)
         (aptoFamilias  "false")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  0.3)
    )

    ([HotelIbizaFiesta] of Hotel
         (alojamientoEstaEn  [Ibiza])
         (precioNochePersona  85.0)
         (estrellas  3)
         (capacidadMaxima  4)
         (aptoFamilias  "false")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  1.0)
    )

    ([HotelIbizaRomantico] of Hotel
         (alojamientoEstaEn  [Ibiza])
         (precioNochePersona  150.0)
         (estrellas  5)
         (capacidadMaxima  2)
         (aptoFamilias  "false")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  0.5)
    )

    ([ApartamentoIbizaGrupo] of Apartamento
         (alojamientoEstaEn  [Ibiza])
         (precioNochePersona  65.0)
         (estrellas  3)
         (capacidadMaxima  15)
         (aptoFamilias  "false")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  1.5)
    )

    ([ApartamentoIbizaGrupoGrande] of Apartamento
         (alojamientoEstaEn  [Ibiza])
         (precioNochePersona  50.0)
         (estrellas  3)
         (capacidadMaxima  10)
         (aptoFamilias  "false")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  1.8)
    )

    ([HotelBudapestCentro] of Hotel
         (alojamientoEstaEn  [Budapest])
         (precioNochePersona  50.0)
         (estrellas  3)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  0.8)
    )

    ([HostalBudapestJoven] of Hostal
         (alojamientoEstaEn  [Budapest])
         (precioNochePersona  20.0)
         (estrellas  1)
         (capacidadMaxima  12)
         (aptoFamilias  "false")
         (aptoGrupos  "true")
         (tieneAscensor  "false")
         (tienePiscina  "false")
         (distanciaCentro  1.5)
    )

    ([ApartamentoBudapestGrupo] of Apartamento
         (alojamientoEstaEn  [Budapest])
         (precioNochePersona  35.0)
         (estrellas  3)
         (capacidadMaxima  10)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.2)
    )

    ([HotelBudapest2Estrellas] of Hotel
         (alojamientoEstaEn  [Budapest])
         (precioNochePersona  30.0)
         (estrellas  2)
         (capacidadMaxima  4)
         (aptoFamilias  "false")
         (aptoGrupos  "false")
         (tieneAscensor  "false")
         (tienePiscina  "false")
         (distanciaCentro  1.5)
    )

    ([HotelParisCentro] of Hotel
         (alojamientoEstaEn  [Paris])
         (precioNochePersona  90.0)
         (estrellas  3)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  0.9)
    )

    ([ApartamentoParisGrupo] of Apartamento
         (alojamientoEstaEn  [Paris])
         (precioNochePersona  75.0)
         (estrellas  3)
         (capacidadMaxima  8)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.4)
    )

    ([HotelParisRomantico] of Hotel
         (alojamientoEstaEn  [Paris])
         (precioNochePersona  110.0)
         (estrellas  4)
         (capacidadMaxima  2)
         (aptoFamilias  "false")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  0.6)
    )

    ([HostalRomaJoven] of Hostal
         (alojamientoEstaEn  [Roma])
         (precioNochePersona  38.0)
         (estrellas  1)
         (capacidadMaxima  10)
         (aptoFamilias  "false")
         (aptoGrupos  "true")
         (tieneAscensor  "false")
         (tienePiscina  "false")
         (distanciaCentro  1.6)
    )

    ([ApartamentoRomaFamilia] of Apartamento
         (alojamientoEstaEn  [Roma])
         (precioNochePersona  65.0)
         (estrellas  3)
         (capacidadMaxima  6)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.3)
    )

    ([HotelRomaCentro] of Hotel
         (alojamientoEstaEn  [Roma])
         (precioNochePersona  90.0)
         (estrellas  3)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  0.7)
    )

    ([HotelRomaLujo] of Hotel
         (alojamientoEstaEn  [Roma])
         (precioNochePersona  140.0)
         (estrellas  5)
         (capacidadMaxima  2)
         (aptoFamilias  "false")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  0.5)
    )

    ([ApartamentoBarcelonaGrupo] of Apartamento
         (alojamientoEstaEn  [Barcelona])
         (precioNochePersona  55.0)
         (estrellas  3)
         (capacidadMaxima  10)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.6)
    )

    ([HotelBarcelonaLujo] of Hotel
         (alojamientoEstaEn  [Barcelona])
         (precioNochePersona  150.0)
         (estrellas  5)
         (capacidadMaxima  2)
         (aptoFamilias  "false")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "true")
         (distanciaCentro  0.3)
    )

    ([HotelBarcelonaCentro] of Hotel
         (alojamientoEstaEn  [Barcelona])
         (precioNochePersona  75.0)
         (estrellas  3)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  0.8)
    )

    ([HostalBarcelonaJoven] of Hostal
         (alojamientoEstaEn  [Barcelona])
         (precioNochePersona  35.0)
         (estrellas  1)
         (capacidadMaxima  8)
         (aptoFamilias  "false")
         (aptoGrupos  "true")
         (tieneAscensor  "false")
         (tienePiscina  "false")
         (distanciaCentro  1.5)
    )

    ([HotelMadridCentro] of Hotel
         (alojamientoEstaEn  [Madrid])
         (precioNochePersona  70.0)
         (estrellas  3)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  0.7)
    )

    ([ApartamentoMadridGrupo] of Apartamento
         (alojamientoEstaEn  [Madrid])
         (precioNochePersona  48.0)
         (estrellas  3)
         (capacidadMaxima  7)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.4)
    )

    ([ApartamentoLisboaFamilia] of Apartamento
         (alojamientoEstaEn  [Lisboa])
         (precioNochePersona  45.0)
         (estrellas  3)
         (capacidadMaxima  6)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.2)
    )

    ([ApartamentoLisboaGrupoGrande] of Apartamento
         (alojamientoEstaEn  [Lisboa])
         (precioNochePersona  45.0)
         (estrellas  3)
         (capacidadMaxima  10)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.5)
    )

    ([HotelLisboa2Estrellas] of Hotel
         (alojamientoEstaEn  [Lisboa])
         (precioNochePersona  40.0)
         (estrellas  2)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "false")
         (tienePiscina  "false")
         (distanciaCentro  1.3)
    )

    ([ApartamentoOportoCentro] of Apartamento
         (alojamientoEstaEn  [Oporto])
         (precioNochePersona  50.0)
         (estrellas  3)
         (capacidadMaxima  5)
         (aptoFamilias  "true")
         (aptoGrupos  "true")
         (tieneAscensor  "true")
         (tienePiscina  "false")
         (distanciaCentro  1.0)
    )

    ([HotelOporto2Estrellas] of Hotel
         (alojamientoEstaEn  [Oporto])
         (precioNochePersona  38.0)
         (estrellas  2)
         (capacidadMaxima  4)
         (aptoFamilias  "true")
         (aptoGrupos  "false")
         (tieneAscensor  "false")
         (tienePiscina  "false")
         (distanciaCentro  1.4)
    )

    ([HostalOportoJoven] of Hostal
         (alojamientoEstaEn  [Oporto])
         (precioNochePersona  30.0)
         (estrellas  1)
         (capacidadMaxima  8)
         (aptoFamilias  "false")
         (aptoGrupos  "true")
         (tieneAscensor  "false")
         (tienePiscina  "false")
         (distanciaCentro  1.3)
    )

    ([TrenBarcelonaParis] of Tren
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Paris])
         (precioPersona  95.0)
         (duracionHoras  6.5)
         (nivelComodidad  4)
         (distanciaKm  1030.0)
    )

    ([AvionBarcelonaParis] of Avion
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Paris])
         (precioPersona  120.0)
         (duracionHoras  2.0)
         (nivelComodidad  4)
         (distanciaKm  830.0)
    )

    ([TrenBarcelonaMadrid] of Tren
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Madrid])
         (precioPersona  65.0)
         (duracionHoras  2.8)
         (nivelComodidad  4)
         (distanciaKm  620.0)
    )

    ([TrenMadridBarcelona] of Tren
         (origenTransporte  [Madrid])
         (destinoTransporte  [Barcelona])
         (precioPersona  65.0)
         (duracionHoras  2.8)
         (nivelComodidad  4)
         (distanciaKm  620.0)
    )

    ([TrenBarcelonaLisboa] of Tren
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Lisboa])
         (precioPersona  85.0)
         (duracionHoras  9.0)
         (nivelComodidad  1)
         (distanciaKm  1000.0)
    )

    ([AvionBarcelonaLisboa] of Avion
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Lisboa])
         (precioPersona  95.0)
         (duracionHoras  2.0)
         (nivelComodidad  4)
         (distanciaKm  1000.0)
    )

    ([BusLisboaOporto] of Bus
         (origenTransporte  [Lisboa])
         (destinoTransporte  [Oporto])
         (precioPersona  25.0)
         (duracionHoras  3.5)
         (nivelComodidad  1)
         (distanciaKm  315.0)
    )

    ([TrenLisboaOporto] of Tren
         (origenTransporte  [Lisboa])
         (destinoTransporte  [Oporto])
         (precioPersona  35.0)
         (duracionHoras  3.0)
         (nivelComodidad  1)
         (distanciaKm  315.0)
    )

    ([TrenOportoMadrid] of Tren
         (origenTransporte  [Oporto])
         (destinoTransporte  [Madrid])
         (precioPersona  70.0)
         (duracionHoras  6.0)
         (nivelComodidad  2)
         (distanciaKm  560.0)
    )

    ([TrenMadridLisboa] of Tren
         (origenTransporte  [Madrid])
         (destinoTransporte  [Lisboa])
         (precioPersona  75.0)
         (duracionHoras  9.5)
         (nivelComodidad  3)
         (distanciaKm  625.0)
    )

    ([AvionMadridParis] of Avion
         (origenTransporte  [Madrid])
         (destinoTransporte  [Paris])
         (precioPersona  100.0)
         (duracionHoras  2.1)
         (nivelComodidad  4)
         (distanciaKm  1050.0)
    )

    ([AvionParisRoma] of Avion
         (origenTransporte  [Paris])
         (destinoTransporte  [Roma])
         (precioPersona  130.0)
         (duracionHoras  2.1)
         (nivelComodidad  4)
         (distanciaKm  1105.0)
    )

    ([AvionLisboaRoma] of Avion
         (origenTransporte  [Lisboa])
         (destinoTransporte  [Roma])
         (precioPersona  125.0)
         (duracionHoras  3.0)
         (nivelComodidad  4)
         (distanciaKm  1860.0)
    )

    ([AvionLisboaIbiza] of Avion
         (origenTransporte  [Lisboa])
         (destinoTransporte  [Ibiza])
         (precioPersona  90.0)
         (duracionHoras  2.0)
         (nivelComodidad  4)
         (distanciaKm  910.0)
    )

    ([AvionLisboaBudapest] of Avion
         (origenTransporte  [Lisboa])
         (destinoTransporte  [Budapest])
         (precioPersona  120.0)
         (duracionHoras  3.0)
         (nivelComodidad  4)
         (distanciaKm  2470.0)
    )

    ([AvionLondresParis] of Avion
         (origenTransporte  [Londres])
         (destinoTransporte  [Paris])
         (precioPersona  95.0)
         (duracionHoras  1.5)
         (nivelComodidad  4)
         (distanciaKm  340.0)
    )

    ([TrenLondresParis] of Tren
         (origenTransporte  [Londres])
         (destinoTransporte  [Paris])
         (precioPersona  85.0)
         (duracionHoras  2.5)
         (nivelComodidad  5)
         (distanciaKm  450.0)
    )

    ([AvionLondresRoma] of Avion
         (origenTransporte  [Londres])
         (destinoTransporte  [Roma])
         (precioPersona  125.0)
         (duracionHoras  2.5)
         (nivelComodidad  4)
         (distanciaKm  1430.0)
    )

    ([AvionRomaAtenas] of Avion
         (origenTransporte  [Roma])
         (destinoTransporte  [Atenas])
         (precioPersona  110.0)
         (duracionHoras  2.0)
         (nivelComodidad  4)
         (distanciaKm  1050.0)
    )

    ([AvionAtenasRoma] of Avion
         (origenTransporte  [Atenas])
         (destinoTransporte  [Roma])
         (precioPersona  110.0)
         (duracionHoras  2.0)
         (nivelComodidad  4)
         (distanciaKm  1050.0)
    )

    ([AvionBarcelonaRoma] of Avion
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Roma])
         (precioPersona  110.0)
         (duracionHoras  2.0)
         (nivelComodidad  4)
         (distanciaKm  860.0)
    )

    ([AvionBarcelonaLondres] of Avion
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Londres])
         (precioPersona  100.0)
         (duracionHoras  2.2)
         (nivelComodidad  4)
         (distanciaKm  1140.0)
    )

    ([AvionMadridLondres] of Avion
         (origenTransporte  [Madrid])
         (destinoTransporte  [Londres])
         (precioPersona  105.0)
         (duracionHoras  2.3)
         (nivelComodidad  4)
         (distanciaKm  1260.0)
    )

    ([AvionMadridRoma] of Avion
         (origenTransporte  [Madrid])
         (destinoTransporte  [Roma])
         (precioPersona  115.0)
         (duracionHoras  2.4)
         (nivelComodidad  4)
         (distanciaKm  1360.0)
    )

    ([AvionBarcelonaIbiza] of Avion
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Ibiza])
         (precioPersona  70.0)
         (duracionHoras  1.0)
         (nivelComodidad  4)
         (distanciaKm  230.0)
    )

    ([AvionMadridIbiza] of Avion
         (origenTransporte  [Madrid])
         (destinoTransporte  [Ibiza])
         (precioPersona  75.0)
         (duracionHoras  1.2)
         (nivelComodidad  4)
         (distanciaKm  375.0)
    )

    ([AvionIbizaBarcelona] of Avion
         (origenTransporte  [Ibiza])
         (destinoTransporte  [Barcelona])
         (precioPersona  70.0)
         (duracionHoras  1.0)
         (nivelComodidad  4)
         (distanciaKm  230.0)
    )

    ([AvionIbizaBudapest] of Avion
         (origenTransporte  [Ibiza])
         (destinoTransporte  [Budapest])
         (precioPersona  130.0)
         (duracionHoras  2.5)
         (nivelComodidad  3)
         (distanciaKm  1700.0)
    )

    ([AvionIbizaMadrid] of Avion
         (origenTransporte  [Ibiza])
         (destinoTransporte  [Madrid])
         (precioPersona  75.0)
         (duracionHoras  1.2)
         (nivelComodidad  4)
         (distanciaKm  375.0)
    )

    ([AvionIbizaLisboa] of Avion
         (origenTransporte  [Ibiza])
         (destinoTransporte  [Lisboa])
         (precioPersona  90.0)
         (duracionHoras  2.0)
         (nivelComodidad  4)
         (distanciaKm  910.0)
    )

    ([AvionBarcelonaBudapest] of Avion
         (origenTransporte  [Barcelona])
         (destinoTransporte  [Budapest])
         (precioPersona  90.0)
         (duracionHoras  2.5)
         (nivelComodidad  4)
         (distanciaKm  1500.0)
    )

    ([AvionBudapestBarcelona] of Avion
         (origenTransporte  [Budapest])
         (destinoTransporte  [Barcelona])
         (precioPersona  90.0)
         (duracionHoras  2.5)
         (nivelComodidad  4)
         (distanciaKm  1500.0)
    )

    ([AvionBudapestLisboa] of Avion
         (origenTransporte  [Budapest])
         (destinoTransporte  [Lisboa])
         (precioPersona  120.0)
         (duracionHoras  3.0)
         (nivelComodidad  4)
         (distanciaKm  2470.0)
    )

    ([TransporteLocalBarcelona] of TransporteLocal
         (transporteLocalEn  [Barcelona])
         (precioDia  8.0)
    )

    ([TransporteLocalParis] of TransporteLocal
         (transporteLocalEn  [Paris])
         (precioDia  10.0)
    )

    ([TransporteLocalLisboa] of TransporteLocal
         (transporteLocalEn  [Lisboa])
         (precioDia  7.0)
    )

    ([TransporteLocalOporto] of TransporteLocal
         (transporteLocalEn  [Oporto])
         (precioDia  6.0)
    )

    ([TransporteLocalRoma] of TransporteLocal
         (transporteLocalEn  [Roma])
         (precioDia  9.0)
    )

    ([TransporteLocalMadrid] of TransporteLocal
         (transporteLocalEn  [Madrid])
         (precioDia  8.0)
    )

    ([TransporteLocalLondres] of TransporteLocal
         (transporteLocalEn  [Londres])
         (precioDia  13.0)
    )

    ([TransporteLocalAtenas] of TransporteLocal
         (transporteLocalEn  [Atenas])
         (precioDia  7.0)
    )

    ([TransporteLocalIbiza] of TransporteLocal
         (transporteLocalEn  [Ibiza])
         (precioDia  6.0)
    )

    ([TransporteLocalBudapest] of TransporteLocal
         (transporteLocalEn  [Budapest])
         (precioDia  4.0)
    )

    ([SagradaFamilia] of Monumento
         (lugarVisitaEstaEn  [Barcelona])
         (lugarRelacionadoConTema  [cultural] [familiar])
         (precioEntrada  26.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([ParcGuell] of Parque
         (lugarVisitaEstaEn  [Barcelona])
         (lugarRelacionadoConTema  [cultural] [familiar] [descanso])
         (precioEntrada  10.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  4)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  4)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([MuseoLouvre] of Museo
         (lugarVisitaEstaEn  [Paris])
         (lugarRelacionadoConTema  [cultural] [familiar])
         (precioEntrada  22.0)
         (duracionVisitaHoras  4.0)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  2)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([TorreEiffel] of Monumento
         (lugarVisitaEstaEn  [Paris])
         (lugarRelacionadoConTema  [cultural] [romantico] [familiar])
         (precioEntrada  29.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  4)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  5)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([CabareParisLido] of ActividadOcio
         (lugarVisitaEstaEn  [Paris])
         (lugarRelacionadoConTema  [diversion] [romantico])
         (precioEntrada  90.0)
         (duracionVisitaHoras  3.0)
         (nivelCulturalLugar  2)
         (nivelDiversionLugar  5)
         (nivelDescansoLugar  2)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "false")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([TorreBelem] of Monumento
         (lugarVisitaEstaEn  [Lisboa])
         (lugarRelacionadoConTema  [cultural] [romantico])
         (precioEntrada  8.0)
         (duracionVisitaHoras  1.5)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  2)
         (nivelDescansoLugar  3)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([BarrioAlto] of ActividadOcio
         (lugarVisitaEstaEn  [Lisboa])
         (lugarRelacionadoConTema  [diversion] [cultural])
         (precioEntrada  15.0)
         (duracionVisitaHoras  3.0)
         (nivelCulturalLugar  2)
         (nivelDiversionLugar  5)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  2)
         (aptoNinosLugar  "false")
         (aptoMayoresLugar  "false")
         (requiereReserva  "false")
    )

    ([RibeiraOporto] of Monumento
         (lugarVisitaEstaEn  [Oporto])
         (lugarRelacionadoConTema  [cultural] [descanso] [romantico])
         (precioEntrada  0.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  4)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  4)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([Coliseo] of Monumento
         (lugarVisitaEstaEn  [Roma])
         (lugarRelacionadoConTema  [cultural] [familiar])
         (precioEntrada  18.0)
         (duracionVisitaHoras  2.5)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([Trastevere] of Restaurante
         (lugarVisitaEstaEn  [Roma])
         (lugarRelacionadoConTema  [romantico] [cultural] [diversion])
         (precioEntrada  25.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  3)
         (nivelDiversionLugar  4)
         (nivelDescansoLugar  3)
         (nivelRomanticoLugar  5)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([MuseoPrado] of Museo
         (lugarVisitaEstaEn  [Madrid])
         (lugarRelacionadoConTema  [cultural] [familiar])
         (precioEntrada  15.0)
         (duracionVisitaHoras  3.0)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  2)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([ParqueRetiro] of Parque
         (lugarVisitaEstaEn  [Madrid])
         (lugarRelacionadoConTema  [descanso] [familiar] [romantico] [naturaleza])
         (precioEntrada  0.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  3)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  5)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([TablaosFlamencoMadrid] of ActividadOcio
         (lugarVisitaEstaEn  [Madrid])
         (lugarRelacionadoConTema  [diversion] [cultural] [romantico])
         (precioEntrada  45.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  4)
         (nivelDiversionLugar  4)
         (nivelDescansoLugar  2)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "false")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([BritishMuseum] of Museo
         (lugarVisitaEstaEn  [Londres])
         (lugarRelacionadoConTema  [cultural] [familiar])
         (precioEntrada  0.0)
         (duracionVisitaHoras  3.0)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  2)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  2)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([TowerOfLondon] of Monumento
         (lugarVisitaEstaEn  [Londres])
         (lugarRelacionadoConTema  [cultural] [familiar])
         (precioEntrada  30.0)
         (duracionVisitaHoras  2.5)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  2)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([HydePark] of Parque
         (lugarVisitaEstaEn  [Londres])
         (lugarRelacionadoConTema  [descanso] [familiar] [romantico] [naturaleza])
         (precioEntrada  0.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  2)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  5)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([SohoLondres] of ActividadOcio
         (lugarVisitaEstaEn  [Londres])
         (lugarRelacionadoConTema  [diversion])
         (precioEntrada  20.0)
         (duracionVisitaHoras  3.0)
         (nivelCulturalLugar  2)
         (nivelDiversionLugar  5)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "false")
         (aptoMayoresLugar  "false")
         (requiereReserva  "false")
    )

    ([Acropolis] of Monumento
         (lugarVisitaEstaEn  [Atenas])
         (lugarRelacionadoConTema  [cultural] [familiar] [romantico])
         (precioEntrada  20.0)
         (duracionVisitaHoras  3.0)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  2)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "false")
         (requiereReserva  "true")
    )

    ([MuseoArqueologicoAtenas] of Museo
         (lugarVisitaEstaEn  [Atenas])
         (lugarRelacionadoConTema  [cultural] [familiar])
         (precioEntrada  12.0)
         (duracionVisitaHoras  2.5)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  1)
         (nivelDescansoLugar  2)
         (nivelRomanticoLugar  2)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([PlayaGlifada] of Playa
         (lugarVisitaEstaEn  [Atenas])
         (lugarRelacionadoConTema  [descanso] [romantico] [naturaleza])
         (precioEntrada  0.0)
         (duracionVisitaHoras  4.0)
         (nivelCulturalLugar  1)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  5)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([BarrioMonastiraki] of ActividadOcio
         (lugarVisitaEstaEn  [Atenas])
         (lugarRelacionadoConTema  [diversion] [cultural])
         (precioEntrada  0.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  3)
         (nivelDiversionLugar  4)
         (nivelDescansoLugar  2)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([PlayasTalamanca] of Playa
         (lugarVisitaEstaEn  [Ibiza])
         (lugarRelacionadoConTema  [descanso] [romantico] [naturaleza])
         (precioEntrada  0.0)
         (duracionVisitaHoras  4.0)
         (nivelCulturalLugar  1)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  5)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([ClubPachaIbiza] of ActividadOcio
         (lugarVisitaEstaEn  [Ibiza])
         (lugarRelacionadoConTema  [diversion])
         (precioEntrada  40.0)
         (duracionVisitaHoras  5.0)
         (nivelCulturalLugar  1)
         (nivelDiversionLugar  5)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  2)
         (aptoNinosLugar  "false")
         (aptoMayoresLugar  "false")
         (requiereReserva  "false")
    )

    ([DaltVila] of Monumento
         (lugarVisitaEstaEn  [Ibiza])
         (lugarRelacionadoConTema  [cultural] [romantico])
         (precioEntrada  0.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  4)
         (nivelDiversionLugar  2)
         (nivelDescansoLugar  3)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([BanosSzechenyi] of ActividadOcio
         (lugarVisitaEstaEn  [Budapest])
         (lugarRelacionadoConTema  [descanso] [romantico])
         (precioEntrada  22.0)
         (duracionVisitaHoras  3.0)
         (nivelCulturalLugar  2)
         (nivelDiversionLugar  3)
         (nivelDescansoLugar  5)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([ParlamentoBudapest] of Monumento
         (lugarVisitaEstaEn  [Budapest])
         (lugarRelacionadoConTema  [cultural] [familiar])
         (precioEntrada  18.0)
         (duracionVisitaHoras  2.0)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  2)
         (nivelDescansoLugar  2)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "true")
    )

    ([RuinBarsBudapest] of ActividadOcio
         (lugarVisitaEstaEn  [Budapest])
         (lugarRelacionadoConTema  [diversion])
         (precioEntrada  5.0)
         (duracionVisitaHoras  4.0)
         (nivelCulturalLugar  2)
         (nivelDiversionLugar  5)
         (nivelDescansoLugar  1)
         (nivelRomanticoLugar  3)
         (aptoNinosLugar  "false")
         (aptoMayoresLugar  "false")
         (requiereReserva  "false")
    )

    ([CastilloBuda] of Monumento
         (lugarVisitaEstaEn  [Budapest])
         (lugarRelacionadoConTema  [cultural] [romantico] [familiar])
         (precioEntrada  8.0)
         (duracionVisitaHoras  2.5)
         (nivelCulturalLugar  5)
         (nivelDiversionLugar  2)
         (nivelDescansoLugar  2)
         (nivelRomanticoLugar  4)
         (aptoNinosLugar  "true")
         (aptoMayoresLugar  "true")
         (requiereReserva  "false")
    )

    ([ViajeroRomantico] of Viajero
         (tienePerfil  [PerfilRomantico])
         (tienePreferencia  [PreferenciaTransporteComodo] [PreferenciaAlojamientoCentrico])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion] [RestriccionCalidadAlojamiento])
         (edadMedia  30)
         (nivelCulturalViajero  4)
         (tieneNinos  "false")
         (tieneMayores  "false")
         (eventoEspecial  "luna_miel")
         (tipoGrupo  "pareja")
         (numeroPersonas  2)
         (objetivoViaje  "romantico")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "junio")
         (minDiasViaje  5)
         (maxDiasViaje  8)
         (minCiudades  2)
         (maxCiudades  3)
         (minDiasPorCiudad  2)
         (maxDiasPorCiudad  4)
         (presupuestoTotal  1800.0)
         (presupuestoDiarioPersona  130.0)
         (transporteProhibido  "ninguno")
         (transportePreferido  "tren")
         (minEstrellasAlojamiento  3)
         (maxEstrellasAlojamiento  4)
         (nivelMovilidad  "media")
         (dispuestoReducirDuracion  "false")
         (dispuestoReducirCalidad  "false")
         (prefiereMenosConocido  "false")
         (preferenciaClima  "templado")
    )

    ([ViajeroFamiliar] of Viajero
         (tienePerfil  [PerfilFamiliar])
         (tienePreferencia  [PreferenciaMenosConocido] [PreferenciaAjustarPresupuesto])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion] [RestriccionTransporte])
         (edadMedia  40)
         (nivelCulturalViajero  3)
         (tieneNinos  "true")
         (tieneMayores  "false")
         (eventoEspecial  "ninguno")
         (tipoGrupo  "familia")
         (numeroPersonas  4)
         (objetivoViaje  "familiar")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "agosto")
         (minDiasViaje  4)
         (maxDiasViaje  7)
         (minCiudades  1)
         (maxCiudades  2)
         (minDiasPorCiudad  2)
         (maxDiasPorCiudad  4)
         (presupuestoTotal  1600.0)
         (presupuestoDiarioPersona  90.0)
         (transporteProhibido  "avion")
         (transportePreferido  "tren")
         (minEstrellasAlojamiento  2)
         (maxEstrellasAlojamiento  3)
         (nivelMovilidad  "media")
         (dispuestoReducirDuracion  "true")
         (dispuestoReducirCalidad  "true")
         (prefiereMenosConocido  "true")
         (preferenciaClima  "calido")
    )

    ([ViajeroJoven] of Viajero
         (tienePerfil  [PerfilJovenDiversion])
         (tienePreferencia  [PreferenciaAjustarPresupuesto])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion])
         (edadMedia  24)
         (nivelCulturalViajero  2)
         (tieneNinos  "false")
         (tieneMayores  "false")
         (eventoEspecial  "fin_de_curso")
         (tipoGrupo  "amigos")
         (numeroPersonas  6)
         (objetivoViaje  "diversion")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "julio")
         (minDiasViaje  3)
         (maxDiasViaje  6)
         (minCiudades  1)
         (maxCiudades  2)
         (minDiasPorCiudad  2)
         (maxDiasPorCiudad  3)
         (presupuestoTotal  900.0)
         (presupuestoDiarioPersona  85.0)
         (transporteProhibido  "ninguno")
         (transportePreferido  "bus")
         (minEstrellasAlojamiento  1)
         (maxEstrellasAlojamiento  3)
         (nivelMovilidad  "alta")
         (dispuestoReducirDuracion  "true")
         (dispuestoReducirCalidad  "true")
         (prefiereMenosConocido  "true")
         (preferenciaClima  "calido")
    )

    ([ViajeroCultural] of Viajero
         (tienePerfil  [PerfilCultural])
         (tienePreferencia  [PreferenciaAlojamientoCentrico] [PreferenciaTransporteComodo])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion] [RestriccionCalidadAlojamiento])
         (edadMedia  45)
         (nivelCulturalViajero  5)
         (tieneNinos  "false")
         (tieneMayores  "false")
         (eventoEspecial  "ninguno")
         (tipoGrupo  "solo")
         (numeroPersonas  1)
         (objetivoViaje  "cultural")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "octubre")
         (minDiasViaje  7)
         (maxDiasViaje  12)
         (minCiudades  3)
         (maxCiudades  4)
         (minDiasPorCiudad  2)
         (maxDiasPorCiudad  4)
         (presupuestoTotal  3500.0)
         (presupuestoDiarioPersona  200.0)
         (transporteProhibido  "ninguno")
         (transportePreferido  "tren")
         (minEstrellasAlojamiento  4)
         (maxEstrellasAlojamiento  5)
         (nivelMovilidad  "alta")
         (dispuestoReducirDuracion  "false")
         (dispuestoReducirCalidad  "false")
         (prefiereMenosConocido  "false")
         (preferenciaClima  "indiferente")
    )

    ([ViajeroEconomico] of Viajero
         (tienePerfil  [PerfilJovenDiversion])
         (tienePreferencia  [PreferenciaAjustarPresupuesto] [PreferenciaMenosConocido])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion] [RestriccionCalidadAlojamiento])
         (edadMedia  22)
         (nivelCulturalViajero  2)
         (tieneNinos  "false")
         (tieneMayores  "false")
         (eventoEspecial  "ninguno")
         (tipoGrupo  "solo")
         (numeroPersonas  1)
         (objetivoViaje  "diversion")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "marzo")
         (minDiasViaje  3)
         (maxDiasViaje  5)
         (minCiudades  1)
         (maxCiudades  2)
         (minDiasPorCiudad  1)
         (maxDiasPorCiudad  3)
         (presupuestoTotal  400.0)
         (presupuestoDiarioPersona  70.0)
         (transporteProhibido  "ninguno")
         (transportePreferido  "bus")
         (minEstrellasAlojamiento  1)
         (maxEstrellasAlojamiento  2)
         (nivelMovilidad  "alta")
         (dispuestoReducirDuracion  "true")
         (dispuestoReducirCalidad  "true")
         (prefiereMenosConocido  "true")
         (preferenciaClima  "indiferente")
    )

    ([ViajeroGrupoGrande] of Viajero
         (tienePerfil  [PerfilGrupoGrande])
         (tienePreferencia  [PreferenciaAjustarPresupuesto])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion])
         (edadMedia  35)
         (nivelCulturalViajero  3)
         (tieneNinos  "false")
         (tieneMayores  "false")
         (eventoEspecial  "ninguno")
         (tipoGrupo  "grupo_grande")
         (numeroPersonas  10)
         (objetivoViaje  "diversion")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "septiembre")
         (minDiasViaje  4)
         (maxDiasViaje  7)
         (minCiudades  2)
         (maxCiudades  3)
         (minDiasPorCiudad  2)
         (maxDiasPorCiudad  3)
         (presupuestoTotal  4000.0)
         (presupuestoDiarioPersona  120.0)
         (transporteProhibido  "ninguno")
         (transportePreferido  "avion")
         (minEstrellasAlojamiento  2)
         (maxEstrellasAlojamiento  3)
         (nivelMovilidad  "alta")
         (dispuestoReducirDuracion  "false")
         (dispuestoReducirCalidad  "true")
         (prefiereMenosConocido  "false")
         (preferenciaClima  "calido")
    )

    ([ViajeroMayor] of Viajero
         (tienePerfil  [PerfilMayor] [PerfilDescanso])
         (tienePreferencia  [PreferenciaAlojamientoCentrico] [PreferenciaTransporteComodo])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion] [RestriccionCalidadAlojamiento] [RestriccionAccesibilidad])
         (edadMedia  68)
         (nivelCulturalViajero  4)
         (tieneNinos  "false")
         (tieneMayores  "true")
         (eventoEspecial  "ninguno")
         (tipoGrupo  "pareja")
         (numeroPersonas  2)
         (objetivoViaje  "descanso")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "mayo")
         (minDiasViaje  5)
         (maxDiasViaje  10)
         (minCiudades  2)
         (maxCiudades  3)
         (minDiasPorCiudad  2)
         (maxDiasPorCiudad  4)
         (presupuestoTotal  2200.0)
         (presupuestoDiarioPersona  120.0)
         (transporteProhibido  "ninguno")
         (transportePreferido  "tren")
         (minEstrellasAlojamiento  3)
         (maxEstrellasAlojamiento  5)
         (nivelMovilidad  "baja")
         (dispuestoReducirDuracion  "false")
         (dispuestoReducirCalidad  "false")
         (prefiereMenosConocido  "false")
         (preferenciaClima  "calido")
    )

    ([ViajeroSinTren] of Viajero
         (tienePerfil  [PerfilCultural] [PerfilDescanso])
         (tienePreferencia  [PreferenciaMenosConocido] [PreferenciaTransporteComodo])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion] [RestriccionTransporte])
         (edadMedia  38)
         (nivelCulturalViajero  4)
         (tieneNinos  "false")
         (tieneMayores  "false")
         (eventoEspecial  "ninguno")
         (tipoGrupo  "pareja")
         (numeroPersonas  2)
         (objetivoViaje  "cultural")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "noviembre")
         (minDiasViaje  6)
         (maxDiasViaje  10)
         (minCiudades  2)
         (maxCiudades  4)
         (minDiasPorCiudad  2)
         (maxDiasPorCiudad  3)
         (presupuestoTotal  2000.0)
         (presupuestoDiarioPersona  130.0)
         (transporteProhibido  "tren")
         (transportePreferido  "avion")
         (minEstrellasAlojamiento  3)
         (maxEstrellasAlojamiento  4)
         (nivelMovilidad  "media")
         (dispuestoReducirDuracion  "false")
         (dispuestoReducirCalidad  "false")
         (prefiereMenosConocido  "true")
         (preferenciaClima  "indiferente")
    )

    ([ViajeroImposibleDuracion] of Viajero
         (tienePerfil  [PerfilCultural])
         (tieneRestriccion  [RestriccionPresupuesto] [RestriccionDuracion])
         (edadMedia  35)
         (tipoGrupo  "pareja")
         (numeroPersonas  2)
         (objetivoViaje  "cultural")
         (ciudadOrigen  "Barcelona")
         (mesViaje  "abril")
         (minDiasViaje  4)
         (maxDiasViaje  5)
         (minCiudades  3)
         (maxCiudades  4)
         (minDiasPorCiudad  2)
         (maxDiasPorCiudad  3)
         (presupuestoTotal  3000.0)
         (transporteProhibido  "ninguno")
         (minEstrellasAlojamiento  3)
         (maxEstrellasAlojamiento  5)
         (nivelMovilidad  "alta")
         (dispuestoReducirDuracion  "false")
         (dispuestoReducirCalidad  "false")
    )

)
