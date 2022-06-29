# Pattern Matcher
Essa versão do *pattern-matcher* é a versão implementada até a seção 5.2 do PAIP. Ela não funciona com *segment variables*, isto é, só pode haver *matching* entre uma variável e uma única palavra.

A função `pat-match` retorna a lista de BINDINGS, que é a lista que contém os pares `(variável . valor)` gerados à medida que houve *matching*. Essa lista poderá ser usada para gerar a resposta correspondente ao padrão com o qual houve *matching*. Se, em algum momento, o *matching* falhar, o valor retornado será FAIL.

As condições que guiam a execução de `pat-match` são as seguintes:

1. Se BINDINGS for FAIL, retornamos FAIL, pois sabemos que em algum momento da execução não houve *matching*.

2. Se o parâmetro PATTERN for uma variável, a função `match-variable` será chamada, a fim de verificar se essa variável já está na lista BINDINGS. Caso não esteja, adicionamo-la a BINDINGS; caso esteja, verificamos se o valor correspondente a essa variável em BINDINGS é o mesmo valor de INPUT, pois uma mesma variável que ocorra várias vezes, deve ter o mesmo valor em cada ocorrência.

3. Se PATTERN for igual a INPUT, retornamos a lista de BINDINGS, pois sabemos que ocorre *matching* no restante de INPUT.

4. Se tanto PATTERN quanto INPUT forem listas não nulas, chamamos `pat-match` recursivamente com o tail de PATTERN e INPUT, usando como BINDINGS o retorno de `pat-match` executado até o momento.

# Referências
[Capítulo 5 de Paradigms of Artificial Intelligence Programming](https://github.com/norvig/paip-lisp/blob/main/docs/chapter5.md)
