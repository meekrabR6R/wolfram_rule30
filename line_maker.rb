=begin
  * Name: Line Maker
  * Description: Processes arrays according to Wolfram's Rule 30.
  * Author: Nicholas Miano
  * Date: 08/14/2013
=end

##
# Holds functionality which processes lines according to the rule set of
# Wolfram's Rule 30. 
##
class LineMaker

  # Rule set for Wolfram's Rule 30
  RULE_SET = ['111', '110', '101', '100', '011', '010', '001', '000']

  ##
  # Makes first row
  # @param: cell_count - length of array
  # @return: cells - first line (with a single 'on' cell)
  ##
  def first_line(cell_count)
    cells = []
    cell_count.times do |n|
      cells[n] = "0"
      cells[n] = "1" if n = cell_count/2
    end
    cells
  end

  ##
  # Makes all succeeding lines
  # @param: last_line - Immediately preceding line
  # @return: next_line - Newly processed line
  ##
  def next_line(last_line)
    next_line = last_line.dup

    ( 0..last_line.length-1 ).each do |n|
      #3-cell chunks used to determine on/off status of cells in next line
      chunk = "0#{last_line[n]}#{last_line[n+1]}" if n == 0
      chunk = "#{last_line[n-1]}#{last_line[n]}0" if n == last_line.length-1
      chunk = "#{last_line[n-1]}#{last_line[n]}#{last_line[n+1]}" unless n == 0 || n == last_line.length-1
	  
      if( chunk == RULE_SET[3] || chunk === RULE_SET[4] || chunk === RULE_SET[5] || chunk === RULE_SET[6] )
        next_line[n] = "1"
      else
        next_line[n] = "0"
      end
      
    end
    next_line
  end

end
