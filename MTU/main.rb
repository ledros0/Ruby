require_relative "mtu"
require_relative "entrada1"
require_relative "entrada2"
require_relative "entrada3"
require_relative "teste1"
require_relative "teste2"
require_relative "teste3"

puts "=" * 60
puts "  Máquina de Turing Universal (MTU)"
puts "=" * 60
puts "Escolha a linguagem:"
puts "  1 - a*b*          (Regular)"
puts "  2 - a^n b^n       (Livre de Contexto)"
puts "  3 - a^n b^n c^n   (Sensível ao Contexto)"
puts "  4 - Rodar todos os testes"
print "Opção: "
$stdout.flush

op = ($stdin.gets || "").strip.to_i

if op == 4
  rodar_testes1
  rodar_testes2
  rodar_testes3
  exit
end

fita, entrada =
  case op
  when 1 then cenario1
  when 2 then cenario2
  when 3 then cenario3
  else
    puts "Opção inválida!"
    exit 1
  end

puts "-" * 40
puts "Cadeia: \"#{entrada}\""
puts "Simulando..."

mt = MTU.new(fita)
resultado = mt.executar

puts "Entrada: #{entrada}"
puts "Decidiu? #{resultado}"
puts "Fita Resultante: #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
puts "Cursor está lendo \"#{mt.fita[mt.cursor]}\""
puts
puts resultado ? "ACEITO ✅" : "REJEITADO ❌"