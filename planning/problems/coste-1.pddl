(define (problem coste-1)
  (:domain agencia-viajes-web)

  (:objects
    madrid paris roma berlin viena - ciudad
    h-madrid h-paris h-roma h-berlin h-viena - hotel
    e1 e2 e3 - estancia
  )

  (:init
    (inicio-disponible)

    (no-visitada madrid)
    (no-visitada paris)
    (no-visitada roma)
    (no-visitada berlin)
    (no-visitada viena)

    (hotel-en h-madrid madrid)
    (hotel-en h-paris paris)
    (hotel-en h-roma roma)
    (hotel-en h-berlin berlin)
    (hotel-en h-viena viena)

    (vuelo madrid paris)
    (vuelo paris roma)
    (vuelo roma berlin)
    (vuelo berlin viena)
    (vuelo madrid berlin)
    (vuelo paris viena)

    (= (duracion e1) 1)
    (= (duracion e2) 2)
    (= (duracion e3) 3)

    (= (min-ciudades) 3)
    (= (min-dias-ciudad) 1)
    (= (max-dias-ciudad) 3)
    (= (min-dias-total) 3)
    (= (min-coste-total) 100)
    (= (max-coste-total) 300)

    (= (interes madrid) 1)
    (= (interes paris) 1)
    (= (interes roma) 1)
    (= (interes berlin) 1)
    (= (interes viena) 1)

    (= (precio-hotel-dia h-madrid) 80)
    (= (precio-hotel-dia h-paris) 30)
    (= (precio-hotel-dia h-roma) 30)
    (= (precio-hotel-dia h-berlin) 30)
    (= (precio-hotel-dia h-viena) 80)

    (= (precio-vuelo madrid paris) 100)
    (= (precio-vuelo paris roma) 20)
    (= (precio-vuelo roma berlin) 20)
    (= (precio-vuelo berlin viena) 100)
    (= (precio-vuelo madrid berlin) 120)
    (= (precio-vuelo paris viena) 120)

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
