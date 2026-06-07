require_relative "mtu"
require_relative "maquina3"

CASOS_3 = [
  ["abc",             true,  "n=1: um a, um b, um c"],
  ["aabbcc",          true,  "n=2: dois a's, dois b's, dois c's"],
  ["aaabbbccc",       true,  "n=3: três a's, três b's, três c's"],
  ["aaaabbbbcccc",    true,  "n=4: quatro de cada"],
  ["aaaaabbbbbccccc", true,  "n=5: cinco de cada"],
  ["",                false, "vazia — n=0 não pertence à linguagem"],
  ["ab",              false, "sem c's"],
  ["abcabc",          false, "abcabc — repetição inválida"],
  ["aabbc",           false, "dois a's, dois b's, um c"],
  ["aabbccc",         false, "dois a's, dois b's, três c's"],
  ["abbc",            false, "um a, dois b's, um c"],
  ["aabc",            false, "dois a's, um b, um c"],
  ["abcc",            false, "um a, um b, dois c's"],
  ["bca",             false, "ordem errada — inválido"],
  ["acb",             false, "ordem errada — inválido"],
  ["aaabbbcc",        false, "três a's, três b's, dois c's"],
]

def rodar_testes3
  puts "=" * 60
  puts "  CENÁRIO 3 — Linguagem Sensível ao Contexto: aⁿbⁿcⁿ"
  puts "=" * 60

  acertos = 0
  CASOS_3.each do |entrada, esperado, descricao|
    cadeia    = Maquina3.codificar(entrada)
    fita      = "#" + Maquina3::LINKER + "$" + cadeia
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
  puts "  #{acertos}/#{CASOS_3.size} casos corretos"
  puts "=" * 60
end

rodar_testes3 if __FILE__ == $0
