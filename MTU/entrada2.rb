require_relative "maquina2"

def ler_cadeia2
  loop do
    print "Digite a cadeia (alfabeto: a, b): "
    $stdout.flush
    entrada = ($stdin.gets || "").strip
    if entrada.empty?
      abort("Rejeitado: cadeia vazia não pertence a a^n b^n (n >= 1)")
    elsif entrada.chars.all? { |c| Maquina2::ALFABETO.include?(c) }
      return entrada
    else
      puts "Cadeia inválida! Use apenas: #{Maquina2::ALFABETO.join(", ")}"
    end
  end
end

def cenario2
  entrada = ler_cadeia2
  cadeia  = Maquina2.codificar(entrada)
  fita    = "#" + Maquina2::LINKER + "$" + cadeia
  [fita, entrada]
end