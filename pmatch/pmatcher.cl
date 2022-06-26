
(defun variable-p (x)
  "Predicado que diz se um símbolo X é uma variável.
  A convenção é que variáveis começam com '?'."
  (and (symbolp x) (equal (char (symbol-name x) 0) #\?)))

(defconstant fail nil
  "O pattern-matcher retornará FAIL caso o matching falhe.
  Declaramos essa constante para distinguir a falha e a lista NIL.")

(defconstant no-bindings '((t . t))
  "Indica que houve matching e o pattern usado não possuía nenhuma variável.")

(defun get-binding (var bindings)
  "Pega o par (variável . valor) relativo a VAR."
  (assoc var bindings))

(defun binding-val (binding)
  "Dado um par variável-valor, retorna o valor."
  (cdr binding))

(defun lookup (var bindings)
  "Dado um VAR e uma lista de pares (variável . valor), retorna o valor relativo a VAR."
  (binding-val (get-binding var bindings)))

(defun extend-bindings (var val bindings)
  "Adiciona um par (variável . valor) à lista de pares.
  Essa adição ocorre à medida que ocorrer matching."
  (cons (cons var val) bindings))

(defun pat-match (pattern input &optional (bindings no-bindings))
  "Retorna BINDINGS, uma lista que contém pares (variável . valor).
  Caso o matching falhe, retorna FAIL."
  (cond ((eq bindings fail) fail)
        ((variable-p pattern)
         (match-variable pattern input bindings))
        ((eql pattern input) bindings)
        ((and (consp pattern) (consp input))
         (pat-match (rest pattern) (rest input)
                    (pat-match (first pattern) (first input)
                               bindings)))
        (t fail)))

(defun match-variable (var input bindings)
  "Verifica se há matching entre INPUT e VAR.
  Se VAR não estiver em BINDINGS, adicionamos VAR à lista.
  Se estiver, vemos se INPUT é igual ao valor correspondente em BINDINGS."
  (let ((binding (get-binding var bindings)))
    (cond ((not binding) (extend-bindings var input bindings))
          ((equal input (binding-val binding)) bindings)
          (t fail))))