require_relative 'common'

# fg
if 0==1
$db_fachgebieteUndSpezialisierungen.find({}, {:fields => {"_id" => 0, "de" => 1, "code"=> 1}}).each {|b| 
    puts b["code"]
    puts b["de"]
}
exit
end

$db_icd["de"].find({}, {:fields => {"_id" => 0, "text" => 1, "code" => 1}}).each {|b|
    puts b["code"]
    puts b["text"]
}

