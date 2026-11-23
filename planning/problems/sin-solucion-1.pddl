(define (problem sin-solucion-1)
  (:domain agencia-viajes-web)

  (:objects
    madrid paris roma berlin - ciudad
    h-madrid h-paris h-roma h-berlin - hotel
    e1 e2 - estancia
  )

  (:init
    (inicio-disponible)

    (no-visitada madrid)
    (no-visitada paris)
    (no-visitada roma)
    (no-visitada berlin)

    (hotel-en h-madrid madrid)
    (hotel-en h-paris paris)
    (hotel-en h-roma roma)
    (hotel-en h-berlin berlin)

    ;; Berlin queda aislada: no hay forma de visitar 4 ciudades.
    (vuelo madrid paris)
    (vuelo paris roma)

    (= (duracion e1) 1)
    (= (duracion e2) 2)

    (= (min-ciudades) 4)
    (= (min-dias-ciudad) 1)
    (= (max-dias-ciudad) 2)
    (= (min-dias-total) 4)
    (= (min-coste-total) 0)
    (= (max-coste-total) 9999)

    (= (interes madrid) 1)
    (= (interes paris) 1)
    (= (interes roma) 1)
    (= (interes berlin) 1)

    (= (precio-hotel-dia h-madrid) 10)
    (= (precio-hotel-dia h-paris) 10)
    (= (precio-hotel-dia h-roma) 10)
    (= (precio-hotel-dia h-berlin) 10)

    (= (precio-vuelo madrid paris) 10)
    (= (precio-vuelo paris roma) 10)

    (= (num-visitadas) 0)
    (= (dias-totales) 0)
    (= (coste-total) 0)
    (= (interes-total) 0)
  )

  (:goal
    (viaje-finalizado)
  )

  (:metric minimize
    (coste-total)
  )
)
