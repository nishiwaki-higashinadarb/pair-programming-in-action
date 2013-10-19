require 'rspec'
require File.join(File.dirname(__FILE__), '../src/relax_seating')

describe "relax_seating" do

  it "returns a String" do
    output = relax_seating("1:A")
    output.should be_a(String)
  end

  it "size of the output is the number of seats" do
    output = relax_seating("4:A")
    output.size.should eq 4
    # output.should have(4).items
  end
  
  it "1:A" do
    output = relax_seating("1:A")
    output.should eq "A"
  end
  
end