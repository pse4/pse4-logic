require_relative 'common'



fg = {}
puts "fetching fachgebieteUndSpezialisierungen..."
$db_fachgebieteUndSpezialisierungen.find().each {|b| fg[Integer(b["code"])] = b["de"]}



loop do

print "enter icd code: " 
c = gets
c.gsub!("\n", "")
c.gsub!("\r", "")
puts "icd code '#{c}'"

cc = $db_icd["de"].find({"code" => c}).next()

puts "#{cc["text"]} <=> "
$db_relationFSZuICD.find({"icd_code" => c} ).sort({
    "icd_fs_google_de" => -1, "icd_fs_bing_de" => -1, "icd_fs_yahoo_de" => -1}).each {|t|

    printf "%-10d %-10d %-10d %s\n",  
        t["icd_fs_google_de"] || -1,
        t["icd_fs_bing_de"] || -1, 
        t["icd_fs_yahoo_de"] || -1, 
        fg[Integer(t["fs_code"])]
}

end
