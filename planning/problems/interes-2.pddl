(define (problem interes-2)
  (:domain agencia-viajes-web)

  (:objects
    barcelona lisboa viena praga amsterdam bruselas - ciudad
    h-barcelona h-lisboa h-viena h-praga h-amsterdam h-bruselas - hotel
    e1 e2 - estancia
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
    (vuelo viena amsterdam)
    (vuelo lisboa praga)
    (vuelo praga bruselas)

    (= (duracion e1) 1)
    (= (duracion e2) 2)

    (= (min-ciudades) 4)
    (= (min-dias-ciudad) 1)
    (= (max-dias-ciudad) 2)
    (= (min-dias-total) 4)
    (= (min-coste-total) 0)
    (= (max-coste-total) 9999)

    (= (interes barcelona) 9)
    (= (interes lisboa) 7)
    (= (interes viena) 1)
    (= (interes praga) 1)
    (= (interes amsterdam) 1)
    (= (interes bruselas) 2)

    (= (precio-hotel-dia h-barcelona) 10)
    (= (precio-hotel-dia h-lisboa) 10)
    (= (precio-hotel-dia h-viena) 10)
    (= (precio-hotel-dia h-praga) 10)
    (= (precio-hotel-dia h-amsterdam) 10)
    (= (precio-hotel-dia h-bruselas) 10)

    (= (precio-vuelo barcelona lisboa) 10)
    (= (precio-vuelo lisboa viena) 10)
    (= (precio-vuelo viena praga) 10)
    (= (precio-vuelo praga amsterdam) 10)
    (= (precio-vuelo amsterdam bruselas) 10)

    (= (precio-vuelo barcelona viena) 10)
    (= (precio-vuelo viena amsterdam) 10)
    (= (precio-vuelo lisboa praga) 10)
    (= (precio-vuelo praga bruselas) 10)

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
