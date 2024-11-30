#lang eopl

(require rackunit racket/list "interpretadorClase.rkt")
(define (run-tests)
  (display "=== Ejecución de pruebas ===") (newline)

  ;; Prueba 1: Lista construida correctamente (cambia los elementos de la lista)
  (define exp1 (scan&parse "cons(10 cons(20 cons(30 empty)))"))
  (check-equal? (evaluar-programa exp1) '(10 20 30)
    "Prueba 1: La lista no se construyó correctamente")

  ;; Prueba 2: Lista vacía
  (define exp2 (scan&parse "empty"))
  (check-equal? (evaluar-programa exp2) '() 
    "Prueba 2: La lista vacía no se reconoció correctamente")

  ;; Prueba 3: Anidación de listas (cambiamos los valores y la estructura)
  (define exp3 (scan&parse "cons(cons(5 empty) cons(6 empty))"))
  (check-equal? (evaluar-programa exp3) '((5) 6) 
    "Prueba 3: La anidación de listas no funciona correctamente")

  ;; Prueba 4: Uso de let dentro de la lista (cambiamos los valores y la estructura)
  (define exp4 (scan&parse "
      let y = 4
         in
         cons(y cons(7 empty))
      "))
  (check-equal? (evaluar-programa exp4) '(4 7) 
    "Prueba 4: El uso de let no funciona correctamente")

  ;; Prueba 5: Error cuando el segundo argumento de cons no es una lista
  (define exp5 (scan&parse "cons(2 7)"))
  (check-exn (lambda (exn) #t)
    (lambda () (evaluar-programa exp5))
    "Prueba 5: No se lanzó una excepción cuando el segundo argumento de cons no es una lista")

  (display "=== Fin de las pruebas ===") (newline))

;; Función principal para correr las pruebas
(define (run-test-primitivas)
  (display "=== Ejecución de pruebas primitivas ===") (newline)

  ;; Prueba 1: Función length (longitud de la lista)
  (define exp1 (scan&parse "length(cons(5 cons(10 cons(15 empty))))"))
  (check-equal? (evaluar-programa exp1) 3
    "Prueba 1: La longitud de la lista es incorrecta")

  ;; Prueba 2: Función first (primer elemento de la lista)
  (define exp2 (scan&parse "first(cons(10 cons(20 cons(30 empty))))"))
  (check-equal? (evaluar-programa exp2) 10
    "Prueba 2: El primer elemento de la lista es incorrecto")

  ;; Prueba 3: Función rest (resto de la lista)
  (define exp3 (scan&parse "rest(cons(5 cons(10 cons(15 empty))))"))
  (check-equal? (evaluar-programa exp3) '(10 15)
    "Prueba 3: El resto de la lista es incorrecto")

  ;; Prueba 4: Función nth (elemento en la posición n de la lista)
  (define exp4 (scan&parse "nth(cons(7 cons(14 cons(21 empty))) 2)"))
  (check-equal? (evaluar-programa exp4) 21
    "Prueba 4: El elemento en la posición 2 de la lista es incorrecto")

  (display "=== Fin de las pruebas primitivas ===") (newline))

;; Ejecutar pruebas
(run-tests)

;; Ejecutar pruebas primitivas
(run-test-primitivas)
