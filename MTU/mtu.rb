class MTU
  attr_reader :fita, :cursor, :estado

  def initialize(fita)
    @fita       = fita + " " * 200
    @cursor     = 0
    @estado     = :qi
    @transicoes = []
    @cadeia     = []
  end

  def executar
    return false unless ler_transicoes
    ler_entrada
    simular
  end

  private

  def ler_transicoes
    estado_l  = ""
    simbolo_l = ""
    estado_d  = ""
    simbolo_e = ""
    movimento = :D

    while @fita[@cursor] != "$"
      char = @fita[@cursor]

      if @estado == :qi && char == "#"
        @estado = :q0
        @cursor += 1
      elsif @estado == :q0 && char == "a"
        estado_l << "a"
        @cursor += 1
      elsif @estado == :q0 && char == "b"
        simbolo_l << "b"
        @estado = :q1
        @cursor += 1
      elsif @estado == :q1 && char == "b"
        simbolo_l << "b"
        @cursor += 1
      elsif @estado == :q1 && char == "a"
        simbolo_l << "a"
        @estado = :q2
        @cursor += 1
      elsif @estado == :q2 && char == "a"
        estado_d << "a"
        @cursor += 1
      elsif @estado == :q2 && char == "b"
        simbolo_e << "b"
        @estado = :q3
        @cursor += 1
      elsif @estado == :q3 && char == "b"
        simbolo_e << "b"
        @cursor += 1
      elsif @estado == :q3 && char == "a"
        simbolo_e << "a"
        @estado = :q4
        @cursor += 1
      elsif @estado == :q4 && char == "c"
        if @fita[@cursor + 1] == "c"
          movimento = :D
          @cursor += 2
        else
          movimento = :E
          @cursor += 1
        end
        @transicoes << [estado_l, simbolo_l, estado_d, simbolo_e, movimento]
        estado_l  = ""
        simbolo_l = ""
        estado_d  = ""
        simbolo_e = ""
        movimento = :D
        @estado   = :q0
      else
        puts "Erro no parser: estado=#{@estado}, char='#{char}', pos=#{@cursor}"
        return false
      end
    end

    @cursor += 1
    true
  end

  def ler_entrada
    bs = 0
    while @fita[@cursor] != " "
      if @fita[@cursor] == "b"
        bs += 1
      else
        @cadeia << ("b" * bs + "a")
        bs = 0
      end
      @cursor += 1
    end
  end

  def simular
    @estado = "aa"
    @cursor = 0
    passos  = 0

    while passos < 100_000
      passos += 1
      simbolo = @cadeia[@cursor] || "ba"
      trans   = @transicoes.find { |t| t[0] == @estado && t[1] == simbolo }

      if trans.nil?
        @fita = @cadeia.join
        return @estado == "a"
      end

      _, _, prox_estado, escreve, mov = trans
      @cadeia[@cursor] = escreve
      @estado = prox_estado
      @cursor += (mov == :D ? 1 : -1)

      if @cursor < 0
        @fita = @cadeia.join
        return false
      end
    end

    @fita = @cadeia.join
    false
  end
end