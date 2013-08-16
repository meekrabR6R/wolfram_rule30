require 'sinatra'
require 'json'
require_relative 'line_maker'

##
# New home page with default value
# for array length
##
get '/' do
  erb :home, locals: { array_length: 31 }
end

##
# Home page with either a validation warning,
# or a user defined array length.
##
post '/' do
  if( !params[:array_length].match( /\A[+-]?\d+?(\.\d+)?\Z/ ) )
    erb :home, locals: { warning: "Only Numbers Please!", array_length: 31 }
  else
    line = LineMaker.new.first_line params[:array_length].to_i

 	if( line.length < 3 || line.length > 75 )
 	  erb :home, locals: { warning: "Length Must be >= 3 And <= 75!", array_length: 31 }
 	else
 	  erb :home, locals: { array: line, array_length: line.length } 
 	end
  end
end

##
# Returns next line
##
post '/getline' do
  rule = LineMaker.new 
  json_line = params[:last_line]
  line = JSON.parse( json_line )
  rule.next_line line
end