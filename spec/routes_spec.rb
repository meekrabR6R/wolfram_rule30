require_relative '../routes'
require 'rack/test'

set :environment, :test

def app
  Sinatra::Application
end

#tests app routes/controllers
describe 'Routes' do
  
  include Rack::Test::Methods	
  
  #makes sure index loads correctly
  it "should load the home page" do
    get '/'
	  last_response.should be_ok
	end

  #checks various warnings
  it "should return a warning" do
    post '/', params = { array_length: 'XYZ'}
	  last_response.body.should include("Only Numbers Please!")

	  post '/', params = { array_length: '2'}
	  last_response.body.should include("Length Must be >= 3 And <= 75!")

	  post '/', params = { array_length: '76'}
	  last_response.body.should include("Length Must be >= 3 And <= 75!")
  end

  #makes sure correct next line is sent back to client
  it "should return the next line" do
    post '/getline', params = { last_line: '["0","0","0","1","0","0","0"]'}
	  last_response.body.should eq "0011100"
  end

end
