(define (problem ponderada-1b)
  (:domain agencia-viajes-web)

  (:objects
    origen cultural1 cultural2 barata1 barata2 destino - ciudad
    h-origen h-cultural1 h-cultural2 h-barata1 h-barata2 h-destino - hotel
    e1 e2 - estancia
  )

  (:init
    (inicio-disponible)

    (no-visitada origen)
    (no-visitada cultural1)
    (no-visitada cultural2)
    (no-visitada barata1)
    (no-visitada barata2)
    (no-visitada destino)

    (hotel-en h-origen origen)
    (hotel-en h-cultural1 cultural1)
    (hotel-en h-cultural2 cultural2)
    (hotel-en h-barata1 barata1)
    (hotel-en h-barata2 barata2)
    (hotel-en h-destino destino)

    (vuelo origen cultural1)
    (vuelo cultural1 cultural2)
    (vuelo cultural2 destino)
    (vuelo origen barata1)
    (vuelo barata1 barata2)
    (vuelo barata2 destino)

    (= (duracion e1) 1)
    (= (duracion e2) 2)

    (= (min-ciudades) 4)
    (= (min-dias-ciudad) 1)
    (= (max-dias-ciudad) 2)
    (= (min-dias-total) 4)
    (= (min-coste-total) 0)
    (= (max-coste-total) 9999)

    (= (interes origen) 5)
    (= (interes cultural1) 1)
    (= (interes cultural2) 1)
    (= (interes barata1) 8)
    (= (interes barata2) 8)
    (= (interes destino) 5)

    (= (precio-hotel-dia h-origen) 60)
    (= (precio-hotel-dia h-cultural1) 120)
    (= (precio-hotel-dia h-cultural2) 120)
    (= (precio-hotel-dia h-barata1) 30)
    (= (precio-hotel-dia h-barata2) 30)
    (= (precio-hotel-dia h-destino) 60)

    (= (precio-vuelo origen cultural1) 120)
    (= (precio-vuelo cultural1 cultural2) 120)
    (= (precio-vuelo cultural2 destino) 120)

    (= (precio-vuelo origen barata1) 20)
    (= (precio-vuelo barata1 barata2) 20)
    (= (precio-vuelo barata2 destino) 20)

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
