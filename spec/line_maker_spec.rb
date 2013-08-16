require_relative '../line_maker'

##
# Tests LineMaker class
##
describe LineMaker do
	
  before { @rule = LineMaker.new }

  describe "nearest cell to middle of first line" do
    it "should equal 1" do
      #Checks line with odd cell count
      line_one = @rule.first_line(31)
      line_one[15].should eq "1"

      #Checks line with even cell count
      line_two = @rule.first_line(16)
      line_two[8].should eq "1"
    end
  end

  describe "the next line in the iteration" do
    #checks 2nd row with an array of length 11
    it 'should equal ["0", "0", "0", "0", "1", "1", "1", "0", "0", "0", "0"]' do
      first_one = @rule.first_line(11)
      second_one = @rule.next_line(first_one)

      second_one.should eq ["0", "0", "0", "0", "1", "1", "1", "0", "0", "0", "0"]
    end
    
    #checks 3rd row with an array of length 11
    it 'should equal ["0", "0", "0", "1", "1", "0", "0", "1", "0", "0", "0"]' do
      first_one = @rule.first_line(11)
	    second_one = @rule.next_line(first_one)
	    third_one = @rule.next_line(second_one)

	    third_one.should eq ["0", "0", "0", "1", "1", "0", "0", "1", "0", "0", "0"]
    end

    #checks final row with an array of length 11
    it 'last line of array of length 11 should equal ["1", "1", "0", "1", "1", "1", "1", "0", "1", "1", "1"]' do
      last_line = @rule.next_line(["0", "1", "1", "0", "0", "1", "0", "0", "0", "1", "0"])
    end
  end

end
