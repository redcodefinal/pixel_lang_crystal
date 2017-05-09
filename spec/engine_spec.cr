require "spec"
require "../src/pixel_lang"

describe AutoEngine do
  it "should start" do
    e = AutoEngine.new("test", Instructions.new(10, 10))
  end

  it "should run a simple program 1" do
    i = Instructions.new(3, 1)
    s = Start.new(C24.new(0x100000))
    s.value[:direction] = 1_u32    
    i[0,0] = s
    i[1,0] = OutputChar.new(C24.new(0xB00042))    
    i[2,0] = End.new(C24.new(0x0))
    e = AutoEngine.new("Test", i)
    e.pistons.size.should eq(1)
    e.run
    e.output.should eq("B")
  end

  it "should run a simple program 2" do
    i = Instructions.new(1, 3)
    i[0,2] = Start.make(:up, 0)
    i[0,1] = OutputChar.new(C24.new(0xB00044))    
    i[0,0] = End.new(C24.new(0x0))
    e = AutoEngine.new("Test", i)
    e.pistons.size.should eq(1)
    e.run
    e.output.should eq("D")
  end

  it "should run a simple program 3" do
    i = Instructions.new(1, 5)
    i[0, 0] = Start.make(:down, 0)
    i[0, 1] = Insert.new(C24.new(0x80000A))
    i[0, 2] = Insert.new(C24.new(0x800014))
    i[0, 3] = Arithmetic.make(:i, 0, :+, :i, 0, :o, 0)
    i[0, 4] = End.new(C24.new(0x0))
    e = AutoEngine.new("Test", i)
    e.pistons.size.should eq(1)
    e.run
    e.output.should eq("30")
  end
end