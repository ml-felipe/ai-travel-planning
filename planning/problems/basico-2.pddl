(define (problem basico-2)
  (:domain agencia-viajes-web)

  (:objects
    madrid lisboa viena praga amsterdam - ciudad
    h-madrid h-lisboa h-viena h-praga h-amsterdam - hotel
    e1 e2 - estancia
  )

  (:init
    (inicio-disponible)

    (no-visitada madrid)
    (no-visitada lisboa)
    (no-visitada viena)
    (no-visitada praga)
    (no-visitada amsterdam)

    (hotel-en h-madrid madrid)
    (hotel-en h-lisboa lisboa)
    (hotel-en h-viena viena)
    (hotel-en h-praga praga)
    (hotel-en h-amsterdam amsterdam)

    (vuelo madrid lisboa)
    (vuelo lisboa viena)
    (vuelo viena praga)
    (vuelo praga amsterdam)

    (vuelo madrid viena)
    (vuelo lisboa praga)
    (vuelo viena amsterdam)

    (= (duracion e1) 1)
    (= (duracion e2) 2)

    (= (min-ciudades) 4)
    (= (min-dias-ciudad) 1)
    (= (max-dias-ciudad) 2)
    (= (min-dias-total) 1)
    (= (min-coste-total) 0)
    (= (max-coste-total) 9999)

    (= (interes madrid) 1)
    (= (interes lisboa) 1)
    (= (interes viena) 1)
    (= (interes praga) 1)
    (= (interes amsterdam) 1)

    (= (precio-hotel-dia h-madrid) 10)
    (= (precio-hotel-dia h-lisboa) 10)
    (= (precio-hotel-dia h-viena) 10)
    (= (precio-hotel-dia h-praga) 10)
    (= (precio-hotel-dia h-amsterdam) 10)

    (= (precio-vuelo madrid lisboa) 10)
    (= (precio-vuelo lisboa viena) 10)
    (= (precio-vuelo viena praga) 10)
    (= (precio-vuelo praga amsterdam) 10)

    (= (precio-vuelo madrid viena) 25)
    (= (precio-vuelo lisboa praga) 25)
    (= (precio-vuelo viena amsterdam) 25)

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
