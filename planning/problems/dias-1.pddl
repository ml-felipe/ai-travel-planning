(define (problem dias-1)
  (:domain agencia-viajes-web)

  (:objects
    madrid paris roma berlin - ciudad
    h-madrid h-paris h-roma h-berlin - hotel
    e1 e2 e3 e4 - estancia
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

    (vuelo madrid paris)
    (vuelo paris roma)
    (vuelo roma berlin)
    (vuelo madrid roma)
    (vuelo paris berlin)

    (= (duracion e1) 1)
    (= (duracion e2) 2)
    (= (duracion e3) 3)
    (= (duracion e4) 4)

    (= (min-ciudades) 3)
    (= (min-dias-ciudad) 2)
    (= (max-dias-ciudad) 4)
    (= (min-dias-total) 9)
    (= (min-coste-total) 0)
    (= (max-coste-total) 9999)

    (= (interes madrid) 1)
    (= (interes paris) 1)
    (= (interes roma) 1)
    (= (interes berlin) 1)

    (= (precio-hotel-dia h-madrid) 20)
    (= (precio-hotel-dia h-paris) 20)
    (= (precio-hotel-dia h-roma) 20)
    (= (precio-hotel-dia h-berlin) 20)

    (= (precio-vuelo madrid paris) 10)
    (= (precio-vuelo paris roma) 10)
    (= (precio-vuelo roma berlin) 10)
    (= (precio-vuelo madrid roma) 20)
    (= (precio-vuelo paris berlin) 20)

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
