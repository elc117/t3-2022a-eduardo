# Pattern Matcher
A função `pat-match` retorna a lista de BINDINGS, isto é, a lista que contém os pares `(variável . valor)` gerados à medida que houve matching. Essa lista poderá ser usada para gerar a resposta correspondente ao padrão com o qual houve matching. Se, em algum momento, o matching falhar, o valor retornado será FAIL.

Quando o parâmetro PATTERN for uma variável, a função `match-variable` será chamada, a fim de verificar se essa variável já está na lista BINDINGS. Caso não esteja, adicionamo-la a BINDINGS; caso esteja, verificamos se o valor correspondente a essa variável em BINDINGS é o mesmo valor de INPUT, pois uma mesma variável que ocorra várias vezes, deve ter o mesmo valor em cada ocorrência.

Se PATTERN for igual a INPUT, retornamos a lista de BINDINGS, pois sabemos que ocorre matching no restante de INPUT.

Se tanto PATTERN quanto INPUT forem listas não nulas, chamamos `pat-match` com o tail de PATTERN e INPUT, usando como BINDINGS o retorno de `(pat-match (first pattern) (first input))`.
