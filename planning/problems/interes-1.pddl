(define (problem interes-1)
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
    (= (min-coste-total) 0)
    (= (max-coste-total) 9999)

    (= (interes madrid) 8)
    (= (interes paris) 1)
    (= (interes roma) 1)
    (= (interes berlin) 5)
    (= (interes viena) 1)

    (= (precio-hotel-dia h-madrid) 10)
    (= (precio-hotel-dia h-paris) 10)
    (= (precio-hotel-dia h-roma) 10)
    (= (precio-hotel-dia h-berlin) 10)
    (= (precio-hotel-dia h-viena) 10)

    (= (precio-vuelo madrid paris) 10)
    (= (precio-vuelo paris roma) 10)
    (= (precio-vuelo roma berlin) 10)
    (= (precio-vuelo berlin viena) 10)
    (= (precio-vuelo madrid berlin) 10)
    (= (precio-vuelo paris viena) 10)

    (= (num-visitadas) 0)
    (= (dias-totales) 0)
    (= (coste-total) 0)
    (= (interes-total) 0)
  )

  (:goal
    (viaje-finalizado)
  )

  (:metric minimize
    (interes-total)
  )
)
