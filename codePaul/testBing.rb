require_relative 'common'
require_relative 'googlerequests'

# Hello World!
def lol()
  return 0
end

puts "==============================="


k = "Cholera"
t1 = Time.now
puts bingCount(k)


puts "Took "+String(Time.now - t1)

threads = []
t1 = Time.now

ts = 50

p = ThreadPool.new(ts) # if you put too many, google knows you're a bot

t0 = Time.now
$i = 0
fg = {}
$db_fachgebieteUndSpezialisierungen.find().each { |b| fg[Integer(b["code"])] = b["de"] }
puts ARGV[1]
it = $db_relationFSZuICD.find({"icd_code" => "Q54"})#{"icd_fs_bing_de" => {"$exists" => false}})
#it.skip(500000)
puts "skipped"

#icd = readHashFromFile('icd_code_de_text.txt')
require 'json'
it.each { |kv|

  p.schedule(kv) { |kv|

    begin
      icd_text = ""
      aa = $db_icd["de"].find_one({"code" => kv["icd_code"]}).inspect
      icd_text = aa["text"]


      puts aa.to_json.to_s
      #icd_text = icd[String(kv["icd_code"])]

      fg_code = Integer(kv["fs_code"])
      fg_text = fg[fg_code]
      gc = bingCount("+"+icd_text+" "+fg_text) # prepend + to force inclusion of first word
      icd_code=kv["icd_code"]
      puts "#{icd_code};#{fg_code};#{icd_text};#{fg_text}=>#{gc}"

      doc = {"fs_code" => fg_code, "icd_code" => icd_code}
      #puts "put"
      r = $db_relationFSZuICD.update(doc, {"$set" => {"icd_fs_bing_de" => gc}})
      #puts "put ok"
      throw "couldn't update db" if r != true && !r["updatedExisting"]


    rescue => m
      puts m
    end

  }
  $i+=1
  if $i % ts == 0
    #sleep 0.5
    p.shutdown
    #t1 = Time.now
    p = ThreadPool.new(ts) # if you put too many, google knows you're a bot
    #puts Time.now - t1
    d = Time.now - t0
    puts "Took #{d}, #{ts/d} items/s"

    t0 = Time.now
    puts $i
  end


}


exit


