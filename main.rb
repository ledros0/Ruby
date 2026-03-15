class AFD
  def initialize(input)
    @chars = input.upcase.chars
    @state = :start
    @finalNumber = ""
    @error = false
    @lvl = 1000
  end
    
  def parse
    @chars.each do |char|
      break if @error
      case @state
      when :start then state_transition(char)
      when :read_M then m_state(char)
      when :read_MM then mm_state(char)
      when :read_MMM then mmm_state(char)
      when :read_D then d_state(char)
      when :read_C_after_D then c_after_d_state(char)
      when :read_CC_after_D then cc_after_d_state(char)
      when :read_CCC_after_D then ccc_after_d_state(char)
      when :read_C then c_state(char)
      when :read_CC then cc_state(char)
      when :read_CCC then ccc_state(char)
      when :read_L then l_state(char)
      when :read_X_after_L then x_after_l_state(char)
      when :read_XX_after_L then xx_after_l_state(char)
      when :read_XXX_after_L then xxx_after_l_state(char)
      when :read_X then x_state(char)
      when :read_XX then xx_state(char)
      when :read_XXX then xxx_state(char)
      when :read_V then v_state(char)
      when :read_I_after_V then i_after_v_state(char)
      when :read_II_after_V then ii_after_v_state(char)
      when :read_III_after_V then iii_after_v_state(char)
      when :read_I then i_state(char)
      when :read_II then ii_state(char)
      when :read_III then iii_state(char)
      end
    end
      
    final_Clean unless @error
      puts "Cadeia aceita = #{@finalNumber}" unless @error
      puts "Conversão = #{conversor(@finalNumber)}" unless @error
  end

  def state_transition(letter)
    case letter
    when "M" then @state = :read_M
    when "D" then @state = :read_D
    when "C" then @state = :read_C
    when "L" then @state = :read_L
    when "X" then @state = :read_X
    when "V" then @state = :read_V
    when "I" then @state = :read_I
    else error! end
  end

  def m_state(char)
    case char
    when "M" then @state = :read_MM
    when "D", "C", "L", "X", "V", "I" then include("M", char)
    else error! end
  end

  def mm_state(char)
    case char
    when "M" then @state = :read_MMM
    when "D", "C", "L", "X", "V", "I" then include("MM", char)
    else error! end
  end

  def mmm_state(char)
    case char
    when "D", "C", "L", "X", "V", "I" then include("MMM", char)
    else error! end
  end

  def d_state(char)
    case char
    when "C" then @state = :read_C_after_D
    when "L", "X", "V", "I" then include("D", char)
    else error! end
  end

  def c_after_d_state(char)
   case char
   when "C" then @state = :read_CC_after_D
   when "L","X","V","I" then include("DC", char)
   else error! end
  end

  def cc_after_d_state(char)
   case char
   when "C" then @state = :read_CCC_after_D
   when "L","X","V","I" then include("DCC", char)
   else error! end
  end

  def ccc_after_d_state(char)
   case char
   when "L","X","V","I" then include("DCCC", char)
   else error! end
  end
    
  def c_state(char)
    case char
    when "M" then check_order(values("C")); @finalNumber << "CM"; @lvl = values("C") - 1; @state = :start
    when "D" then check_order(values("C")); @finalNumber << "CD"; @lvl = values("C") - 1; @state = :start
    when "C" then @state = :read_CC
    when "L", "X", "V", "I" then include("C", char)
    else error! end
  end

  def cc_state(char)
    case char
    when "C" then @state = :read_CCC
    when "L", "X", "V", "I" then include("CC", char)
    else error! end
  end

  def ccc_state(char)
    case char
    when "L", "X", "V", "I" then include("CCC", char)
    else error! end
  end

  def l_state(char)
    case char
    when "X" then @state = :read_X_after_L
    when "V", "I" then include("L", char)
    else error! end
  end

  def x_after_l_state(char)
    case char
    when "X" then @state = :read_XX_after_L
    when "V","I" then include("LX", char)
    else error! end
  end

  def xx_after_l_state(char)
      case char
      when "X" then @state = :read_XXX_after_L
      when "V", "I" then include("LXX", char)
      else error! end
  end

  def xxx_after_l_state(char)
      case char
      when "V", "I" then include("LXXX", char)
      else error! end
  end
    
  def x_state(char)
    case char
    when "C" then check_order(values("X")); @finalNumber << "XC"; @lvl = values("X") - 1; @state = :start
    when "L" then check_order(values("X")); @finalNumber << "XL"; @lvl = values("X") - 1; @state = :start
    when "X" then @state = :read_XX
    when "V", "I" then include("X", char)
    else error! end
  end

  def xx_state(char)
    case char
    when "X" then @state = :read_XXX
    when "V", "I" then include("XX", char)
    else error! end
  end

  def xxx_state(char)
    case char
    when "V", "I" then include("XXX", char)
    else error! end
  end

  def v_state(char)
    case char
    when "I" then check_order(values("V")); @lvl = values("V") - 1; @state = :read_I_after_V
    when "V" then error! 
    else include("V", char) end
  end

  def i_after_v_state(char)
    case char
     when "I" then @state = :read_II_after_V
      else include("VI", char) end
  end

  def ii_after_v_state(char)
     case char
     when "I" then @state = :read_III_after_V
     else include("VII", char) end
  end

  def iii_after_v_state(char)
      error!
  end

  def i_state(char)
    case char
    when "X" then check_order(values("I")); @finalNumber << "IX"; @lvl = 0; @state = :start
    when "V" then check_order(values("I")); @finalNumber << "IV"; @lvl = 0; @state = :start
    when "I" then check_order(values("I")); @state = :read_II
    else error! end 
  end

  def ii_state(char)
    case char
    when "I" then @state = :read_III
    else error! end
  end

  def iii_state(char)
    error! 
  end

  def include(letter, next_Char)
    val = values(letter.chars.last)
    check_order(val)
    @finalNumber << letter
    @state = :start
    state_transition(next_Char)
  end

  def check_order(value)
    if value > @lvl
      error!
    else
      @lvl = value
    end
  end

  def add_roman(letter)
   val = values(letter.chars.last) 
   check_order(val)
   @finalNumber << letter
  end
    
  def final_Clean
    case @state
    when :read_M then add_roman("M")
    when :read_MM then add_roman("MM")
    when :read_MMM then add_roman("MMM")
    when :read_D then add_roman("D")
    when :read_C_after_D then add_roman("DC")
    when :read_CC_after_D then add_roman("DCC")
    when :read_CCC_after_D then add_roman("DCCC")
    when :read_C then add_roman("C")
    when :read_CC then add_roman("CC")
    when :read_CCC then add_roman("CCC")
    when :read_L then add_roman("L")
    when :read_X_after_L then add_roman("LX")
    when :read_XX_after_L then add_roman("LXX")
    when :read_XXX_after_L then add_roman("LXXX")
    when :read_X then add_roman("X")
    when :read_XX then add_roman("XX")
    when :read_XXX then add_roman("XXX")
    when :read_V then add_roman("V")
    when :read_I_after_V then add_roman("VI")
    when :read_II_after_V then add_roman("VII")
    when :read_III_after_V then add_roman("VIII")
    when :read_I then add_roman("I")
    when :read_II then add_roman("II")
    when :read_III then add_roman("III")
    end
  end
  
  def error!
    @error = true
    puts "Sequencia gramatical invalida"
  end

    def values(letter)
      case letter
      when "I" then 1
      when "V" then 5
      when "X" then 10
      when "L" then 50
      when "C" then 100
      when "D" then 500
      when "M" then 1000
      else 0
      end
    end
    
    def conversor(chain)
      total = 0
      chars = chain.chars

      chars.each_with_index do |char, i|
        value = values(char)
        next_char = chars[i+1]
        next_value = values(next_char || "")

        if next_value > value
          total -= value
        else
          total += value
        end
      end
      total
    end
end

tests = ["IIII", "VV", "XXXX", "LL", "CCCC", "DD", "MMMM", "VIV", "VIX", "IVI", "IXI", "IIV", "IIX", "VVX", "VVL", "VVC", "LLC", "LLD", "DDC", "DDM",
  "XXXXI", "XXXXV", "XXXXX", "XXXXL", "XXXXC", "XXXXD", "XXXXM", "CCCCI", "CCCCV", "CCCCX", "CCCCL", "CCCCC", "CCCCD", "CCCCM", "DDDD", "LLLL",
  "VVVV", "IIIII", "MMMMM", "IIV", "IIX", "IIL", "IIC", "IID", "IIM", "VX", "VL", "VC", "VD", "VM", "XD", "XM", "LC", "LD", "LM", "DM",
  "IXV", "IVX", "IXX", "IVV", "XLL", "XCC", "XDD", "XMM", "CLL", "CDD", "CMM", "DMM", "VIX", "VIV", "LXL", "XCX", "CDC", "CMC", "XCD", "XCM",
  "IXL", "IXC", "IXD", "IXM", "VXL", "VXC", "VXD", "VXM", "VCD", "VCM", "XLM", "XDM", "LDM", "LCM", "CDCD", "CMCM", "XLXL", "XCXC", "IVIV",
  "IXIX", "XCL", "XCD", "XCM", "CDC", "CDD", "CDM", "MXM", "CXC", "LXL", "XIX", "VIV", "MCMXCVIIII", "MCMXCVX", "MCMXCVL", "MCMXCVC", "MCMXCVD",
  "MCMXCVM", "CCCM", "CCCDX", "DCCCLXXXX", "DCCCLXXXXI", "DCCCLXXXXV", "DCCCLXXXXX", "MMMMCM", "MMMMCD", "MMMMXC", "MMMMXL", "MMMMIX", "MMMMIV",
  "IIII", "IIIII", "IIIIII", "IIIIIII", "IIIIIIII", "IIIIIIIII", "VV", "VVV", "VVVV", "VVVVV", "XXXX", "XXXXX", "XXXXXX", "XXXXXXX", "XXXXXXXX",
  "LL", "LLL", "LLLL", "LLLLL", "CCCC", "CCCCC", "CCCCCC", "CCCCCCC", "DD", "DDD", "DDDD", "DDDDD", "MMMM", "MMMMM", "MMMMMM", "MMMMMMM",
  "IIV", "IIIV", "IIIIV", "IIX", "IIIX", "IIIIX", "IIL", "IIIL", "IIIIL", "IIC", "IIIC", "IIIIC", "IID", "IIID", "IIIID", "IIM", "IIIM", "IIIIM",
  "VVX", "VVVX", "VVVL", "VVVC", "VVVD", "VVVM", "VVL", "VVC", "VVD", "VVM", "LLC", "LLLC", "LLLD", "LLLM", "LLD", "LLM", "DDC", "DDDC", "DDDM",
  "DDM", "IVI", "IVII", "IVIII", "IVIV", "IVV", "IVX", "IVL", "IVC", "IVD", "IVM", "IXI", "IXII", "IXIII", "IXIV", "IXV", "IXVI", "IXVII",
  "IXVIII", "IXIX", "IXX", "IXL", "IXC", "IXD", "IXM", "XLX", "XLXX", "XLXXX", "XLXL", "XLV", "XLXC", "XLXD", "XLXM", "XCX", "XCXX", "XCXXX",
  "XCXC", "XCL", "XCD", "XCM", "CDC", "CDCC", "CDCCC", "CDCD", "CDL", "CDX", "CDV", "CDM", "CMC", "CMCC", "CMCCC", "CMCM", "CMD", "CML", "CMX",
  "CMV", "VX", "VXX", "VXXX", "VL", "VLL", "VLLL", "VC", "VCC", "VCCC", "VD", "VDD", "VDDD", "VM", "VMM", "VMMM", "LC", "LCC", "LCCC", "LD",
  "LDD", "LDDD", "LM", "LMM", "LMMM", "DM", "DMM", "DMMM", "IL", "IC", "ID", "IM", "XD", "XM", "VX", "VL", "VC", "VD", "VM", "LC", "LD", "LM",
  "DM", "XCL", "XCD", "XCM", "CDC", "CDD", "CDM", "MXM", "CXC", "LXL", "XIX", "VIV", "MCMXCVIIII", "MCMXCVX", "MCMXCVL", "MCMXCVC", "MCMXCVD",
  "MCMXCVM", "IIII", "VV", "XXXX", "LL", "CCCC", "DD", "MMMM", "IIIII", "VVV", "XXXXX", "LLL", "CCCCC", "DDD", "MMMMM", "IIV", "IIX", "IL",
  "IC", "ID", "IM", "VX", "VL", "VC", "VD", "VM", "XD", "XM", "LC", "LD", "LM", "DM", "IVI", "IXI", "XLX", "XCX", "CDC", "CMC", "IVIV", "IXIX",
  "XLXL", "XCXC", "CDCD", "CMCM", "VIV", "VIX", "LXL", "LXC", "XCD", "XCM", "IXL", "IXC", "IXD", "IXM", "VXL", "VXC", "VXD", "VXM", "VCD", "VCM",
  "XLM", "XDM", "LDM", "LCM", "MCMXCIXI", "MCMXCIXV", "MCMXCIXX", "MCMXCIXL", "MCMXCIXC", "MCMXCIXD", "MCMXCIXM", "CMM", "CDD", "XLL", "XCC",
  "IVV", "IXX", "IVV", "IXX", "XLL", "XCC", "CDD", "CMM", "VV", "LL", "DD", "IIII", "XXXX", "CCCC", "MMMM", "IVI", "IXI", "XLX", "XCX", "CDC",
  "CMC", "VIV", "LXL", "XCD", "IIV", "IIX", "VVV", "LLL", "DDD", "IIIII", "XXXXX", "CCCCC", "MMMMM", "VIX", "LXC", "XCM", "IXL", "IXC", "IXD",
  "IXM", "VXL", "VXC", "VXD", "VXM", "VCD", "VCM", "XLM", "XDM", "LDM", "LCM", "CDL", "CDX", "CDV", "CDI", "CML", "CMX", "CMV", "CMI", "XLD",
  "XLM", "XDV", "XDI", "XCV", "XCI", "IVL", "IVC", "IVD", "IVM", "IXL", "IXC", "IXD", "IXM", "XLX", "XCX", "CDC", "CMC", "XCL", "XCD", "XCM",
  "VIV", "VIX", "VXL", "VXC", "VXD", "VXM", "VCD", "VCM", "LXL", "LXC", "LXD", "LXM", "LCM", "LCD", "DCD", "DCM", "CMC", "CMD", "IVI", "IXI",
  "XLX", "XCX", "CDC", "CMC", "IVIV", "IXIX", "XLXL", "XCXC", "CDCD", "CMCM", "VIV", "VIX", "LXL", "LXC", "XCD", "XCM", "IXL", "IXC", "IXD",
  "IXM", "VXL", "VXC", "VXD", "VXM", "VCD", "VCM", "XLM", "XDM", "LDM", "LCM", "IIII", "VV", "XXXX", "LL", "CCCC", "DD", "MMMM", "IIIII", "VVV",
  "XXXXX", "LLL", "CCCCC", "DDD", "MMMMM", "IIV", "IIX", "IL", "IC", "ID", "IM", "VX", "VL", "VC", "VD", "VM", "XD", "XM", "LC", "LD", "LM",
  "DM", "IVI", "IXI", "XLX", "XCX", "CDC", "CMC", "IVIV", "IXIX", "XLXL", "XCXC", "CDCD", "CMCM", "VIV", "VIX", "LXL", "LXC", "XCD", "XCM",
  "IXL", "IXC", "IXD", "IXM", "VXL", "VXC", "VXD", "VXM", "VCD", "VCM", "XLM", "XDM", "LDM", "LCM", "IIII", "VV", "XXXX", "LL", "CCCC", "DD",
  "MMMM", "IIIII", "VVV", "XXXXX", "LLL", "CCCCC", "DDD", "MMMMM", "IIV", "IIX", "IL", "IC", "ID", "IM", "VX", "VL", "VC", "VD", "VM", "XD",
  "XM", "LC", "LD", "LM", "DM", "IVI", "IXI", "XLX", "XCX", "CDC", "CMC", "IVIV", "IXIX", "XLXL", "XCXC", "CDCD", "CMCM", "VIV", "VIX", "LXL",
  "LXC", "XCD", "XCM", "IXL", "IXC", "IXD", "IXM", "VXL", "VXC", "VXD", "VXM", "VCD", "VCM", "XLM", "XDM", "LDM", "LCM", "MMMM", "MMMMM", "MMMCMXCIXI",
  "MCMXCIXV", "MCMXCIXX", "MCMXCIXL", "MCMXCIXC", "MCMXCIXD", "MCMXCIXM", "CMM", "CDD", "XLL", "XCC", "IVV", "IXX", "V", "X", "L", "C", "D", "M",
  "IVV", "IXX", "XLL", "XCC", "CDD", "CMM", "VV", "LL", "DD", "IIII", "XXXX", "CCCC", "MMMM", "IVI", "IXI", "XLX", "XCX", "CDC", "CMC", "VIV",
  "LXL", "XCD", "IIV", "IIX", "VVV", "LLL", "DDD", "IIIII", "XXXXX", "CCCCC", "MMMMM", "VIX", "LXC", "XCM", "IXL", "IXC", "IXD", "IXM", "VXL",
  "VXC", "VXD", "VXM", "VCD", "VCM", "XLM", "XDM", "LDM", "LCM", "IIII", "VV", "XXXX", "LL", "CCCC", "DD", "MMMM", "IIIII", "VVV", "XXXXX",
  "LLL", "CCCCC", "DDD", "MMMMM", "IIV", "IIX", "IL", "IC", "ID", "IM", "VX", "VL", "VC", "VD", "VM", "XD", "XM", "LC", "LD", "LM", "DM", "IVI",
  "IXI", "XLX", "XCX", "CDC", "CMC", "IVIV", "IXIX", "XLXL", "XCXC", "CDCD", "CMCM", "VIV", "VIX", "LXL", "LXC", "XCD", "XCM", "IXL", "IXC",
  "IXD", "IXM", "VXL", "VXC", "VXD", "VXM", "VCD", "VCM", "XLM", "XDM", "LDM", "LCM", "IIII", "VV", "XXXX", "LL", "CCCC", "DD", "MMMM", "IIIII",
  "VVV", "XXXXX", "LLL", "CCCCC", "DDD", "MMMMM", "IIV", "IIX", "IL", "IC"]

tests.each do |t|
  puts "\nTeste: #{t}"
  AFD.new(t).parse
end
#adf = AFD.new("vix").parse