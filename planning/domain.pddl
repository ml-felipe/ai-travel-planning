(define (domain agencia-viajes-web)
  (:requirements :typing :strips :fluents)

  (:types
    ciudad hotel estancia - object
  )

  (:predicates
    ;; Datos estaticos de la instancia
    (vuelo ?origen - ciudad ?destino - ciudad)
    (hotel-en ?h - hotel ?c - ciudad)

    ;; Estado dinamico del viaje
    (inicio-disponible)
    (viaje-activo)
    (viaje-finalizado)

    (en-ciudad ?c - ciudad)
    (pendiente-alojamiento ?c - ciudad)
    (ciudad-cerrada ?c - ciudad)

    (visitada ?c - ciudad)
    (no-visitada ?c - ciudad)
    (alojado ?h - hotel)
  )

  (:functions
    ;; Valores de configuracion
    (duracion ?e - estancia)
    (min-ciudades)
    (min-dias-ciudad)
    (max-dias-ciudad)
    (min-dias-total)
    (min-coste-total)
    (max-coste-total)

    ;; Atributos de ciudades, vuelos y hoteles
    (interes ?c - ciudad)
    (precio-vuelo ?origen - ciudad ?destino - ciudad)
    (precio-hotel-dia ?h - hotel)

    ;; Acumuladores del plan
    (num-visitadas)
    (dias-totales)
    (coste-total)
    (interes-total)
  )

  (:action iniciar-viaje
    :parameters (?c - ciudad)
    :precondition (and
      (inicio-disponible)
      (no-visitada ?c)
    )
    :effect (and
      (not (inicio-disponible))
      (viaje-activo)
      (en-ciudad ?c)
      (pendiente-alojamiento ?c)
    )
  )

  (:action alojarse
    :parameters (?c - ciudad ?h - hotel ?e - estancia)
    :precondition (and
      (viaje-activo)
      (en-ciudad ?c)
      (pendiente-alojamiento ?c)
      (no-visitada ?c)
      (hotel-en ?h ?c)
      (>= (duracion ?e) (min-dias-ciudad))
      (<= (duracion ?e) (max-dias-ciudad))
    )
    :effect (and
      (not (pendiente-alojamiento ?c))
      (ciudad-cerrada ?c)
      (visitada ?c)
      (not (no-visitada ?c))
      (alojado ?h)

      (increase (num-visitadas) 1)
      (increase (dias-totales) (duracion ?e))
      (increase (interes-total) (interes ?c))
      (increase (coste-total) (* (precio-hotel-dia ?h) (duracion ?e)))
    )
  )

  (:action viajar
    :parameters (?origen - ciudad ?destino - ciudad)
    :precondition (and
      (viaje-activo)
      (en-ciudad ?origen)
      (ciudad-cerrada ?origen)
      (vuelo ?origen ?destino)
      (no-visitada ?destino)
    )
    :effect (and
      (not (en-ciudad ?origen))
      (en-ciudad ?destino)
      (pendiente-alojamiento ?destino)
      (increase (coste-total) (precio-vuelo ?origen ?destino))
    )
  )

  (:action finalizar-viaje
    :parameters (?c - ciudad)
    :precondition (and
      (viaje-activo)
      (en-ciudad ?c)
      (ciudad-cerrada ?c)
      (>= (num-visitadas) (min-ciudades))
      (>= (dias-totales) (min-dias-total))
      (>= (coste-total) (min-coste-total))
      (<= (coste-total) (max-coste-total))
    )
    :effect (and
      (not (viaje-activo))
      (viaje-finalizado)
    )
  )
)