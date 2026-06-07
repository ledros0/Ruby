module Maquina1
  Q0 = "aa"
  Q1 = "aaaa"
  QF = "a"

  SIM_A  = "bbba"     
  SIM_B  = "bbbbbba"  
  BRANCO = "ba"       

  DIR = "cc"
  ESQ = "c"

  ALFABETO = %w[a b]

  D1 = Q0 + SIM_A  + Q0 + SIM_A  + DIR  
  D2 = Q0 + SIM_B  + Q1 + SIM_B  + DIR 
  D3 = Q1 + SIM_B  + Q1 + SIM_B  + DIR  
  D4 = Q0 + BRANCO + QF + BRANCO + DIR  
  D5 = Q1 + BRANCO + QF + BRANCO + DIR  

  LINKER = D1 + D2 + D3 + D4 + D5

  def self.codificar(entrada)
    entrada.chars.map { |c| c == "a" ? SIM_A : SIM_B }.join + BRANCO
  end
end