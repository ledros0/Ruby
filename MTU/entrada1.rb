require_relative "maquina1"

def ler_cadeia1
  loop do
    print "Digite a cadeia (alfabeto: a, b): "
    $stdout.flush
    entrada = ($stdin.gets || "").strip
    if entrada.empty?
      return ""  # vazia é válida para a*b*
    elsif entrada.chars.all? { |c| Maquina1::ALFABETO.include?(c) }
      return entrada
    else
      puts "Cadeia inválida! Use apenas: #{Maquina1::ALFABETO.join(", ")}"
    end
  end
end

def cenario1
  entrada = ler_cadeia1
  cadeia  = Maquina1.codificar(entrada)
  fita    = "#" + Maquina1::LINKER + "$" + cadeia
  [fita, entrada]
end