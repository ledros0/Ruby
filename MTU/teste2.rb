require_relative "mtu"
require_relative "maquina2"

CASOS_2 = [
  ["ab",            true,  "n=1: um a, um b"],
  ["aabb",          true,  "n=2: dois a's, dois b's"],
  ["aaabbb",        true,  "n=3: três a's, três b's"],
  ["aaaabbbb",      true,  "n=4: quatro a's, quatro b's"],
  ["aaaaabbbbb",    true,  "n=5: cinco a's, cinco b's"],
  ["",              false, "vazia — n=0 não pertence à linguagem"],
  ["a",             false, "só a's, sem b's"],
  ["b",             false, "só b's, sem a's"],
  ["aab",           false, "dois a's, um b — quantidades diferentes"],
  ["abb",           false, "um a, dois b's — quantidades diferentes"],
  ["aabbb",         false, "dois a's, três b's"],
  ["aaabb",         false, "três a's, dois b's"],
  ["ba",            false, "b antes de a — inválido"],
  ["aabbaabb",      false, "concatenação de dois pares — inválido"],
]

def rodar_testes2
  puts "=" * 60
  puts "  CENÁRIO 2 — Linguagem Livre de Contexto: aⁿbⁿ"
  puts "=" * 60

  acertos = 0
  CASOS_2.each do |entrada, esperado, descricao|
    cadeia    = Maquina2.codificar(entrada)
    fita      = "#" + Maquina2::LINKER + "$" + cadeia
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
  puts "  #{acertos}/#{CASOS_2.size} casos corretos"
  puts "=" * 60
end

rodar_testes2 if __FILE__ == $0