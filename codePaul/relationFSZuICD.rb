require_relative 'common'

exit
#this creates the fs - icd code relation and has to be run only once
#SCRATCH THIS, this takes waaay too long. Better run the server side JavaScript code in relationFSZuICD.js on the db.
#
# speed up by chaching fs
fs = []
$db_fachgebieteUndSpezialisierungen.find().each { |b| fs << b }
#fs.each {|b| puts b}

# fill relation
i = 0
$db_icd["de"].find().each { |icd_entry|
  fs.each { |fs_entry|
    rel = {"fs_code" => fs_entry["code"], "icd_code" => icd_entry["code"]}
    $db_relationFSZuICD.insert(rel)
    #puts String(a["code"]) + ";" + String(b["code"] )

  }
  i += 1
  putc "." # if i % 10 == 0
}
puts "relationFSZuICD created."




