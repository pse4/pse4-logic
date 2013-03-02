require_relative 'common'
require_relative 'googlerequests'

# Hello World!
def lol() 
    return 0
end 

puts "==============================="

k = "Cholera" 
#puts googleCount(k)


threads = []

t1 = Time.now

p = ThreadPool.new(1) # if you put too many, google knows you're a bot

fg = []
$db_fachgebiete.find().each {|b| fg << b}

fg.each {|b| puts b}
$db_icd["de"].find().each {|a| 
    #puts a["text"]

fg.each {|b|
   #threads << Thread.new([a,b]) 
   # p.schedule([a,b]) { |a,b|# do ... end does the same 
#putc "."
      # puts "hi" 
    puts String(a["code"]) + ";" + String(b["code"] )
    # + ";" + String(googleCount(a["text"]+b["de"]))

  # }


}

}

p.shutdown

threads.each { |aThread|  aThread.join }
puts "Took "+String(Time.now - t1)
# equivalent:
#$db_fachgebiete.find().each {|a| puts a}
#$db_icd["de"].find().each {|a| puts a["text"]}


puts "Done!"
gets



doc = {"name" => "MongoDB", "type" => "database", "count" => 1, "info" => {"x" => 203, "y" => '102'}}
id = $db_scores.insert(doc)

puts "Thats it!"
puts "go check out the db:"
puts "    mongo #{DBHOSTNAME}"
puts "    use test\n    db.scores.find()"

