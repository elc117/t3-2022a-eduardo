
;; Exercício 7.10, Pág. 220 do Common Lisp: A Gentle Introduction to Symbolic Computation.

(defparameter *note-table*
  '((c 1)
    (c-sharp 2)
    (d 3)
    (d-sharp 4)
    (e 5)
    (f 6)
    (f-sharp 7)
    (g 8)
    (g-sharp 9)
    (a 10)
    (a-sharp 11)
    (b 12)))

(defun numbers (notes note-table)
  "Retorna uma lista com os números relacionados a cada nota."
  (mapcar #'(lambda (note) (first (rest (assoc note note-table))))
  	  notes))

(defun assoc-snd (elem list)
  "Como o ASSOC, mas busca a partir do segundo elemento da sub-lista."
  (find-if #'(lambda (sub-list) (eql elem (second sub-list)))
	   list))

(defun notes (nums note-table)
  "Retorna uma lista com as notas relacionadas a cada número."
  (mapcar #'(lambda (num) (first (assoc-snd num note-table)))
  	  nums))

(defun raise (num list)
  (mapcar #'(lambda (elem) (+ elem num)) list))

(defun normalize (list)
  (mapcar #'(lambda (elem)
  	      (cond ((> elem 12) (- elem 12))
  	  	    ((< elem 1) (+ elem 12))
		    (t elem)))
	  list))

(defun only-notes-p (song note-table)
  "Verifica se a lista SONG só contém notas."
  (every #'(lambda (symbol) (assoc symbol note-table))
  	 song))

(defun only-numbers-p (song note-table)
  "Verifica se a lista SONG só contém números relacionados a alguma nota."
  (every #'(lambda (symbol) (assoc-snd symbol note-table))
  	 song))

(defun transpose (n song note-table)
  "Muda a tonalidade de uma sequência de notas."
  (cond ((only-notes-p song note-table)
       	 (notes (normalize (raise n (numbers song note-table)))
		note-table))
	((only-numbers-p song note-table)
	 (notes (normalize (raise n song))
	 	note-table))
	(t "Sequência inconsistente de notas.")))

A C E D C B A-SHARP E B G-SHARP A