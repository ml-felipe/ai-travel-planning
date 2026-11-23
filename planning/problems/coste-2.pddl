(define (problem coste-2)
  (:domain agencia-viajes-web)

  (:objects
    barcelona lisboa viena praga amsterdam bruselas - ciudad
    h-barcelona h-lisboa h-viena h-praga h-amsterdam h-bruselas - hotel
    e1 e2 e3 - estancia
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
    (= (duracion e3) 3)

    (= (min-ciudades) 4)
    (= (min-dias-ciudad) 1)
    (= (max-dias-ciudad) 3)
    (= (min-dias-total) 6)
    (= (min-coste-total) 200)
    (= (max-coste-total) 500)

    (= (interes barcelona) 1)
    (= (interes lisboa) 1)
    (= (interes viena) 1)
    (= (interes praga) 1)
    (= (interes amsterdam) 1)
    (= (interes bruselas) 1)

    (= (precio-hotel-dia h-barcelona) 70)
    (= (precio-hotel-dia h-lisboa) 30)
    (= (precio-hotel-dia h-viena) 30)
    (= (precio-hotel-dia h-praga) 30)
    (= (precio-hotel-dia h-amsterdam) 30)
    (= (precio-hotel-dia h-bruselas) 70)

    (= (precio-vuelo barcelona lisboa) 80)
    (= (precio-vuelo lisboa viena) 20)
    (= (precio-vuelo viena praga) 20)
    (= (precio-vuelo praga amsterdam) 20)
    (= (precio-vuelo amsterdam bruselas) 80)

    (= (precio-vuelo barcelona viena) 120)
    (= (precio-vuelo viena amsterdam) 30)
    (= (precio-vuelo lisboa praga) 30)
    (= (precio-vuelo praga bruselas) 120)

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
