;;;;
;; reglas.clp
;; Sistema experto de recomendacion de viajes
;; Ontologia esperada: ontologia.clp generada con owl2clips
;; Metodologia: propose-and-revise
;; Fases:
;; 1) Abstraccion/perfilado
;; 2) Seleccion de ciudades candidatas
;; 3) Seleccion de alojamientos
;; 4) Seleccion de visitas
;; 5) Seleccion de transportes
;; 6) Construccion de planes
;; 7) Revision de restricciones
;; 8) Evaluacion de preferencias
;; 9) Seleccion y presentacion final
;;;;

(defmodule MAIN
    (export deftemplate ?ALL)
    (export deffunction ?ALL)
    (export defclass ?ALL)
)

;;;;
;; Templates de control
;;;;

(deftemplate fase
    (slot nombre)
)

(deftemplate perfil-deducido
    (slot viajero)
    (slot perfil)
    (slot motivo)
)

(deftemplate preferencia-deducida
    (slot viajero)
    (slot preferencia)
    (slot motivo)
)

(deftemplate restriccion-deducida
    (slot viajero)
    (slot restriccion)
    (slot motivo)
)

(deftemplate candidato-ciudad
    (slot viajero)
    (slot ciudad)
    (slot puntuacion)
)

(deftemplate candidato-alojamiento
    (slot viajero)
    (slot ciudad)
    (slot alojamiento)
    (slot precio)
    (slot estrellas)
    (slot distancia)
)

(deftemplate candidato-visita
    (slot viajero)
    (slot ciudad)
    (slot visita)
    (slot precio)
    (slot puntuacion)
)

(deftemplate candidato-transporte
    (slot viajero)
    (slot origen)
    (slot destino)
    (slot transporte)
    (slot precio)
    (slot comodidad)
)

(deftemplate candidato-transporte-local
    (slot ciudad)
    (slot transporte)
    (slot precio-dia)
)

(deftemplate plan-candidato
    (slot viajero)
    (slot plan)
    (slot precio)
    (slot puntuacion)
    (slot valido)
    (slot motivo)
    (slot ciudad1)
    (slot ciudad2)
    (slot ciudad3)
)

(deftemplate recomendacion-final
    (slot viajero)
    (slot orden)
    (slot plan)
    (slot precio)
    (slot puntuacion)
    (slot ciudad1)
    (slot ciudad2)
    (slot ciudad3)
)

;;;;
;; Funciones auxiliares
;;;;

(deffunction bool-true (?x)
    (or (eq ?x TRUE) (eq ?x true) (eq ?x "true"))
)

(deffunction bool-false (?x)
    (or (eq ?x FALSE) (eq ?x false) (eq ?x "false"))
)

(deffunction ciudad-apta-por-objetivo
    (?objetivo ?nivelCultural ?nivelDescanso ?nivelDiversion ?nivelRomantico ?aptaNinos)
    (bind ?cumple FALSE)

    (if (eq ?objetivo "cultural") then
        (if (>= ?nivelCultural 3) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "descanso") then
        (if (>= ?nivelDescanso 3) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "diversion") then
        (if (>= ?nivelDiversion 3) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "romantico") then
        (if (>= ?nivelRomantico 3) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "familiar") then
        (if (bool-true ?aptaNinos) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "naturaleza") then
        (if (>= ?nivelDescanso 3) then (bind ?cumple TRUE)))

    ?cumple
)

(deffunction puntuacion-ciudad
    (?objetivo ?prefiereMenosConocido ?preferenciaClima ?clima
     ?nivelCultural ?nivelDescanso ?nivelDiversion ?nivelRomantico ?popularidad)

    (bind ?puntuacion 0)

    (if (eq ?objetivo "cultural") then
        (bind ?puntuacion (+ ?puntuacion ?nivelCultural)))

    (if (eq ?objetivo "descanso") then
        (bind ?puntuacion (+ ?puntuacion ?nivelDescanso)))

    (if (eq ?objetivo "diversion") then
        (bind ?puntuacion (+ ?puntuacion ?nivelDiversion)))

    (if (eq ?objetivo "romantico") then
        (bind ?puntuacion (+ ?puntuacion ?nivelRomantico)))

    (if (eq ?objetivo "familiar") then
        (bind ?puntuacion (+ ?puntuacion 3)))

    (if (eq ?objetivo "naturaleza") then
        (bind ?puntuacion (+ ?puntuacion ?nivelDescanso)))

    (if (bool-true ?prefiereMenosConocido) then
        (if (<= ?popularidad 3) then
            (bind ?puntuacion (+ ?puntuacion 3))
        else
            (if (= ?popularidad 4) then
                (bind ?puntuacion (+ ?puntuacion 1)))))

    (if (neq ?preferenciaClima "indiferente") then
        (if (eq ?preferenciaClima ?clima) then
            (bind ?puntuacion (+ ?puntuacion 2))))

    ?puntuacion
)

(deffunction visita-apta-por-objetivo
    (?objetivo ?nivelCultural ?nivelDescanso ?nivelDiversion ?nivelRomantico)
    (bind ?cumple FALSE)

    (if (eq ?objetivo "cultural") then
        (if (>= ?nivelCultural 3) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "descanso") then
        (if (>= ?nivelDescanso 3) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "diversion") then
        (if (>= ?nivelDiversion 3) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "romantico") then
        (if (>= ?nivelRomantico 3) then (bind ?cumple TRUE)))

    (if (eq ?objetivo "familiar") then
        (if (or (>= ?nivelCultural 3) (>= ?nivelDescanso 3) (>= ?nivelDiversion 3)) then
            (bind ?cumple TRUE)))

    (if (eq ?objetivo "naturaleza") then
        (if (>= ?nivelDescanso 3) then (bind ?cumple TRUE)))

    ?cumple
)

(deffunction puntuacion-visita
    (?objetivo ?nivelCultural ?nivelDescanso ?nivelDiversion ?nivelRomantico)

    (bind ?puntuacion 0)

    (if (eq ?objetivo "cultural") then (bind ?puntuacion ?nivelCultural))
    (if (eq ?objetivo "descanso") then (bind ?puntuacion ?nivelDescanso))
    (if (eq ?objetivo "diversion") then (bind ?puntuacion ?nivelDiversion))
    (if (eq ?objetivo "romantico") then (bind ?puntuacion ?nivelRomantico))
    (if (eq ?objetivo "familiar") then (bind ?puntuacion (+ 1 ?nivelCultural)))
    (if (eq ?objetivo "naturaleza") then (bind ?puntuacion ?nivelDescanso))

    ?puntuacion
)

(deffunction transporte-permitido (?transporte ?prohibido)
    (bind ?permitido TRUE)

    (if (and (eq ?prohibido "avion") (eq (class ?transporte) Avion)) then
        (bind ?permitido FALSE))

    (if (and (eq ?prohibido "tren") (eq (class ?transporte) Tren)) then
        (bind ?permitido FALSE))

    (if (and (eq ?prohibido "bus") (eq (class ?transporte) Bus)) then
        (bind ?permitido FALSE))

    (if (and (eq ?prohibido "barco") (eq (class ?transporte) Barco)) then
        (bind ?permitido FALSE))

    ?permitido
)

(deffunction puntuacion-transporte (?transporte ?preferido ?comodidad)
    (bind ?puntuacion ?comodidad)

    (if (and (eq ?preferido "avion") (eq (class ?transporte) Avion)) then
        (bind ?puntuacion (+ ?puntuacion 2)))

    (if (and (eq ?preferido "tren") (eq (class ?transporte) Tren)) then
        (bind ?puntuacion (+ ?puntuacion 2)))

    (if (and (eq ?preferido "bus") (eq (class ?transporte) Bus)) then
        (bind ?puntuacion (+ ?puntuacion 2)))

    (if (and (eq ?preferido "barco") (eq (class ?transporte) Barco)) then
        (bind ?puntuacion (+ ?puntuacion 2)))

    ?puntuacion
)

(deffunction puntuacion-alojamiento (?distancia ?estrellas ?minEstrellas)
    (bind ?p 0)

    (if (<= ?distancia 1.0) then
        (bind ?p (+ ?p 2))
    else
        (if (<= ?distancia 2.0) then
            (bind ?p (+ ?p 1))))

    (if (> ?estrellas ?minEstrellas) then
        (bind ?p (+ ?p 1)))

    ?p
)

(deffunction ciudades-distintas-2 (?a ?b)
    (neq ?a ?b)
)

(deffunction ciudades-distintas-3 (?a ?b ?c)
    (and (neq ?a ?b) (neq ?a ?c) (neq ?b ?c))
)

(deffunction conjunto-ciudades-igual (?a1 ?a2 ?a3 ?b1 ?b2 ?b3)
    (and
        (or (eq ?a1 ?b1) (eq ?a1 ?b2) (eq ?a1 ?b3))
        (or (eq ?a2 nil) (eq ?a2 ?b1) (eq ?a2 ?b2) (eq ?a2 ?b3))
        (or (eq ?a3 nil) (eq ?a3 ?b1) (eq ?a3 ?b2) (eq ?a3 ?b3))
        (or (eq ?b1 ?a1) (eq ?b1 ?a2) (eq ?b1 ?a3))
        (or (eq ?b2 nil) (eq ?b2 ?a1) (eq ?b2 ?a2) (eq ?b2 ?a3))
        (or (eq ?b3 nil) (eq ?b3 ?a1) (eq ?b3 ?a2) (eq ?b3 ?a3))
    )
)

(deffunction ceil-div (?a ?b)
    (integer (+ (/ ?a ?b) 0.999))
)

(deffunction motivo-rechazo
    (?precio ?presupuesto ?duracion ?minDias ?maxDias ?numCiudades ?minCiudades ?maxCiudades)

    (bind ?motivo "restricciones incumplidas")

    (if (> ?precio ?presupuesto) then
        (bind ?motivo "supera presupuesto total"))

    (if (< ?duracion ?minDias) then
        (bind ?motivo "duracion inferior al minimo"))

    (if (> ?duracion ?maxDias) then
        (bind ?motivo "duracion superior al maximo"))

    (if (< ?numCiudades ?minCiudades) then
        (bind ?motivo "numero de ciudades inferior al minimo"))

    (if (> ?numCiudades ?maxCiudades) then
        (bind ?motivo "numero de ciudades superior al maximo"))

    ?motivo
)

(defmodule ABSTRACCION
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule SELECCION_CIUDADES
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule SELECCION_ALOJAMIENTOS
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule SELECCION_VISITAS
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule SELECCION_TRANSPORTES
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule CONSTRUCCION_PLANES
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule REVISION_PLANES
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule EVALUACION_PLANES
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule SELECCION_FINAL
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

(defmodule PRESENTACION
    (import MAIN deftemplate ?ALL)
    (import MAIN deffunction ?ALL)
    (import MAIN defclass ?ALL)
)

;;;;
;; Inicio
;;;;

(defrule MAIN::iniciar-sistema
    (declare (salience 1000))
    =>
    (printout t crlf)
    (printout t "Inicio del sistema experto de recomendacion de viajes." crlf)
    (printout t "Metodo usado: proponer planes, revisar restricciones y ordenar por preferencias." crlf)
    (assert (fase (nombre abstraccion)))
    (focus ABSTRACCION SELECCION_CIUDADES SELECCION_ALOJAMIENTOS SELECCION_VISITAS SELECCION_TRANSPORTES CONSTRUCCION_PLANES REVISION_PLANES EVALUACION_PLANES SELECCION_FINAL PRESENTACION)
)

;;;;
;; Fase 1: abstraccion y perfilado
;;;;

(defrule ABSTRACCION::deducir-perfil-familiar
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (tieneNinos ?ninos)
        (tipoGrupo ?grupo)
    )
    (test (or (bool-true ?ninos) (eq ?grupo "familia")))
    (not (perfil-deducido (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (perfil PerfilFamiliar)))
    =>
    (assert
        (perfil-deducido
            (viajero (instance-name ?v))
            (perfil PerfilFamiliar)
            (motivo "viaja con ninos o en familia")
        )
    )
)

(defrule ABSTRACCION::deducir-perfil-romantico
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (tipoGrupo ?grupo)
        (eventoEspecial ?evento)
        (objetivoViaje ?objetivo)
    )
    (test (or (eq ?grupo "pareja") (eq ?evento "luna_miel") (eq ?evento "aniversario") (eq ?objetivo "romantico")))
    (not (perfil-deducido (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (perfil PerfilRomantico)))
    =>
    (assert
        (perfil-deducido
            (viajero (instance-name ?v))
            (perfil PerfilRomantico)
            (motivo "pareja, luna de miel, aniversario u objetivo romantico")
        )
    )
)

(defrule ABSTRACCION::deducir-perfil-cultural
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (nivelCulturalViajero ?nivel)
        (objetivoViaje ?objetivo)
    )
    (test (or (>= ?nivel 4) (eq ?objetivo "cultural")))
    (not (perfil-deducido (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (perfil PerfilCultural)))
    =>
    (assert
        (perfil-deducido
            (viajero (instance-name ?v))
            (perfil PerfilCultural)
            (motivo "interes cultural alto u objetivo cultural")
        )
    )
)

(defrule ABSTRACCION::deducir-perfil-joven-diversion
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (edadMedia ?edad)
        (objetivoViaje ?objetivo)
        (tipoGrupo ?grupo)
    )
    (test (and (<= ?edad 30) (or (eq ?objetivo "diversion") (eq ?grupo "amigos"))))
    (not (perfil-deducido (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (perfil PerfilJovenDiversion)))
    =>
    (assert
        (perfil-deducido
            (viajero (instance-name ?v))
            (perfil PerfilJovenDiversion)
            (motivo "edad baja y objetivo de ocio o viaje de amigos")
        )
    )
)

(defrule ABSTRACCION::deducir-perfil-descanso
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (objetivoViaje ?objetivo)
        (tieneMayores ?mayores)
        (nivelMovilidad ?movilidad)
    )
    (test (or (eq ?objetivo "descanso") (bool-true ?mayores) (eq ?movilidad "baja")))
    (not (perfil-deducido (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (perfil PerfilDescanso)))
    =>
    (assert
        (perfil-deducido
            (viajero (instance-name ?v))
            (perfil PerfilDescanso)
            (motivo "objetivo descanso, personas mayores o movilidad baja")
        )
    )
)

(defrule ABSTRACCION::deducir-perfil-grupo-grande
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (numeroPersonas ?n)
        (tipoGrupo ?grupo)
    )
    (test (or (>= ?n 6) (eq ?grupo "grupo_grande")))
    (not (perfil-deducido (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (perfil PerfilGrupoGrande)))
    =>
    (assert
        (perfil-deducido
            (viajero (instance-name ?v))
            (perfil PerfilGrupoGrande)
            (motivo "grupo numeroso")
        )
    )
)

(defrule ABSTRACCION::deducir-preferencia-menos-conocido
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (prefiereMenosConocido ?pref)
    )
    (test (bool-true ?pref))
    (not (preferencia-deducida (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (preferencia PreferenciaMenosConocido)))
    =>
    (assert
        (preferencia-deducida
            (viajero (instance-name ?v))
            (preferencia PreferenciaMenosConocido)
            (motivo "prefiere ciudades o lugares menos conocidos")
        )
    )
)

(defrule ABSTRACCION::deducir-preferencia-transporte-comodo
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (transportePreferido ?t)
        (nivelMovilidad ?movilidad)
    )
    (test (or (eq ?t "tren") (eq ?t "avion") (eq ?movilidad "baja")))
    (not (preferencia-deducida (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (preferencia PreferenciaTransporteComodo)))
    =>
    (assert
        (preferencia-deducida
            (viajero (instance-name ?v))
            (preferencia PreferenciaTransporteComodo)
            (motivo "prefiere transporte comodo o tiene movilidad baja")
        )
    )
)

(defrule ABSTRACCION::deducir-preferencia-alojamiento-centrico
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (nivelMovilidad ?movilidad)
        (objetivoViaje ?objetivo)
    )
    (test (or (eq ?movilidad "baja") (eq ?objetivo "romantico") (eq ?objetivo "cultural")))
    (not (preferencia-deducida (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (preferencia PreferenciaAlojamientoCentrico)))
    =>
    (assert
        (preferencia-deducida
            (viajero (instance-name ?v))
            (preferencia PreferenciaAlojamientoCentrico)
            (motivo "conviene reducir desplazamientos dentro de la ciudad")
        )
    )
)

(defrule ABSTRACCION::deducir-preferencia-ajustar-presupuesto
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (dispuestoReducirDuracion ?rd)
        (dispuestoReducirCalidad ?rc)
    )
    (test (or (bool-true ?rd) (bool-true ?rc)))
    (not (preferencia-deducida (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (preferencia PreferenciaAjustarPresupuesto)))
    =>
    (assert
        (preferencia-deducida
            (viajero (instance-name ?v))
            (preferencia PreferenciaAjustarPresupuesto)
            (motivo "acepta sacrificar duracion o calidad para ajustar presupuesto")
        )
    )
)

(defrule ABSTRACCION::deducir-restricciones-basicas
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero))
    =>
    (if (not (any-factp ((?r restriccion-deducida))
            (and (eq ?r:viajero (instance-name ?v)) (eq ?r:restriccion RestriccionPresupuesto))))
        then
        (assert
            (restriccion-deducida
                (viajero (instance-name ?v))
                (restriccion RestriccionPresupuesto)
                (motivo "todo plan debe respetar presupuesto total")
            )
        )
    )

    (if (not (any-factp ((?r restriccion-deducida))
            (and (eq ?r:viajero (instance-name ?v)) (eq ?r:restriccion RestriccionDuracion))))
        then
        (assert
            (restriccion-deducida
                (viajero (instance-name ?v))
                (restriccion RestriccionDuracion)
                (motivo "todo plan debe respetar duracion y numero de ciudades")
            )
        )
    )

    (if (not (any-factp ((?r restriccion-deducida))
            (and (eq ?r:viajero (instance-name ?v)) (eq ?r:restriccion RestriccionCalidadAlojamiento))))
        then
        (assert
            (restriccion-deducida
                (viajero (instance-name ?v))
                (restriccion RestriccionCalidadAlojamiento)
                (motivo "todo alojamiento debe cumplir calidad minima y maxima")
            )
        )
    )
)

(defrule ABSTRACCION::deducir-restriccion-transporte
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (transporteProhibido ?prohibido)
    )
    (test (neq ?prohibido "ninguno"))
    (not (restriccion-deducida (viajero ?nombre&:(eq ?nombre (instance-name ?v))) (restriccion RestriccionTransporte)))
    =>
    (assert
        (restriccion-deducida
            (viajero (instance-name ?v))
            (restriccion RestriccionTransporte)
            (motivo "hay un medio de transporte prohibido")
        )
    )
)

(defrule ABSTRACCION::deducir-restriccion-accesibilidad
    (fase (nombre abstraccion))
    ?v <- (object (is-a Viajero)
        (tieneMayores ?mayores)
        (nivelMovilidad ?movilidad)
    )
    (test (or (bool-true ?mayores) (eq ?movilidad "baja")))
    (not (restriccion-deducida
        (viajero ?nombre&:(eq ?nombre (instance-name ?v)))
        (restriccion RestriccionAccesibilidad)
    ))
    =>
    (assert
        (restriccion-deducida
            (viajero (instance-name ?v))
            (restriccion RestriccionAccesibilidad)
            (motivo "viaja con personas mayores o movilidad baja; se requiere alojamiento accesible con ascensor")
        )
    )
)

(defrule ABSTRACCION::pasar-a-seleccion-ciudades
    (declare (salience -100))
    ?f <- (fase (nombre abstraccion))
    =>
    (retract ?f)
    (assert (fase (nombre seleccion-ciudades)))
)

;;;;
;; Fase 2: seleccion de ciudades candidatas
;;;;

(defrule SELECCION_CIUDADES::seleccionar-ciudades-candidatas
    (fase (nombre seleccion-ciudades))

    ?viajero <- (object (is-a Viajero)
        (presupuestoDiarioPersona ?presupuesto)
        (objetivoViaje ?objetivo)
        (tieneNinos ?tieneNinos)
        (prefiereMenosConocido ?prefiereMenosConocido)
        (preferenciaClima ?preferenciaClima)
        (ciudadOrigen ?ciudadOrigen)

    )

    ?ciudad <- (object (is-a Ciudad)
        (costeDiario ?coste)
        (aptaNinosCiudad ?aptaNinos)
        (nivelCulturalCiudad ?nivelCultural)
        (nivelDescanso ?nivelDescanso)
        (nivelDiversion ?nivelDiversion)
        (nivelRomantico ?nivelRomantico)
        (popularidad ?popularidad)
        (tipoClima ?clima)
    )

    (test (<= ?coste ?presupuesto))
    (test (ciudad-apta-por-objetivo ?objetivo ?nivelCultural ?nivelDescanso ?nivelDiversion ?nivelRomantico ?aptaNinos))
    (test (not (and (bool-true ?tieneNinos) (bool-false ?aptaNinos))))
    (test (neq (str-cat (instance-name ?ciudad)) ?ciudadOrigen))

    (not
        (candidato-ciudad
            (viajero ?v&:(eq ?v (instance-name ?viajero)))
            (ciudad ?c&:(eq ?c (instance-name ?ciudad)))
        )
    )

    =>
    (bind ?p
        (puntuacion-ciudad
            ?objetivo
            ?prefiereMenosConocido
            ?preferenciaClima
            ?clima
            ?nivelCultural
            ?nivelDescanso
            ?nivelDiversion
            ?nivelRomantico
            ?popularidad
        )
    )

    (assert
        (candidato-ciudad
            (viajero (instance-name ?viajero))
            (ciudad (instance-name ?ciudad))
            (puntuacion ?p)
        )
    )

    (printout t "Ciudad candidata para " (instance-name ?viajero) ": "
        (instance-name ?ciudad) " puntuacion=" ?p crlf)
)

(defrule SELECCION_CIUDADES::pasar-a-seleccion-alojamientos
    (declare (salience -100))
    ?f <- (fase (nombre seleccion-ciudades))
    =>
    (retract ?f)
    (assert (fase (nombre seleccion-alojamientos)))
)

;;;;
;; Fase 3: alojamientos candidatos
;;;;

(defrule SELECCION_ALOJAMIENTOS::seleccionar-alojamientos-candidatos
    (fase (nombre seleccion-alojamientos))

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?ciudad)
    )

    ?viajeroObj <- (object (is-a Viajero)
        (numeroPersonas ?personas)
        (tieneNinos ?tieneNinos)
        (tieneMayores ?tieneMayores)
        (nivelMovilidad ?movilidad)
        (tipoGrupo ?tipoGrupo)
        (minEstrellasAlojamiento ?minEstrellas)
        (maxEstrellasAlojamiento ?maxEstrellas)
    )

    ?alojamiento <- (object (is-a Alojamiento)
        (alojamientoEstaEn ?ciudad)
        (precioNochePersona ?precio)
        (estrellas ?estrellas)
        (capacidadMaxima ?capacidad)
        (aptoFamilias ?aptoFamilias)
        (aptoGrupos ?aptoGrupos)
        (tieneAscensor ?tieneAscensor)
        (distanciaCentro ?distancia)
    )

    (test (eq (instance-name ?viajeroObj) ?viajero))
    (test (>= ?capacidad ?personas))
    (test (>= ?estrellas ?minEstrellas))
    (test (<= ?estrellas ?maxEstrellas))
    (test (not (and (bool-true ?tieneNinos) (bool-false ?aptoFamilias))))
    (test (not (and (eq ?tipoGrupo "grupo_grande") (bool-false ?aptoGrupos))))
    (test (not
        (and
            (or (bool-true ?tieneMayores) (eq ?movilidad "baja"))
            (bool-false ?tieneAscensor)
        )
    ))

    (not
        (candidato-alojamiento
            (viajero ?viajero)
            (ciudad ?ciudad)
            (alojamiento ?a&:(eq ?a (instance-name ?alojamiento)))
        )
    )

    =>
    (assert
        (candidato-alojamiento
            (viajero ?viajero)
            (ciudad ?ciudad)
            (alojamiento (instance-name ?alojamiento))
            (precio ?precio)
            (estrellas ?estrellas)
            (distancia ?distancia)
        )
    )

    (printout t "Alojamiento candidato para " ?viajero " en " ?ciudad ": "
        (instance-name ?alojamiento) crlf)
)

(defrule SELECCION_ALOJAMIENTOS::pasar-a-seleccion-visitas
    (declare (salience -100))
    ?f <- (fase (nombre seleccion-alojamientos))
    =>
    (retract ?f)
    (assert (fase (nombre seleccion-visitas)))
)

;;;;
;; Fase 4: visitas candidatas
;;;;

(defrule SELECCION_VISITAS::seleccionar-visitas-candidatas
    (fase (nombre seleccion-visitas))

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?ciudad)
    )

    ?viajeroObj <- (object (is-a Viajero)
        (objetivoViaje ?objetivo)
        (tieneNinos ?tieneNinos)
        (tieneMayores ?tieneMayores)
    )

    ?visita <- (object (is-a LugarVisita)
        (lugarVisitaEstaEn ?ciudad)
        (precioEntrada ?precio)
        (nivelCulturalLugar ?nivelCultural)
        (nivelDescansoLugar ?nivelDescanso)
        (nivelDiversionLugar ?nivelDiversion)
        (nivelRomanticoLugar ?nivelRomantico)
        (aptoNinosLugar ?aptoNinos)
        (aptoMayoresLugar ?aptoMayores)
    )

    (test (eq (instance-name ?viajeroObj) ?viajero))
    (test (visita-apta-por-objetivo ?objetivo ?nivelCultural ?nivelDescanso ?nivelDiversion ?nivelRomantico))
    (test (not (and (bool-true ?tieneNinos) (bool-false ?aptoNinos))))
    (test (not (and (bool-true ?tieneMayores) (bool-false ?aptoMayores))))

    (not
        (candidato-visita
            (viajero ?viajero)
            (ciudad ?ciudad)
            (visita ?v&:(eq ?v (instance-name ?visita)))
        )
    )

    =>
    (bind ?p
        (puntuacion-visita
            ?objetivo
            ?nivelCultural
            ?nivelDescanso
            ?nivelDiversion
            ?nivelRomantico
        )
    )

    (assert
        (candidato-visita
            (viajero ?viajero)
            (ciudad ?ciudad)
            (visita (instance-name ?visita))
            (precio ?precio)
            (puntuacion ?p)
        )
    )

    (printout t "Visita candidata para " ?viajero " en " ?ciudad ": "
        (instance-name ?visita) " puntuacion=" ?p crlf)
)

(defrule SELECCION_VISITAS::pasar-a-seleccion-transportes
    (declare (salience -100))
    ?f <- (fase (nombre seleccion-visitas))
    =>
    (retract ?f)
    (assert (fase (nombre seleccion-transportes)))
)

;;;;
;; Fase 5: transportes candidatos
;;;;

(defrule SELECCION_TRANSPORTES::seleccionar-transportes-candidatos
    (fase (nombre seleccion-transportes))

    ?viajeroObj <- (object (is-a Viajero)
        (transporteProhibido ?prohibido)
    )

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?origen)
    )

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?destino)
    )

    ?transporte <- (object (is-a TransporteEntreCiudades)
        (origenTransporte ?origen)
        (destinoTransporte ?destino)
        (precioPersona ?precio)
        (nivelComodidad ?comodidad)
    )

    (test (eq (instance-name ?viajeroObj) ?viajero))
    (test (neq ?origen ?destino))
    (test (transporte-permitido ?transporte ?prohibido))

    (not
        (candidato-transporte
            (viajero ?viajero)
            (origen ?origen)
            (destino ?destino)
            (transporte ?t&:(eq ?t (instance-name ?transporte)))
        )
    )

    =>
    (assert
        (candidato-transporte
            (viajero ?viajero)
            (origen ?origen)
            (destino ?destino)
            (transporte (instance-name ?transporte))
            (precio ?precio)
            (comodidad ?comodidad)
        )
    )

    (printout t "Transporte candidato para " ?viajero ": "
        ?origen " -> " ?destino " con " (instance-name ?transporte) crlf)
)

(defrule SELECCION_TRANSPORTES::seleccionar-transportes-locales
    (fase (nombre seleccion-transportes))

    ?tl <- (object (is-a TransporteLocal)
        (precioDia ?precio)
    )

    (not
        (candidato-transporte-local
            (transporte ?t&:(eq ?t (instance-name ?tl)))
        )
    )

    =>
    (assert
        (candidato-transporte-local
            (ciudad nil)
            (transporte (instance-name ?tl))
            (precio-dia ?precio)
        )
    )
)

(defrule SELECCION_TRANSPORTES::pasar-a-construccion-planes
    (declare (salience -100))
    ?f <- (fase (nombre seleccion-transportes))
    =>
    (retract ?f)
    (assert (fase (nombre construccion-planes)))
)

;;;;
;; Fase 6a: construir planes de 1 ciudad
;;;;

(defrule CONSTRUCCION_PLANES::construir-plan-una-ciudad
    (fase (nombre construccion-planes))

    ?viajeroObj <- (object (is-a Viajero)
        (minDiasViaje ?minDiasViaje)
        (maxDiasViaje ?maxDiasViaje)
        (minCiudades ?minCiudades)
        (maxCiudades ?maxCiudades)
        (minDiasPorCiudad ?minDiasPorCiudad)
        (maxDiasPorCiudad ?maxDiasPorCiudad)
        (presupuestoTotal ?presupuestoTotal)
        (minEstrellasAlojamiento ?minEstrellas)
    )

    (test (<= ?minCiudades 1))
    (test (>= ?maxCiudades 1))

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?ciudad)
        (puntuacion ?pCiudad)
    )

    ?ciudadObj <- (object (is-a Ciudad)
        (costeDiario ?costeDiario)
    )

    (test (eq (instance-name ?viajeroObj) ?viajero))
    (test (eq (instance-name ?ciudadObj) ?ciudad))

    (candidato-alojamiento
        (viajero ?viajero)
        (ciudad ?ciudad)
        (alojamiento ?alojamiento)
        (precio ?precioAlojamiento)
        (estrellas ?estrellas)
        (distancia ?distancia)
    )

    (candidato-visita
        (viajero ?viajero)
        (ciudad ?ciudad)
        (visita ?visita)
        (precio ?precioVisita)
        (puntuacion ?pVisita)
    )

    =>
    (bind ?dias ?minDiasPorCiudad)

    (if (< ?dias ?minDiasViaje) then
        (bind ?dias ?minDiasViaje))

    (if (> ?dias ?maxDiasPorCiudad) then
        (bind ?dias ?maxDiasPorCiudad))

    (bind ?precioTotal
        (+ (* ?dias ?costeDiario)
           (* ?dias ?precioAlojamiento)
           ?precioVisita)
    )

    ; Poda temprana: evita crear instancias que ya incumplen restricciones globales.
    (if (or (< ?dias ?minDiasViaje)
            (> ?dias ?maxDiasViaje)
            (> ?precioTotal ?presupuestoTotal)) then
        (printout t "Plan de 1 ciudad podado para " ?viajero
            ": " ?ciudad " precio=" ?precioTotal " dias=" ?dias crlf)
        (return)
    )

    (bind ?nombreParada (gensym*))
    (bind ?nombrePlan (gensym*))

    (bind ?parada
        (make-instance ?nombreParada of ParadaDelViaje
            (enCiudad ?ciudad)
            (usaAlojamiento ?alojamiento)
            (incluyeLugarVisita ?visita)
            (orden 1)
            (diasEnCiudad ?dias)
            (costeAlojamiento (* ?dias ?precioAlojamiento))
            (costeVisitas ?precioVisita)
            (costeTransporteLocal 0.0)
        )
    )

    (bind ?plan
        (make-instance ?nombrePlan of PlanDeViaje
            (recomendadoPara ?viajero)
            (incluyeParada ?parada)
            (duracionTotalDias ?dias)
            (precioTotalPersona ?precioTotal)
            (numeroCiudades 1)
            (puntuacionPreferencias 0.0)
            (esValido "pendiente")
        )
    )

    (bind ?pAlojamiento (puntuacion-alojamiento ?distancia ?estrellas ?minEstrellas))

    (assert
        (plan-candidato
            (viajero ?viajero)
            (plan ?plan)
            (precio ?precioTotal)
            (puntuacion (+ ?pCiudad ?pVisita ?pAlojamiento))
            (valido "pendiente")
            (motivo "pendiente")
            (ciudad1 ?ciudad)
            (ciudad2 nil)
            (ciudad3 nil)
        )
    )

    (printout t "Plan de 1 ciudad construido para " ?viajero
        ": " ?ciudad " precio=" ?precioTotal crlf)
)

;;;;
;; Fase 6b: construir planes de 2 ciudades
;;;;

(defrule CONSTRUCCION_PLANES::construir-plan-dos-ciudades
    (fase (nombre construccion-planes))

    ?viajeroObj <- (object (is-a Viajero)
        (minDiasViaje ?minDiasViaje)
        (maxDiasViaje ?maxDiasViaje)
        (minCiudades ?minCiudades)
        (maxCiudades ?maxCiudades)
        (minDiasPorCiudad ?minDiasPorCiudad)
        (maxDiasPorCiudad ?maxDiasPorCiudad)
        (presupuestoTotal ?presupuestoTotal)
        (transportePreferido ?preferido)
        (minEstrellasAlojamiento ?minEstrellas)
    )

    (test (<= ?minCiudades 2))
    (test (>= ?maxCiudades 2))

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?ciudad1)
        (puntuacion ?pCiudad1)
    )

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?ciudad2)
        (puntuacion ?pCiudad2)
    )

    (test (eq (instance-name ?viajeroObj) ?viajero))
    (test (ciudades-distintas-2 ?ciudad1 ?ciudad2))

    ?ciudadObj1 <- (object (is-a Ciudad)
        (costeDiario ?costeDiario1)
    )

    ?ciudadObj2 <- (object (is-a Ciudad)
        (costeDiario ?costeDiario2)
    )

    (test (eq (instance-name ?ciudadObj1) ?ciudad1))
    (test (eq (instance-name ?ciudadObj2) ?ciudad2))

    (candidato-transporte
        (viajero ?viajero)
        (origen ?ciudad1)
        (destino ?ciudad2)
        (transporte ?transporte)
        (precio ?precioTransporte)
        (comodidad ?comodidad)
    )

    ?transporteObj <- (object (is-a TransporteEntreCiudades))
    (test (eq (instance-name ?transporteObj) ?transporte))

    (candidato-alojamiento
        (viajero ?viajero)
        (ciudad ?ciudad1)
        (alojamiento ?alojamiento1)
        (precio ?precioAlojamiento1)
        (estrellas ?estrellas1)
        (distancia ?distancia1)
    )

    (candidato-alojamiento
        (viajero ?viajero)
        (ciudad ?ciudad2)
        (alojamiento ?alojamiento2)
        (precio ?precioAlojamiento2)
        (estrellas ?estrellas2)
        (distancia ?distancia2)
    )

    (candidato-visita
        (viajero ?viajero)
        (ciudad ?ciudad1)
        (visita ?visita1)
        (precio ?precioVisita1)
        (puntuacion ?pVisita1)
    )

    (candidato-visita
        (viajero ?viajero)
        (ciudad ?ciudad2)
        (visita ?visita2)
        (precio ?precioVisita2)
        (puntuacion ?pVisita2)
    )

    =>
    (bind ?diasPorCiudad ?minDiasPorCiudad)

    (if (< (* 2 ?diasPorCiudad) ?minDiasViaje) then
        (bind ?diasPorCiudad (ceil-div ?minDiasViaje 2)))

    (if (> ?diasPorCiudad ?maxDiasPorCiudad) then
        (bind ?diasPorCiudad ?maxDiasPorCiudad))

    (bind ?duracion (* 2 ?diasPorCiudad))

    (bind ?precioTotal
        (+ (* ?diasPorCiudad ?costeDiario1)
           (* ?diasPorCiudad ?costeDiario2)
           (* ?diasPorCiudad ?precioAlojamiento1)
           (* ?diasPorCiudad ?precioAlojamiento2)
           ?precioVisita1
           ?precioVisita2
           ?precioTransporte)
    )

    ; Poda temprana: evita crear instancias que ya incumplen restricciones globales.
    (if (or (< ?duracion ?minDiasViaje)
            (> ?duracion ?maxDiasViaje)
            (> ?precioTotal ?presupuestoTotal)) then
        (printout t "Plan de 2 ciudades podado para " ?viajero
            ": " ?ciudad1 " -> " ?ciudad2
            " precio=" ?precioTotal " dias=" ?duracion crlf)
        (return)
    )

    (bind ?nombreParada1 (gensym*))
    (bind ?nombreParada2 (gensym*))
    (bind ?nombrePlan (gensym*))

    (bind ?parada1
        (make-instance ?nombreParada1 of ParadaDelViaje
            (enCiudad ?ciudad1)
            (usaAlojamiento ?alojamiento1)
            (incluyeLugarVisita ?visita1)
            (orden 1)
            (diasEnCiudad ?diasPorCiudad)
            (costeAlojamiento (* ?diasPorCiudad ?precioAlojamiento1))
            (costeVisitas ?precioVisita1)
            (costeTransporteLocal 0.0)
        )
    )

    (bind ?parada2
        (make-instance ?nombreParada2 of ParadaDelViaje
            (enCiudad ?ciudad2)
            (usaAlojamiento ?alojamiento2)
            (incluyeLugarVisita ?visita2)
            (llegaEn ?transporte)
            (orden 2)
            (diasEnCiudad ?diasPorCiudad)
            (costeAlojamiento (* ?diasPorCiudad ?precioAlojamiento2))
            (costeVisitas ?precioVisita2)
            (costeTransporteLocal 0.0)
        )
    )

    (bind ?plan
        (make-instance ?nombrePlan of PlanDeViaje
            (recomendadoPara ?viajero)
            (incluyeParada ?parada1 ?parada2)
            (duracionTotalDias ?duracion)
            (precioTotalPersona ?precioTotal)
            (numeroCiudades 2)
            (puntuacionPreferencias 0.0)
            (esValido "pendiente")
        )
    )

    (bind ?pTransporte (puntuacion-transporte ?transporteObj ?preferido ?comodidad))
    (bind ?pAloj1 (puntuacion-alojamiento ?distancia1 ?estrellas1 ?minEstrellas))
    (bind ?pAloj2 (puntuacion-alojamiento ?distancia2 ?estrellas2 ?minEstrellas))

    (assert
        (plan-candidato
            (viajero ?viajero)
            (plan ?plan)
            (precio ?precioTotal)
            (puntuacion (+ ?pCiudad1 ?pCiudad2 ?pVisita1 ?pVisita2 ?pTransporte ?pAloj1 ?pAloj2))
            (valido "pendiente")
            (motivo "pendiente")
            (ciudad1 ?ciudad1)
            (ciudad2 ?ciudad2)
            (ciudad3 nil)
        )
    )

    (printout t "Plan de 2 ciudades construido para " ?viajero
        ": " ?ciudad1 " -> " ?ciudad2 " precio=" ?precioTotal crlf)
)

;;;;
;; Fase 6c: construir planes de 3 ciudades
;;;;

(defrule CONSTRUCCION_PLANES::construir-plan-tres-ciudades
    (fase (nombre construccion-planes))

    ?viajeroObj <- (object (is-a Viajero)
        (minDiasViaje ?minDiasViaje)
        (maxDiasViaje ?maxDiasViaje)
        (minCiudades ?minCiudades)
        (maxCiudades ?maxCiudades)
        (minDiasPorCiudad ?minDiasPorCiudad)
        (maxDiasPorCiudad ?maxDiasPorCiudad)
        (presupuestoTotal ?presupuestoTotal)
        (transportePreferido ?preferido)
        (minEstrellasAlojamiento ?minEstrellas)
    )

    (test (<= ?minCiudades 3))
    (test (>= ?maxCiudades 3))

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?ciudad1)
        (puntuacion ?pCiudad1)
    )

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?ciudad2)
        (puntuacion ?pCiudad2)
    )

    (candidato-ciudad
        (viajero ?viajero)
        (ciudad ?ciudad3)
        (puntuacion ?pCiudad3)
    )

    (test (eq (instance-name ?viajeroObj) ?viajero))
    (test (ciudades-distintas-3 ?ciudad1 ?ciudad2 ?ciudad3))

    ?ciudadObj1 <- (object (is-a Ciudad)
        (costeDiario ?costeDiario1)
    )

    ?ciudadObj2 <- (object (is-a Ciudad)
        (costeDiario ?costeDiario2)
    )

    ?ciudadObj3 <- (object (is-a Ciudad)
        (costeDiario ?costeDiario3)
    )

    (test (eq (instance-name ?ciudadObj1) ?ciudad1))
    (test (eq (instance-name ?ciudadObj2) ?ciudad2))
    (test (eq (instance-name ?ciudadObj3) ?ciudad3))

    (candidato-transporte
        (viajero ?viajero)
        (origen ?ciudad1)
        (destino ?ciudad2)
        (transporte ?transporte12)
        (precio ?precioTransporte12)
        (comodidad ?comodidad12)
    )

    (candidato-transporte
        (viajero ?viajero)
        (origen ?ciudad2)
        (destino ?ciudad3)
        (transporte ?transporte23)
        (precio ?precioTransporte23)
        (comodidad ?comodidad23)
    )

    ?transporteObj12 <- (object (is-a TransporteEntreCiudades))
    ?transporteObj23 <- (object (is-a TransporteEntreCiudades))
    (test (eq (instance-name ?transporteObj12) ?transporte12))
    (test (eq (instance-name ?transporteObj23) ?transporte23))

    (candidato-alojamiento
        (viajero ?viajero)
        (ciudad ?ciudad1)
        (alojamiento ?alojamiento1)
        (precio ?precioAlojamiento1)
        (estrellas ?estrellas1)
        (distancia ?distancia1)
    )

    (candidato-alojamiento
        (viajero ?viajero)
        (ciudad ?ciudad2)
        (alojamiento ?alojamiento2)
        (precio ?precioAlojamiento2)
        (estrellas ?estrellas2)
        (distancia ?distancia2)
    )

    (candidato-alojamiento
        (viajero ?viajero)
        (ciudad ?ciudad3)
        (alojamiento ?alojamiento3)
        (precio ?precioAlojamiento3)
        (estrellas ?estrellas3)
        (distancia ?distancia3)
    )

    (candidato-visita
        (viajero ?viajero)
        (ciudad ?ciudad1)
        (visita ?visita1)
        (precio ?precioVisita1)
        (puntuacion ?pVisita1)
    )

    (candidato-visita
        (viajero ?viajero)
        (ciudad ?ciudad2)
        (visita ?visita2)
        (precio ?precioVisita2)
        (puntuacion ?pVisita2)
    )

    (candidato-visita
        (viajero ?viajero)
        (ciudad ?ciudad3)
        (visita ?visita3)
        (precio ?precioVisita3)
        (puntuacion ?pVisita3)
    )

    =>
    (bind ?diasPorCiudad ?minDiasPorCiudad)

    (if (< (* 3 ?diasPorCiudad) ?minDiasViaje) then
        (bind ?diasPorCiudad (ceil-div ?minDiasViaje 3)))

    (if (> ?diasPorCiudad ?maxDiasPorCiudad) then
        (bind ?diasPorCiudad ?maxDiasPorCiudad))

    (bind ?duracion (* 3 ?diasPorCiudad))

    (bind ?precioTotal
        (+ (* ?diasPorCiudad ?costeDiario1)
           (* ?diasPorCiudad ?costeDiario2)
           (* ?diasPorCiudad ?costeDiario3)
           (* ?diasPorCiudad ?precioAlojamiento1)
           (* ?diasPorCiudad ?precioAlojamiento2)
           (* ?diasPorCiudad ?precioAlojamiento3)
           ?precioVisita1
           ?precioVisita2
           ?precioVisita3
           ?precioTransporte12
           ?precioTransporte23)
    )

    ; Poda temprana: evita crear instancias que ya incumplen restricciones globales.
    (if (or (< ?duracion ?minDiasViaje)
            (> ?duracion ?maxDiasViaje)
            (> ?precioTotal ?presupuestoTotal)) then
        (printout t "Plan de 3 ciudades podado para " ?viajero
            ": " ?ciudad1 " -> " ?ciudad2 " -> " ?ciudad3
            " precio=" ?precioTotal " dias=" ?duracion crlf)
        (return)
    )

    (bind ?nombreParada1 (gensym*))
    (bind ?nombreParada2 (gensym*))
    (bind ?nombreParada3 (gensym*))
    (bind ?nombrePlan (gensym*))

    (bind ?parada1
        (make-instance ?nombreParada1 of ParadaDelViaje
            (enCiudad ?ciudad1)
            (usaAlojamiento ?alojamiento1)
            (incluyeLugarVisita ?visita1)
            (orden 1)
            (diasEnCiudad ?diasPorCiudad)
            (costeAlojamiento (* ?diasPorCiudad ?precioAlojamiento1))
            (costeVisitas ?precioVisita1)
            (costeTransporteLocal 0.0)
        )
    )

    (bind ?parada2
        (make-instance ?nombreParada2 of ParadaDelViaje
            (enCiudad ?ciudad2)
            (usaAlojamiento ?alojamiento2)
            (incluyeLugarVisita ?visita2)
            (llegaEn ?transporte12)
            (orden 2)
            (diasEnCiudad ?diasPorCiudad)
            (costeAlojamiento (* ?diasPorCiudad ?precioAlojamiento2))
            (costeVisitas ?precioVisita2)
            (costeTransporteLocal 0.0)
        )
    )

    (bind ?parada3
        (make-instance ?nombreParada3 of ParadaDelViaje
            (enCiudad ?ciudad3)
            (usaAlojamiento ?alojamiento3)
            (incluyeLugarVisita ?visita3)
            (llegaEn ?transporte23)
            (orden 3)
            (diasEnCiudad ?diasPorCiudad)
            (costeAlojamiento (* ?diasPorCiudad ?precioAlojamiento3))
            (costeVisitas ?precioVisita3)
            (costeTransporteLocal 0.0)
        )
    )

    (bind ?plan
        (make-instance ?nombrePlan of PlanDeViaje
            (recomendadoPara ?viajero)
            (incluyeParada ?parada1 ?parada2 ?parada3)
            (duracionTotalDias ?duracion)
            (precioTotalPersona ?precioTotal)
            (numeroCiudades 3)
            (puntuacionPreferencias 0.0)
            (esValido "pendiente")
        )
    )

    (bind ?pTransporte12 (puntuacion-transporte ?transporteObj12 ?preferido ?comodidad12))
    (bind ?pTransporte23 (puntuacion-transporte ?transporteObj23 ?preferido ?comodidad23))
    (bind ?pAloj1 (puntuacion-alojamiento ?distancia1 ?estrellas1 ?minEstrellas))
    (bind ?pAloj2 (puntuacion-alojamiento ?distancia2 ?estrellas2 ?minEstrellas))
    (bind ?pAloj3 (puntuacion-alojamiento ?distancia3 ?estrellas3 ?minEstrellas))

    (assert
        (plan-candidato
            (viajero ?viajero)
            (plan ?plan)
            (precio ?precioTotal)
            (puntuacion (+ ?pCiudad1 ?pCiudad2 ?pCiudad3
                           ?pVisita1 ?pVisita2 ?pVisita3
                           ?pTransporte12 ?pTransporte23
                           ?pAloj1 ?pAloj2 ?pAloj3))
            (valido "pendiente")
            (motivo "pendiente")
            (ciudad1 ?ciudad1)
            (ciudad2 ?ciudad2)
            (ciudad3 ?ciudad3)
        )
    )

    (printout t "Plan de 3 ciudades construido para " ?viajero
        ": " ?ciudad1 " -> " ?ciudad2 " -> " ?ciudad3
        " precio=" ?precioTotal crlf)
)

(defrule CONSTRUCCION_PLANES::pasar-a-revision-planes
    (declare (salience -100))
    ?f <- (fase (nombre construccion-planes))
    =>
    (retract ?f)
    (assert (fase (nombre revision-planes)))
)

;;;;
;; Fase 7: revision de restricciones
;;;;

(defrule REVISION_PLANES::revisar-plan-valido
    (fase (nombre revision-planes))

    ?pc <- (plan-candidato
        (viajero ?viajero)
        (plan ?plan)
        (precio ?precio)
        (puntuacion ?puntuacion)
        (valido "pendiente")
    )

    ?viajeroObj <- (object (is-a Viajero)
        (presupuestoTotal ?presupuestoTotal)
        (minDiasViaje ?minDias)
        (maxDiasViaje ?maxDias)
        (minCiudades ?minCiudades)
        (maxCiudades ?maxCiudades)
    )

    ?planObj <- (object (is-a PlanDeViaje)
        (duracionTotalDias ?duracion)
        (numeroCiudades ?numCiudades)
    )

    (test (eq (instance-name ?viajeroObj) ?viajero))
    (test (eq (instance-name ?planObj) ?plan))
    (test (<= ?precio ?presupuestoTotal))
    (test (>= ?duracion ?minDias))
    (test (<= ?duracion ?maxDias))
    (test (>= ?numCiudades ?minCiudades))
    (test (<= ?numCiudades ?maxCiudades))

    =>
    (send ?plan put-esValido "true")
    (modify ?pc
        (valido "true")
        (motivo "cumple restricciones obligatorias")
    )

    (printout t "Plan valido para " ?viajero ": " ?plan crlf)
)

(defrule REVISION_PLANES::revisar-plan-no-valido
    (fase (nombre revision-planes))

    ?pc <- (plan-candidato
        (viajero ?viajero)
        (plan ?plan)
        (precio ?precio)
        (valido "pendiente")
    )

    ?viajeroObj <- (object (is-a Viajero)
        (presupuestoTotal ?presupuestoTotal)
        (minDiasViaje ?minDias)
        (maxDiasViaje ?maxDias)
        (minCiudades ?minCiudades)
        (maxCiudades ?maxCiudades)
    )

    ?planObj <- (object (is-a PlanDeViaje)
        (duracionTotalDias ?duracion)
        (numeroCiudades ?numCiudades)
    )

    (test (eq (instance-name ?viajeroObj) ?viajero))
    (test (eq (instance-name ?planObj) ?plan))

    (test
        (or
            (> ?precio ?presupuestoTotal)
            (< ?duracion ?minDias)
            (> ?duracion ?maxDias)
            (< ?numCiudades ?minCiudades)
            (> ?numCiudades ?maxCiudades)
        )
    )

    =>
    (bind ?motivo
        (motivo-rechazo
            ?precio ?presupuestoTotal
            ?duracion ?minDias ?maxDias
            ?numCiudades ?minCiudades ?maxCiudades
        )
    )

    (send ?plan put-esValido "false")
    (send ?plan put-motivoRechazo ?motivo)

    (modify ?pc
        (valido "false")
        (motivo ?motivo)
    )

    (printout t "Plan no valido para " ?viajero ": " ?plan
        " motivo=" ?motivo crlf)
)

(defrule REVISION_PLANES::pasar-a-evaluacion-planes
    (declare (salience -100))
    ?f <- (fase (nombre revision-planes))
    =>
    (retract ?f)
    (assert (fase (nombre evaluacion-planes)))
)

;;;;
;; Fase 8: evaluacion de preferencias
;;;;

(defrule EVALUACION_PLANES::evaluar-plan-valido
    (fase (nombre evaluacion-planes))

    (plan-candidato
        (viajero ?viajero)
        (plan ?plan)
        (puntuacion ?puntuacion)
        (valido "true")
    )

    =>
    (send ?plan put-puntuacionPreferencias ?puntuacion)

    (printout t "Plan evaluado para " ?viajero ": "
        ?plan " puntuacion=" ?puntuacion crlf)
)

(defrule EVALUACION_PLANES::pasar-a-seleccion-final
    (declare (salience -100))
    ?f <- (fase (nombre evaluacion-planes))
    =>
    (retract ?f)
    (assert (fase (nombre seleccion-final)))
)

;;;;
;; Fase 9: seleccion de dos mejores recomendaciones
;; La segunda debe visitar ciudades diferentes respecto a la primera.
;;;;

(defrule SELECCION_FINAL::seleccionar-mejor-plan-1
    (fase (nombre seleccion-final))

    (plan-candidato
        (viajero ?viajero)
        (plan ?plan)
        (precio ?precio)
        (puntuacion ?puntuacion)
        (valido "true")
        (ciudad1 ?ciudad1)
        (ciudad2 ?ciudad2)
        (ciudad3 ?ciudad3)
    )

    (not
        (and
            (plan-candidato
                (viajero ?viajero)
                (plan ?otroPlan&~?plan)
                (precio ?otroPrecio)
                (puntuacion ?otraPuntuacion)
                (valido "true")
            )
            (test
                (or
                    (> ?otraPuntuacion ?puntuacion)
                    (and (= ?otraPuntuacion ?puntuacion) (< ?otroPrecio ?precio))
                )
            )
        )
    )

    (not
        (recomendacion-final
            (viajero ?viajero)
            (orden 1)
        )
    )

    =>
    (assert
        (recomendacion-final
            (viajero ?viajero)
            (orden 1)
            (plan ?plan)
            (precio ?precio)
            (puntuacion ?puntuacion)
            (ciudad1 ?ciudad1)
            (ciudad2 ?ciudad2)
            (ciudad3 ?ciudad3)
        )
    )
)

(defrule SELECCION_FINAL::seleccionar-mejor-plan-2
    (fase (nombre seleccion-final))

    (recomendacion-final
        (viajero ?viajero)
        (orden 1)
        (plan ?plan1)
        (ciudad1 ?c1a)
        (ciudad2 ?c1b)
        (ciudad3 ?c1c)
    )

    (plan-candidato
        (viajero ?viajero)
        (plan ?plan)
        (precio ?precio)
        (puntuacion ?puntuacion)
        (valido "true")
        (ciudad1 ?ciudad1)
        (ciudad2 ?ciudad2)
        (ciudad3 ?ciudad3)
    )

    (test (neq ?plan ?plan1))
    (test (not (conjunto-ciudades-igual ?ciudad1 ?ciudad2 ?ciudad3 ?c1a ?c1b ?c1c)))

    (not
        (and
            (plan-candidato
                (viajero ?viajero)
                (plan ?otroPlan&~?plan)
                (precio ?otroPrecio)
                (puntuacion ?otraPuntuacion)
                (valido "true")
                (ciudad1 ?otraCiudad1)
                (ciudad2 ?otraCiudad2)
                (ciudad3 ?otraCiudad3)
            )
            (test (neq ?otroPlan ?plan1))
            (test (not (conjunto-ciudades-igual ?otraCiudad1 ?otraCiudad2 ?otraCiudad3 ?c1a ?c1b ?c1c)))
            (test
                (or
                    (> ?otraPuntuacion ?puntuacion)
                    (and (= ?otraPuntuacion ?puntuacion) (< ?otroPrecio ?precio))
                )
            )
        )
    )

    (not
        (recomendacion-final
            (viajero ?viajero)
            (orden 2)
        )
    )

    =>
    (assert
        (recomendacion-final
            (viajero ?viajero)
            (orden 2)
            (plan ?plan)
            (precio ?precio)
            (puntuacion ?puntuacion)
            (ciudad1 ?ciudad1)
            (ciudad2 ?ciudad2)
            (ciudad3 ?ciudad3)
        )
    )
)

(defrule SELECCION_FINAL::pasar-a-presentacion
    (declare (salience -100))
    ?f <- (fase (nombre seleccion-final))
    =>
    (retract ?f)
    (assert (fase (nombre presentacion)))
)

;;;;
;; Fase 10: presentacion final
;;;;

(defrule PRESENTACION::presentar-recomendaciones-finales
    (fase (nombre presentacion))

    (recomendacion-final
        (viajero ?viajero)
        (orden ?orden)
        (plan ?plan)
        (precio ?precio)
        (puntuacion ?puntuacion)
        (ciudad1 ?ciudad1)
        (ciudad2 ?ciudad2)
        (ciudad3 ?ciudad3)
    )

    (not (recomendacion-presentada ?viajero ?orden))

    (or
        (test (= ?orden 1))
        (recomendacion-presentada ?viajero 1)
    )

    ?planObj <- (object (is-a PlanDeViaje)
        (duracionTotalDias ?duracion)
        (numeroCiudades ?numCiudades)
    )

    (test (eq (instance-name ?planObj) ?plan))

    =>
    (printout t crlf)
    (printout t "===============================" crlf)
    (printout t "Recomendacion " ?orden " para " ?viajero crlf)
    (printout t "===============================" crlf)
    (printout t "Plan: " ?plan crlf)
    (printout t "Precio total estimado por persona: " ?precio " euros" crlf)
    (printout t "Duracion total: " ?duracion " dias" crlf)
    (printout t "Numero de ciudades: " ?numCiudades crlf)

    (if (eq ?ciudad2 nil) then
        (printout t "Ciudades: " ?ciudad1 crlf)
    else
        (if (eq ?ciudad3 nil) then
            (printout t "Ciudades: " ?ciudad1 " -> " ?ciudad2 crlf)
        else
            (printout t "Ciudades: " ?ciudad1 " -> " ?ciudad2 " -> " ?ciudad3 crlf)
        )
    )

    (printout t "Puntuacion por preferencias: " ?puntuacion crlf)

    (printout t "Preferencias consideradas en la puntuacion:" crlf)
    (do-for-all-facts
        ((?p preferencia-deducida))
        (eq ?p:viajero ?viajero)
        (printout t " - " ?p:preferencia ": " ?p:motivo crlf)
    )

    (printout t "Restricciones revisadas:" crlf)
    (do-for-all-facts
        ((?r restriccion-deducida))
        (eq ?r:viajero ?viajero)
        (printout t " - " ?r:restriccion ": " ?r:motivo crlf)
    )

    (printout t "Motivo de seleccion: cumple restricciones obligatorias y queda entre las mejores alternativas por puntuacion." crlf)

    (assert (recomendacion-presentada ?viajero ?orden))
)

(defrule PRESENTACION::presentar-sin-solucion
    (fase (nombre presentacion))

    ?viajeroObj <- (object (is-a Viajero))

    (not
        (recomendacion-final
            (viajero ?nombreViajero&:(eq ?nombreViajero (instance-name ?viajeroObj)))
        )
    )

    =>
    (printout t crlf)
    (printout t "No se ha podido generar una propuesta valida para "
        (instance-name ?viajeroObj) "." crlf)
    (printout t "Causa general: las restricciones del usuario no son compatibles con las ciudades, alojamientos, transportes o presupuesto disponibles." crlf)
)

(defrule PRESENTACION::presentar-solo-una-recomendacion
    (fase (nombre presentacion))

    ?viajeroObj <- (object (is-a Viajero))

    (recomendacion-final
        (viajero ?nombreViajero&:(eq ?nombreViajero (instance-name ?viajeroObj)))
        (orden 1)
    )

    (not
        (recomendacion-final
            (viajero ?nombreViajero2&:(eq ?nombreViajero2 (instance-name ?viajeroObj)))
            (orden 2)
        )
    )

    =>
    (printout t crlf)
    (printout t "Aviso: solo se ha encontrado una recomendacion valida con ciudades diferentes para "
        (instance-name ?viajeroObj) "." crlf)
)

(defrule PRESENTACION::finalizar-sistema
    (declare (salience -100))
    ?f <- (fase (nombre presentacion))
    =>
    (retract ?f)
    (printout t crlf)
    (printout t "Fin del sistema experto de recomendacion de viajes." crlf)
)