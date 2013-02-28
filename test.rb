# Hello World!
def lol() 
    return 0
end 

#require 'rubygems' # not necessary for Ruby 1.9 and above!
require 'mongo'
include Mongo

require_relative 'configuration'

puts "==============================="

client = Connection.new(DBHOSTNAME)
db     = client['test']
coll   = db['scores']

doc = {"name" => "MongoDB", "type" => "database", "count" => 1, "info" => {"x" => 203, "y" => '102'}}
id = coll.insert(doc)

puts "Thats it!"
puts "go check out the db:"
puts "    mongo #{DBHOSTNAME}"
puts "    use test\n    db.scores.find()"

