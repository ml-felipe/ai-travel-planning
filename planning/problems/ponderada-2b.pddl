(define (problem ponderada-2b)
  (:domain agencia-viajes-web)

  (:objects
    inicio museo playa montana pueblo capital final - ciudad
    h-inicio h-museo h-playa h-montana h-pueblo h-capital h-final - hotel
    e1 e2 e3 - estancia
  )

  (:init
    (inicio-disponible)

    (no-visitada inicio)
    (no-visitada museo)
    (no-visitada playa)
    (no-visitada montana)
    (no-visitada pueblo)
    (no-visitada capital)
    (no-visitada final)

    (hotel-en h-inicio inicio)
    (hotel-en h-museo museo)
    (hotel-en h-playa playa)
    (hotel-en h-montana montana)
    (hotel-en h-pueblo pueblo)
    (hotel-en h-capital capital)
    (hotel-en h-final final)

    (vuelo inicio museo)
    (vuelo museo playa)
    (vuelo playa final)

    (vuelo inicio pueblo)
    (vuelo pueblo montana)
    (vuelo montana final)

    (vuelo inicio capital)
    (vuelo capital final)
    (vuelo museo capital)
    (vuelo pueblo capital)

    (= (duracion e1) 1)
    (= (duracion e2) 2)
    (= (duracion e3) 3)

    (= (min-ciudades) 4)
    (= (min-dias-ciudad) 1)
    (= (max-dias-ciudad) 3)
    (= (min-dias-total) 6)
    (= (min-coste-total) 0)
    (= (max-coste-total) 9999)

    (= (interes inicio) 4)
    (= (interes museo) 1)
    (= (interes playa) 1)
    (= (interes montana) 6)
    (= (interes pueblo) 7)
    (= (interes capital) 3)
    (= (interes final) 4)

    (= (precio-hotel-dia h-inicio) 50)
    (= (precio-hotel-dia h-museo) 150)
    (= (precio-hotel-dia h-playa) 150)
    (= (precio-hotel-dia h-montana) 35)
    (= (precio-hotel-dia h-pueblo) 35)
    (= (precio-hotel-dia h-capital) 90)
    (= (precio-hotel-dia h-final) 50)

    (= (precio-vuelo inicio museo) 100)
    (= (precio-vuelo museo playa) 100)
    (= (precio-vuelo playa final) 100)

    (= (precio-vuelo inicio pueblo) 20)
    (= (precio-vuelo pueblo montana) 20)
    (= (precio-vuelo montana final) 20)

    (= (precio-vuelo inicio capital) 60)
    (= (precio-vuelo capital final) 60)
    (= (precio-vuelo museo capital) 80)
    (= (precio-vuelo pueblo capital) 40)

    (= (num-visitadas) 0)
    (= (dias-totales) 0)
    (= (coste-total) 0)
    (= (interes-total) 0)
  )

  (:goal
    (viaje-finalizado)
  )

  ;; Mucho peso al coste.
  (:metric minimize
    (+ (interes-total) (* 10 (coste-total)))
  )
)
