require 'sinatra'
require 'erb'
require 'mongo'
def relative(path)
    File.join(File.expand_path(File.dirname(__FILE__)), path)
end

set :public_folder, relative(".")

require_relative '../common.rb'

set :port, 8004
enable :sessions


get "/index.html" do
    return "We even had cake for you...\n\nOh, and btw, the DB knows #{$db_icd["de"].find().count()} ICDs"
end
