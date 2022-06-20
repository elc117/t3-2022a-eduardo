# Comparando Common Lisp com Haskell
## Map
`mapcar` aplica uma função a cada elemento de uma lista, quando apenas uma lista for passada.
```
CL-USER> (mapcar #'(lambda (x) (* x x)) '(1 2 3 4 5))
(1 4 9 16 25)
```
Também podemos passar mais de uma lista para `mapcar`, desde que a função passada receba o mesmo número de argumentos que de listas. `mapcar` para a execução quando o final de uma das listas for alcançado.
```
CL-USER> (mapcar #'(lambda (x y) (* x (+ x y))) '(1 2 3) '(1 2 3))
(2 8 18)
CL-USER> (mapcar #'(lambda (x y z) (- (* x y) z)) '(1 2 3) '(1 2 3) '(1 2 3))
(0 2 6)
CL-USER> (mapcar #'+ '(1 2) '(1 2 3 4 5 6))
(2 4)
```
## Zip
Usando `mapcar`, podemos definir uma função `zip`.
```
(defun zip (lx ly)
  (mapcar #'list lx ly))

CL-USER> (zip '(A B C) '(1 2 3))
((A 1) (B 2) (C 3))
```
## ZipWith
Também podemos definir uma função `zipWith`.
```
(defun zip-with (fn lx ly)
  (mapcar fn lx ly))

CL-USER> (zip-with #'* '(1 2 3) '(4 5 6))
(4 10 18)
```
## Filter
`remove-if` e `remove-if-not` podem ser usados para filtrar uma lista.
```
CL-USER> (remove-if #'numberp '(A 1 2 B 3 4 C))
(A B C)
CL-USER> (remove-if-not #'oddp '(1 2 3 4 5 6))
(1 3 5)
```
## Fold
`reduce` reduz os elementos de uma lista a um único valor de acordo com a função passada, que deve possuir apenas dois parâmetros.
```
CL-USER> (reduce #'+ '(1 2 3 4 5))
15
```
## Uma grande diferença com Haskell
Em Common Lisp, não há *currying* automático. Portanto, utilizar `multBySumOfAB` com funções de alta ordem é um pouco mais complicado.
```
multBySumOfAB :: (Num -> a) => a -> a -> a -> a
multBySumOfAB a b x = (a + b) * x
```
Em Haskell bastaria usar parênteses, criando uma função que recebe um único argumento.
```
Prelude> map (multBySumOfAB 5 5) [1, 2, 3, 4, 5]
[10,20,30,40,50]
```
No entanto, em Common Lisp, é necessário definir a função `curry`, usando `&rest` para receber um número arbitrário de argumentos.
```
(defun curry (function &rest args)
  (lambda (&rest more-args)
          (apply function (append args more-args))))

(defun mult-by-sum-of-ab (a b x)
  (* (+ a b) x))

CL-USER> (mapcar (curry #'mult-by-sum-of-ab 5 5) '(1 2 3 4 5))
(10 20 30 40 50)
```
# Referências
[Common Lisp: A Gentle Introduction to Symbolic Computation](https://www.cs.cmu.edu/~dst/LispBook/)

[Currying em Common Lisp](http://cl-cookbook.sourceforge.net/functions.html#curry)

[Tipos de argumentos em Common Lisp](https://lispcookbook.github.io/cl-cookbook/functions.html)
