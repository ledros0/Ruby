# 🤖 Máquina de Turing Universal (MTU)

Implementação de uma **Máquina de Turing Universal** em Ruby capaz de simular três máquinas de Turing distintas, cada uma reconhecendo uma linguagem de uma classe diferente da Hierarquia de Chomsky.

---

## 📚 Contexto Teórico

A **Hierarquia de Chomsky** classifica linguagens formais em quatro níveis:

| Tipo   | Classe                    | Reconhecedor                           |
| ------ | ------------------------- | -------------------------------------- |
| Tipo 3 | Regular                   | Autômato Finito / MT com fita restrita |
| Tipo 2 | Livre de Contexto         | Autômato de Pilha / MT                 |
| Tipo 1 | Sensível ao Contexto      | MT com fita limitada                   |
| Tipo 0 | Recursivamente Enumerável | Máquina de Turing                      |

Uma **Máquina de Turing Universal** é uma MT capaz de simular qualquer outra MT, recebendo como entrada a codificação da máquina + a cadeia a ser reconhecida.

---

## 🗂️ Estrutura do Projeto

```
.
├── mtu.rb         # Máquina de Turing Universal — lê, decodifica e simula
├── maquina1.rb    # MT para a*b*        (Linguagem Regular)
├── maquina2.rb    # MT para aⁿbⁿ        (Linguagem Livre de Contexto)
├── maquina3.rb    # MT para aⁿbⁿcⁿ      (Linguagem Sensível ao Contexto)
├── entrada1.rb    # Leitura de cadeia para máquina 1
├── entrada2.rb    # Leitura de cadeia para máquina 2
├── entrada3.rb    # Leitura de cadeia para máquina 3
├── teste1.rb      # Bateria de testes para máquina 1
├── teste2.rb      # Bateria de testes para máquina 2
├── teste3.rb      # Bateria de testes para máquina 3
└── main.rb        # Ponto de entrada principal
```

---

## ⚙️ Codificação da Fita

A MTU recebe uma fita no formato:

```
# <transições codificadas> $ <cadeia codificada>
```

* `#` indica o início da descrição da máquina
* `$` separa a descrição da máquina da cadeia de entrada
* As transições são codificadas e concatenadas sequencialmente

---

### Estados

Estados são codificados em unário com `a`:

| Estado     | Código       |
| ---------- | ------------ |
| qf (final) | `a`          |
| q0         | `aa`         |
| q1         | `aaaa`       |
| q2         | `aaaaaa`     |
| q3         | `aaaaaaaa`   |
| q4         | `aaaaaaaaaa` |

---

### Símbolos da fita

Símbolos são codificados em sequências de `b` terminadas em `a`:

| Símbolo       | Código         |
| ------------- | -------------- |
| Branco (_)    | `ba`           |
| a             | `bbba`         |
| b             | `bbbbbba`      |
| X (a marcado) | `bbbbbbba`     |
| Y (b marcado) | `bbbbbbbbba`   |
| c             | `bbbbbbbba`    |
| Z (c marcado) | `bbbbbbbbbbba` |

---

### Movimentos

| Direção      | Código |
| ------------ | ------ |
| Esquerda (E) | `c`    |
| Direita (D)  | `cc`   |

---

### Transições

Cada transição `(q, s) → (q', s', mov)` é codificada como:

```
<estado_lido> <símbolo_lido> <estado_destino> <símbolo_escrito> <movimento>
```

---

### 🔍 Separação e Decodificação das Transições

As transições são concatenadas sequencialmente na fita, sem delimitadores explícitos entre elas.

A separação entre transições é garantida pela **estrutura fixa da codificação**, onde cada transição possui exatamente a seguinte forma:

```
<estado_lido> <símbolo_lido> <estado_destino> <símbolo_escrito> <movimento>
```

Cada componente possui um padrão distinto:

* Estados são sequências de `a`
* Símbolos são sequências de `b` terminadas em `a`
* Movimentos são `c` (esquerda) ou `cc` (direita)

Dessa forma, a leitura é realizada por um **parser determinístico**, que consome a fita sequencialmente e identifica unicamente cada componente, garantindo que a codificação seja **não ambígua**.

---

## 🧠 As Três Máquinas

### Máquina 1 — `a*b*` (Regular)

Aceita qualquer sequência de zero ou mais `a`'s seguida de zero ou mais `b`'s.

**Exemplos aceitos:** `ε`, `a`, `bbb`, `aabb`, `aaabbb`
**Exemplos rejeitados:** `ba`, `abba`, `aabba`

**Estratégia:** Percorre `a`'s em q0, transita para q1 no primeiro `b`, percorre `b`'s. Aceita no branco em qualquer estado.

---

### Máquina 2 — `aⁿbⁿ` (Livre de Contexto)

Aceita cadeias com exatamente `n` `a`'s seguidos de `n` `b`'s, com `n ≥ 1`.

**Exemplos aceitos:** `ab`, `aabb`, `aaabbb`
**Exemplos rejeitados:** `ε`, `aab`, `abb`, `ba`

**Estratégia:** Ciclo de marcação — marca um `a` como X, varre até o primeiro `b` não marcado e marca como Y, volta ao início. Quando não há mais `a`'s, verifica que só restam Y's até o branco.

---

### Máquina 3 — `aⁿbⁿcⁿ` (Sensível ao Contexto)

Aceita cadeias com exatamente `n` `a`'s, `n` `b`'s e `n` `c`'s, com `n ≥ 1`.

**Exemplos aceitos:** `abc`, `aabbcc`, `aaabbbccc`
**Exemplos rejeitados:** `ε`, `ab`, `aabbc`, `abcabc`

**Estratégia:** Em cada ciclo marca um `a`→X, um `b`→Y e um `c`→Z, depois retorna ao início. Quando não há mais `a`'s, verifica que só restam Y's e Z's até o branco.

---

## ▶️ Como Executar

### Modo interativo

```bash
ruby main.rb
```

Apresenta um menu com as opções:

```
1 - a*b*          (Regular)
2 - a^n b^n       (Livre de Contexto)
3 - a^n b^n c^n   (Sensível ao Contexto)
4 - Rodar todos os testes
```

---

### Modo de testes automáticos

```bash
ruby teste1.rb   # testa a*b*
ruby teste2.rb   # testa aⁿbⁿ
ruby teste3.rb   # testa aⁿbⁿcⁿ
```

---

## 📊 Saída Esperada

Para cada cadeia simulada, a MTU exibe:

```
Entrada:          "aabb"
Descrição:        n=2: dois a's, dois b's
Esperado:         ACEITO
Decidiu?          true
Fita Resultante:  ...
Cursor parou em:  4
Cursor no estado: a
Cursor lendo:     "ba"
Resultado:        ACEITO  ✅ OK
```

O campo **`✅ OK`** indica que a máquina se comportou conforme o esperado — tanto aceitações corretas quanto rejeições corretas são marcadas com `✅`.

---

## 🔬 Detalhes da Simulação

* A MTU opera **sem tabela hash** — a busca de transições é feita por varredura linear, fiel ao modelo teórico.
* Limite de **100.000 passos** por simulação para evitar loops infinitos.
* A fita simulada é dinâmica: cresce conforme necessário durante a execução.
* A decodificação das transições é feita por um parser determinístico baseado na estrutura da codificação, garantindo leitura sequencial sem ambiguidade.
* Após `executar`, os atributos `fita`, `cursor` e `estado` ficam acessíveis para inspeção do estado final da máquina.
