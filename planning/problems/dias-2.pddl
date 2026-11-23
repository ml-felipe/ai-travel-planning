(define (problem dias-2)
  (:domain agencia-viajes-web)

  (:objects
    barcelona lisboa viena praga amsterdam bruselas - ciudad
    h-barcelona h-lisboa h-viena h-praga h-amsterdam h-bruselas - hotel
    e1 e2 e3 e4 e5 - estancia
  )

  (:init
    (inicio-disponible)

    (no-visitada barcelona)
    (no-visitada lisboa)
    (no-visitada viena)
    (no-visitada praga)
    (no-visitada amsterdam)
    (no-visitada bruselas)

    (hotel-en h-barcelona barcelona)
    (hotel-en h-lisboa lisboa)
    (hotel-en h-viena viena)
    (hotel-en h-praga praga)
    (hotel-en h-amsterdam amsterdam)
    (hotel-en h-bruselas bruselas)

    (vuelo barcelona lisboa)
    (vuelo lisboa viena)
    (vuelo viena praga)
    (vuelo praga amsterdam)
    (vuelo amsterdam bruselas)

    (vuelo barcelona viena)
    (vuelo lisboa praga)
    (vuelo viena amsterdam)
    (vuelo praga bruselas)

    (= (duracion e1) 1)
    (= (duracion e2) 2)
    (= (duracion e3) 3)
    (= (duracion e4) 4)
    (= (duracion e5) 5)

    (= (min-ciudades) 4)
    (= (min-dias-ciudad) 2)
    (= (max-dias-ciudad) 5)
    (= (min-dias-total) 14)
    (= (min-coste-total) 0)
    (= (max-coste-total) 9999)

    (= (interes barcelona) 1)
    (= (interes lisboa) 1)
    (= (interes viena) 1)
    (= (interes praga) 1)
    (= (interes amsterdam) 1)
    (= (interes bruselas) 1)

    (= (precio-hotel-dia h-barcelona) 15)
    (= (precio-hotel-dia h-lisboa) 15)
    (= (precio-hotel-dia h-viena) 15)
    (= (precio-hotel-dia h-praga) 15)
    (= (precio-hotel-dia h-amsterdam) 15)
    (= (precio-hotel-dia h-bruselas) 15)

    (= (precio-vuelo barcelona lisboa) 10)
    (= (precio-vuelo lisboa viena) 10)
    (= (precio-vuelo viena praga) 10)
    (= (precio-vuelo praga amsterdam) 10)
    (= (precio-vuelo amsterdam bruselas) 10)

    (= (precio-vuelo barcelona viena) 25)
    (= (precio-vuelo lisboa praga) 25)
    (= (precio-vuelo viena amsterdam) 25)
    (= (precio-vuelo praga bruselas) 25)

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
