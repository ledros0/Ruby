module Maquina3

  Q0 = "aa"
  Q1 = "aaaa"
  Q2 = "aaaaaa"
  Q3 = "aaaaaaaa"
  Q4 = "aaaaaaaaaa"  
  QF = "a"

  SIM_A  = "bbba"         
  SIM_B  = "bbbbbba"      
  SIM_C  = "bbbbbbbba"    
  MAR_A  = "bbbbbbba"    
  MAR_B  = "bbbbbbbbba"    
  MAR_C  = "bbbbbbbbbbba" 
  BRANCO = "ba"

  DIR = "cc"
  ESQ = "c"

  ALFABETO = %w[a b c]

  D1  = Q0 + SIM_A  + Q1 + MAR_A  + DIR  
  D2  = Q0 + MAR_A  + Q0 + MAR_A  + DIR  

  D3  = Q1 + SIM_A  + Q1 + SIM_A  + DIR 
  D4  = Q1 + MAR_B  + Q1 + MAR_B  + DIR 
  D5  = Q1 + SIM_B  + Q2 + MAR_B  + DIR  

  D6  = Q2 + MAR_B  + Q2 + MAR_B  + DIR  
  D7  = Q2 + SIM_B  + Q2 + SIM_B  + DIR  
  D8  = Q2 + MAR_C  + Q2 + MAR_C  + DIR  
  D9  = Q2 + SIM_C  + Q3 + MAR_C  + ESQ  

  D10 = Q3 + SIM_C  + Q3 + SIM_C  + ESQ  
  D11 = Q3 + MAR_C  + Q3 + MAR_C  + ESQ  
  D12 = Q3 + SIM_B  + Q3 + SIM_B  + ESQ  
  D13 = Q3 + MAR_B  + Q3 + MAR_B  + ESQ  
  D14 = Q3 + SIM_A  + Q3 + SIM_A  + ESQ  
  D15 = Q3 + MAR_A  + Q0 + MAR_A  + DIR 

  D16 = Q0 + MAR_B  + Q4 + MAR_B  + DIR  

  D17 = Q4 + MAR_B  + Q4 + MAR_B  + DIR  
  D18 = Q4 + MAR_C  + Q4 + MAR_C  + DIR  
  D19 = Q4 + BRANCO + QF + BRANCO + DIR  

  LINKER = D1  + D2  + D3  + D4  + D5  + D6  + D7  +
           D8  + D9  + D10 + D11 + D12 + D13 + D14 +
           D15 + D16 + D17 + D18 + D19

  def self.codificar(entrada)
    entrada.chars.map do |c|
      case c
      when "a" then SIM_A
      when "b" then SIM_B
      when "c" then SIM_C
      end
    end.join + BRANCO
  end
end