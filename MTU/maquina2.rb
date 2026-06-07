module Maquina2
  Q0 = "aa"
  Q1 = "aaaa"
  Q2 = "aaaaaa"
  Q3 = "aaaaaaaa"    
  QF = "a"

  SIM_A  = "bbba"       
  SIM_B  = "bbbbbba"    
  MAR_A  = "bbbbbbba"   
  MAR_B  = "bbbbbbbbba" 
  BRANCO = "ba"

  DIR = "cc"
  ESQ = "c"

  ALFABETO = %w[a b]

  D1  = Q0 + SIM_A  + Q1 + MAR_A  + DIR 
  D2  = Q1 + SIM_A  + Q1 + SIM_A  + DIR 
  D3  = Q1 + MAR_B  + Q1 + MAR_B  + DIR  
  D4  = Q1 + SIM_B  + Q2 + MAR_B  + ESQ  
  D5  = Q2 + MAR_B  + Q2 + MAR_B  + ESQ 
  D6  = Q2 + SIM_A  + Q2 + SIM_A  + ESQ  
  D7  = Q2 + MAR_A  + Q0 + MAR_A  + DIR  
  D8  = Q0 + MAR_B  + Q3 + MAR_B  + DIR  
  D9  = Q3 + MAR_B  + Q3 + MAR_B  + DIR  
  D10 = Q3 + BRANCO + QF + BRANCO + DIR  

  LINKER = D1 + D2 + D3 + D4 + D5 + D6 + D7 + D8 + D9 + D10

  def self.codificar(entrada)
    entrada.chars.map { |c| c == "a" ? SIM_A : SIM_B }.join + BRANCO
  end
end