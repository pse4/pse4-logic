# encoding: utf-8
require_relative 'common'
require_relative 'googlerequests'

# Hello World!
def lol()
  return 0
end

puts "==============================="


k = "Sonstige näher bezeichnete Salmonelleninfektionen Orthopädische Chirurgie"
t1 = Time.now
puts yahooCount(k)


puts "Took "+String(Time.now - t1)


threads = []
t1 = Time.now

ts = 30

p = ThreadPool.new(ts) # if you put too many, google knows you're a bot

t0 = Time.now
$i = 0
fg = {}
$db_fachgebieteUndSpezialisierungen.find().each { |b| fg[Integer(b["code"])] = b["de"] }
puts ARGV[1]
$db_relationFSZuICD.find({"icd_fs_yahoo_de" => {"$exists" => false}}).each { |kv|

  #p.schedule(kv) {|kv|

  begin
    icd_text = ""
    $db_icd["de"].find({"code" => kv["icd_code"]}).each { |a| icd_text = a["text"] }
    fg_code = Integer(kv["fs_code"])
    fg_text = fg[fg_code]
    gc = yahooCount(icd_text+" "+fg_text)
    icd_code=kv["icd_code"]
    puts "#{icd_code};#{fg_code};#{icd_text};#{fg_text}=>#{gc}"

    doc = {"fs_code" => fg_code, "icd_code" => icd_code}
    #puts "put"
    r = $db_relationFSZuICD.update(doc, {"$set" => {"icd_fs_yahoo_de" => gc}})
    #puts "put ok"
    throw "couldn't update db" if r != true && !r["updatedExisting"]


  rescue => m
    puts m
  end

  #}
  #
  sleep 0.5
  if 0
    $i+=1
    if $i % ts == 0
      #kkk
      p.shutdown
      #t1 = Time.now
      p = ThreadPool.new(ts) # if you put too many, google knows you're a bot
      #puts Time.now - t1
      d = Time.now - t0
      puts "Took #{d}, #{ts/d} items/s"

      t0 = Time.now
      puts $i
    end

  end


}


exit


