#lang eopl
(require rackunit racket/list "interpretadorClase.rkt")

(define (run-tests)
  (display "=== Ejecución de pruebas ===") (newline)

  ;; Prueba 1: Caso simple con una condición que se evalúa como verdadera
  (define exp1 (scan&parse "cond
                              -(x , 1) ==> 1
                              -(x , 2) ==> 2
                              else ==> 3
                            end"))
  (check-equal? (evaluar-programa exp1) 2
    "Prueba 1: La condición -(x , 2) debería retornar 2")

  ;; Prueba 2: Caso simple con `else`
  (define exp2 (scan&parse "cond
                              else ==> 5
                            end"))
  (check-equal? (evaluar-programa exp2) 5
    "Prueba 2: El `else` debería retornar 5")

  ;; Prueba 3: Caso con múltiples condiciones, la primera se evalúa como falsa
  (define exp3 (scan&parse "cond
                              -(x , 3) ==> 1
                              -(x , 4) ==> 2
                              else ==> 3
                            end"))
  (check-equal? (evaluar-programa exp3) 1
    "Prueba 3: La expresión -(x , 3) debería retornar 1")

  ;; Prueba 4: Caso con anidación de expresiones, primera condición verdadera
  (define exp4 (scan&parse "cond
                              -(x , 2) ==> cond
                                          -(y , 3) ==> 4
                                          else ==> 5
                                        end
                              else ==> 6
                            end"))
  (check-equal? (evaluar-programa exp4) 4
    "Prueba 4: La expresión -(y , 3) debería retornar 4")

  ;; Prueba 5: Caso con una expresión anidada y `else`
  (define exp5 (scan&parse "cond
                              -(x , 1) ==> cond
                                          -(y , 2) ==> 7
                                          else ==> 8
                                        end
                              else ==> 9
                            end"))
  (check-equal? (evaluar-programa exp5) 9
    "Prueba 5: El `else` debería retornar 9")

  ;; Prueba 6: Caso donde todas las condiciones fallan y se usa `else`
  (define exp6 (scan&parse "cond
                              -(x , 1) ==> 3
                              -(y , 20) ==> 4
                              else ==> 6
                            end"))
  (check-equal? (evaluar-programa exp6) 4
    "Prueba 6: La expresión -(y , 20) debería retornar 4")

  ;; Prueba 7: Caso con una condición siempre falsa y solo `else`
  (define exp7 (scan&parse "cond
                              -(x , 100) ==> 69
                              else ==> 9
                            end"))
  (check-equal? (evaluar-programa exp7) 69
    "Prueba 7: La expresión -(x , 100) debería retornar 69")

  (display "=== Fin de las pruebas ===") (newline))

;; Ejecutar pruebas
(run-tests)
