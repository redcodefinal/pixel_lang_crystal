require "./c24"

class Instruction
  @@instructions = [] of self.class

  def self.instructions
    @@instructions
  end

  def self.find_instruction(c24)
    i = instructions.find {|i| i.match c24 }
    if i.nil?
      fail "INSTRUCTION NOT FOUND #{c24.to_int_hex}"
    end
    i.as(Instruction.class)
  end
  
  macro inherited
    Instruction.instructions << {{@type}}
  end

  def self.control_code : Int32
    -1
  end

  def self.match(c24 : C24) : Bool
    control_code == c24[:control_code]
  end

  getter value : C24

  def initialize(@value : C24)
  end

  def run(piston)
    self.class.run(piston)
  end
end