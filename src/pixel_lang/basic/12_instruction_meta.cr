require "./../meta_instruction"

abstract class InstructionMeta < MetaInstruction
  def self.control_code
    0xC
  end
end