require_relative "mtu"
require_relative "maquina1"

CASOS_1 = [
  ["",       true,  "vazia (ε pertence a a*b*)"],
  ["a",      true,  "só um a"],
  ["aaa",    true,  "só a's"],
  ["b",      true,  "só um b"],
  ["bbb",    true,  "só b's"],
  ["ab",     true,  "um a, um b"],
  ["aabb",   true,  "dois a's, dois b's"],
  ["aaabbb", true,  "três a's, três b's"],
  ["aabbb",  true,  "dois a's, três b's (quantidades diferentes são ok)"],
  ["aaabb",  true,  "três a's, dois b's"],
  ["ba",     false, "b antes de a — inválido"],
  ["abba",   false, "a após b — inválido"],
  ["aabba",  false, "misturado — inválido"],
  ["bba",    false, "começa com b, termina com a — inválido"],
]

def rodar_testes1
  puts "=" * 60
  puts "  CENÁRIO 1 — Linguagem Regular: a*b*"
  puts "=" * 60

  acertos = 0
  CASOS_1.each do |entrada, esperado, descricao|
    cadeia    = Maquina1.codificar(entrada)
    fita      = "#" + Maquina1::LINKER + "$" + cadeia
    mt        = MTU.new(fita)
    resultado = mt.executar

    status    = resultado == esperado ? "✅ OK " : "❌ FALHOU"
    decisao   = resultado ? "ACEITO" : "REJEITADO"
    acertos  += 1 if resultado == esperado

    puts "-" * 60
    puts "Entrada:          \"#{entrada}\""
    puts "Descrição:        #{descricao}"
    puts "Esperado:         #{esperado ? 'ACEITO' : 'REJEITADO'}"
    puts "Decidiu?          #{resultado}"
    puts "Fita Resultante:  #{mt.fita}"
    puts "Cursor parou em:  #{mt.cursor}"
    puts "Cursor no estado: #{mt.estado}"
    puts "Cursor lendo:     \"#{mt.fita[mt.cursor]}\""
    puts "Resultado:        #{decisao}  #{status}"
  end

  puts "=" * 60
  puts "  #{acertos}/#{CASOS_1.size} casos corretos"
  puts "=" * 60
end

rodar_testes1 if __FILE__ == $0