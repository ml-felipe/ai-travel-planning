(define (problem viaje-ext4-prueba-1)
  (:domain agencia-viajes-web)

  (:objects
    barcelona paris roma berlin viena lisboa - ciudad
    h-bcn h-paris h-roma h-berlin h-viena h-lisboa - hotel
    e1 e2 e3 e4 e5 - estancia
  )

  (:init
    ;; Control de inicio
    (inicio-disponible)

    ;; Ciudades inicialmente no visitadas
    (no-visitada barcelona)
    (no-visitada paris)
    (no-visitada roma)
    (no-visitada berlin)
    (no-visitada viena)
    (no-visitada lisboa)

    ;; Hoteles disponibles
    (hotel-en h-bcn barcelona)
    (hotel-en h-paris paris)
    (hotel-en h-roma roma)
    (hotel-en h-berlin berlin)
    (hotel-en h-viena viena)
    (hotel-en h-lisboa lisboa)

    ;; Vuelos entre ciudades
    (vuelo barcelona paris)
    (vuelo paris roma)
    (vuelo roma viena)
    (vuelo viena berlin)
    (vuelo berlin lisboa)
    (vuelo lisboa barcelona)

    (vuelo barcelona roma)
    (vuelo roma berlin)
    (vuelo paris viena)
    (vuelo viena lisboa)
    (vuelo lisboa paris)

    ;; Duraciones posibles
    (= (duracion e1) 1)
    (= (duracion e2) 2)
    (= (duracion e3) 3)
    (= (duracion e4) 4)
    (= (duracion e5) 5)

    ;; Restricciones del viaje
    (= (min-ciudades) 4)
    (= (min-dias-ciudad) 2)
    (= (max-dias-ciudad) 4)
    (= (min-dias-total) 10)
    (= (min-coste-total) 500)
    (= (max-coste-total) 1200)

    ;; Interes: menor valor = mas interesante
    (= (interes barcelona) 2)
    (= (interes paris) 1)
    (= (interes roma) 1)
    (= (interes berlin) 3)
    (= (interes viena) 2)
    (= (interes lisboa) 3)

    ;; Precio por noche de hotel
    (= (precio-hotel-dia h-bcn) 90)
    (= (precio-hotel-dia h-paris) 140)
    (= (precio-hotel-dia h-roma) 110)
    (= (precio-hotel-dia h-berlin) 80)
    (= (precio-hotel-dia h-viena) 100)
    (= (precio-hotel-dia h-lisboa) 70)

    ;; Precios de vuelos
    (= (precio-vuelo barcelona paris) 120)
    (= (precio-vuelo paris roma) 100)
    (= (precio-vuelo roma viena) 90)
    (= (precio-vuelo viena berlin) 60)
    (= (precio-vuelo berlin lisboa) 150)
    (= (precio-vuelo lisboa barcelona) 130)

    (= (precio-vuelo barcelona roma) 160)
    (= (precio-vuelo roma berlin) 130)
    (= (precio-vuelo paris viena) 140)
    (= (precio-vuelo viena lisboa) 170)
    (= (precio-vuelo lisboa paris) 150)

    ;; Acumuladores iniciales
    (= (num-visitadas) 0)
    (= (dias-totales) 0)
    (= (coste-total) 0)
    (= (interes-total) 0)
  )

  (:goal
    (viaje-finalizado)
  )

  (:metric minimize
    (+ (* 10 (interes-total)) (coste-total))
  )
)