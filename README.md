# AFD para Validação e Conversão de Números Romanos

Este projeto implementa um **Autômato Finito Determinístico (AFD)** capaz de **reconhecer números romanos válidos** e **convertê-los para sua representação decimal**.

O autômato foi implementado em **Ruby** e modelado como um **Transdutor Finito do tipo Mealy**, pois a saída é gerada **durante as transições de estado**.

O sistema verifica:

* regras de formação dos números romanos
* limites de repetição de símbolos
* regras de subtração (IV, IX, XL, XC, CD, CM)
* ordem correta dos símbolos

Caso a cadeia seja válida, o programa retorna o número romano normalizado e seu valor decimal.

---

# Estrutura do Projeto

```
Transfutor-De-romanos/
│
├── Transdutor.rb
├── README.md
│
└── docs/
    └── afd_diagrama.md
```

Descrição dos arquivos:

| Arquivo                | Descrição                                       |
| ---------------------- | ----------------------------------------------- |
| `Transdutor.rb`               | Implementação do Autômato Finito Determinístico |
| `docs/afd_diagrama.md` | Diagrama do autômato utilizando Mermaid         |
| `README.md`            | Documentação do projeto                         |

---

# Definição Formal do Transdutor

O sistema pode ser formalmente descrito como:

```
T = (Q, Σ, Γ, δ, λ, q0)
```

Onde:

* **Q** → conjunto finito de estados
* **Σ** → alfabeto de entrada
* **Γ** → alfabeto de saída
* **δ** → função de transição
* **λ** → função de saída
* **q₀** → estado inicial

---

# Conjunto de Estados (Q)

O autômato possui estados que representam as diferentes etapas da leitura dos símbolos romanos.

```
Q = {
start,
read_M,
read_MM,
read_MMM,
read_D,
read_C_after_D,
read_CC_after_D,
read_CCC_after_D,
read_C,
read_CC,
read_CCC,
read_L,
read_X_after_L,
read_XX_after_L,
read_XXX_after_L,
read_X,
read_XX,
read_XXX,
read_V,
read_I_after_V,
read_II_after_V,
read_III_after_V,
read_I,
read_II,
read_III
}
```

---

# Alfabeto de Entrada (Σ)

O alfabeto de entrada é composto pelos símbolos válidos do sistema numérico romano:

```
Σ = { I, V, X, L, C, D, M }
```

Cada símbolo possui o seguinte valor:

| Símbolo | Valor |
| ------- | ----- |
| I       | 1     |
| V       | 5     |
| X       | 10    |
| L       | 50    |
| C       | 100   |
| D       | 500   |
| M       | 1000  |

---

# Alfabeto de Saída (Γ)

O autômato produz como saída combinações válidas de números romanos.

```
Γ = {
I, V, X, L, C, D, M,
IV, IX,
XL, XC,
CD, CM
}
```

Esses símbolos são emitidos quando o autômato reconhece padrões válidos durante as transições.

---

# Função de Transição

A função de transição é definida como:

```
δ : Q × Σ → Q
```

Exemplo de transições:

| Estado Atual | Entrada | Próximo Estado |
| ------------ | ------- | -------------- |
| start        | M       | read_M         |
| read_M       | M       | read_MM        |
| read_MM      | M       | read_MMM       |
| start        | C       | read_C         |
| read_C       | C       | read_CC        |
| read_X       | X       | read_XX        |
| read_V       | I       | read_I_after_V |

Você Pode visualizar as transições aqui:
[Transições](https://mermaid.live/edit#pako:eNqNlUFvozAQhf8K8nHlZMEQFHzoxVyQyBWhLqvKKm5a7QKVS1a7G-W_10CCx2Wa9AZv3vtmxkLmSB67WhFOqvatl71KX-Rey2b1h1Vt1f749tNbre48U9L9IIwPo6SVrB92Hvd2CzU1arpQhVHFQs2Nmi_U0qjlQi2MWizUzKjZMNt5IjvceTqgT1EzHRU0pyUtaOZ9HzwXlxN38lcBkHDdaJ0pOJoH-dQrPR6ccMoXjEWkM8CmLAgjuT6EKCwSZaLQ21SI_YIb2GFz2NMJ70xM7NBSOpRStGRbwvGcbZ0tPws7y31qsq4cfNzns8injxyUL4gpns9hm7AQjOL6PtBKi0N5KPA6ESJvOIEVNoW9nKAwsVKgpXwo5WhpagfHcjZ0NsOCzkKowToKcAWddy-mqwiU53XGS2D4ZIsZYFMWhJFcH0K0t1-GMlHobSrEfsEN7LA57OmeqIllBVoqh1IJ2jvbOPd9loEooWSvX2rCe31QlDRKN3J4Jceq9byK9M-qURXh5rGW-ldlfnonk3mV7X3XNZeY7g77Z8Kf5O8383Z4re1vcbaotlZadIe2J3y7GRGEH8lfwqNg7fuRH8aRv9kE2zCm5B_hLIjXm5AlCQt8FsWMxSdK_o9N_XWSRCELgpj5LE622_D0Du6cVGQ)

---

# Função de Saída

A função de saída é definida como:

```
λ : Q × Σ → Γ
```

A saída é gerada **durante a transição**, característica do modelo **Mealy**.

Exemplo:

| Estado | Entrada | Saída |
| ------ | ------- | ----- |
| read_C | M       | CM    |
| read_C | D       | CD    |
| read_X | C       | XC    |
| read_X | L       | XL    |
| read_I | X       | IX    |
| read_I | V       | IV    |

---

# Tipo de Transdutor

Este autômato é um **Transdutor Finito do tipo Mealy**.

No modelo Mealy:

```
λ : Q × Σ → Γ
```

A saída depende de:

* estado atual
* símbolo de entrada

No código Ruby isso ocorre quando um símbolo é adicionado à variável:

```
@finalNumber
```

Exemplo no código:

```ruby
when "X"
  check_order(values("I"))
  @finalNumber << "IX"
  @lvl = 0
  @state = :start
```

Nesse caso:

```
(read_I, X) → (start, IX)
```

---

# Funcionamento do Algoritmo

O algoritmo percorre a cadeia de entrada caractere por caractere:

1. lê um símbolo romano
2. verifica se a transição é válida
3. verifica a ordem dos valores
4. adiciona o símbolo correspondente à saída
5. continua até o fim da cadeia

Se a cadeia for inválida, o autômato entra em estado de erro.

---

# Exemplos de Execução

## Exemplo 1 — Entrada válida

Entrada:

```
XIV
```

Saída:

```
Cadeia aceita = XIV
Conversão = 14
```

---

## Exemplo 2 — Entrada válida

Entrada:

```
MCMXCIX
```

Saída:

```
Cadeia aceita = MCMXCIX
Conversão = 1999
```

---

## Exemplo 3 — Entrada inválida

Entrada:

```
IIII
```

Saída:

```
Sequencia gramatical invalida
```

---

# Regras de Validação Aplicadas

O autômato verifica:

### Limite de repetições

| Símbolo | Máximo |
| ------- | ------ |
| I       | 3      |
| X       | 3      |
| C       | 3      |
| M       | 3      |
| V       | 1      |
| L       | 1      |
| D       | 1      |

---

### Regras de Subtração

Subtrações permitidas:

| Forma | Valor |
| ----- | ----- |
| IV    | 4     |
| IX    | 9     |
| XL    | 40    |
| XC    | 90    |
| CD    | 400   |
| CM    | 900   |

Outras combinações são consideradas inválidas.

---

# Conversão para Decimal

Após validar a cadeia, o algoritmo converte o número romano utilizando a regra:

* se o próximo símbolo for maior → subtrai
* caso contrário → soma

Exemplo:

```
IX
```

Processo:

```
I = 1
X = 10
```

Como 10 > 1:

```
10 - 1 = 9
```

Resultado:

```
9
```

---

# Diagrama do Autômato

O diagrama completo do AFD pode ser encontrado em:

```
docs/afd_diagrama.md
```

O diagrama foi implementado utilizando **Mermaid**, permitindo visualização automática em plataformas como GitHub.

---

# Como Executar o Projeto

Certifique-se de possuir **Ruby instalado**.

Execute o programa com:

```
ruby afd.rb
```

O programa executará automaticamente diversos testes definidos no arquivo.

---

# Tecnologias Utilizadas

* Ruby
* Mermaid (para diagramas)
* Markdown (documentação)

---

# Autor

Projeto desenvolvido para fins acadêmicos na disciplina de **Linguagens Formais e Autômatos**.
