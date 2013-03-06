require 'sinatra'
require 'erb'

def relative(path)
    File.join(File.expand_path(File.dirname(__FILE__)), path)
end

set :public_folder, relative(".")
set :port, 80
enable :sessions
require 'net/http'

require 'uri'

def open(url)
  Net::HTTP.get(URI.parse(url))
end

get "/index.html" do
    return "Hello, and the backend says: " + Net::HTTP.get('localhost', '/index.html', 8004)
end
 

