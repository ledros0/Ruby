require_relative "maquina3"

def ler_cadeia3
  loop do
    print "Digite a cadeia (alfabeto: a, b, c): "
    $stdout.flush
    entrada = ($stdin.gets || "").strip
    if entrada.empty?
      abort("Rejeitado: cadeia vazia não pertence a a^n b^n c^n (n >= 1)")
    elsif entrada.chars.all? { |c| Maquina3::ALFABETO.include?(c) }
      return entrada
    else
      puts "Cadeia inválida! Use apenas: #{Maquina3::ALFABETO.join(", ")}"
    end
  end
end

def cenario3
  entrada = ler_cadeia3
  cadeia  = Maquina3.codificar(entrada)
  fita    = "#" + Maquina3::LINKER + "$" + cadeia
  [fita, entrada]
end