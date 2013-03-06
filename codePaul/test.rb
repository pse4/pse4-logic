# encoding: utf-8
require_relative 'common'
require_relative 'googlerequests'

# Hello World!
def lol()
  return 0
end

puts "==============================="

puts bingCount("Sonstige näher bezeichnete Salmonelleninfektionen Orthopädische Chirurgie")


k = "Cholera"
t1 = Time.now
puts googleCount(k)


puts "Took "+String(Time.now - t1)

threads = []
t1 = Time.now
p = ThreadPool.new(2) # if you put too many, google knows you're a bot

fg = {}
$db_fachgebieteUndSpezialisierungen.find().each { |b| fg[Integer(b["code"])] = b["de"] }
puts ARGV[1]
$db_relationFSZuICD.find({"icd_fs_google_de" => {"$exists" => false}}).each { |kv|
  #p.schedule(kv) {|kv|
  icd_text = ""
  $db_icd["de"].find({"code" => kv["icd_code"]}).each { |a| icd_text = a["text"] }
  fg_code = Integer(kv["fs_code"])
  fg_text = fg[fg_code]
  gc = googleCount(icd_text+" "+fg_text)
  icd_code=kv["icd_code"]
  puts "#{icd_code};#{fg_code};#{icd_text};#{fg_text}=>#{gc}"

  puts "constructing doc"
  doc = {"fs_code" => fg_code, "icd_code" => icd_code}
  puts "constructed doc"
  puts doc
  r = $db_relationFSZuICD.update(doc, {"$set" => {"icd_fs_google_de" => gc}})
  puts r
  throw "couldn't update db" if r != true && !r["updatedExisting"]

  sleep 1

}


exit


lpool = ThreadPool.new(100)
# 3 requests per second seem to work, but not 10

fg = []
$db_fachgebieteUndSpezialisierungen.find().each { |b| fg << b }
checked = 0
#fg.each {|b| puts b}
foundStartCode = 0
foundStartFs = 0

startCode = "A00" # lowest is A00
startFS = 2 #lowest is 2

$db_icd["de"].find().each { |a|
  #puts a["text"]

  foundStartCode = 1 if foundStartCode != 0 || a["code"] == startCode
  next if foundStartCode == 0

  fg.each { |b|
    foundStartFs = 1 if foundStartFs != 0 || b["code"] == startFS
    next if foundStartFs == 0
    #threads << Thread.new([a,b])
    # p.schedule([a,b]) { |a,b|# do ... end does the same
    #putc "."
    # puts "hi"
    if checked == 0
      puts "checking"
      cc = $db_relationFSZuICD.find(
          {"fs_code" => b["code"], "icd_code" => a["code"]})
      puts "found"
      already = 0
      #puts cc.size
      cc.each { |c|
        puts c
        if c["icd_fs_google_de"] != nil
          #puts "======== ERROR: you are working in a region where the google lookup values have already been calculated -- don't waste your time"
          puts "already calculated for #{b["code"]} #{a["code"]}"
          already = 1
          break
        else
          checked = 1
        end
      }
      next if already
      puts "endcheck"
    end

    p.schedule([a, b]) { |a, b| # not necessary, kept

      begin
        gc = googleCount(a["text"]+" "+b["de"])
        sleep 0.5

      rescue
        puts "fatal"
        exit
      end
      puts String(a["code"]) + ";" + String(b["code"]) + ";" + String(a["text"]) + ";" + String(b["de"]) + "=>" + String(gc);

      throw "couldn't update db" if $db_relationFSZuICD.update(
          {"fs_code" => b["code"], "icd_code" => a["code"]},
          {"$set" => {"icd_fs_google_de" => gc}}
      ) != true

    }


  }

}

p.shutdown

threads.each { |aThread| aThread.join }
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

