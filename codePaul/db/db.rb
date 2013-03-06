client = MongoClient.new(DBHOSTNAME, :pool_size => 50)
db = client['test']
#puts client.database_names[1]+"|"

$db_scores = db['scores']

db = client['icd_2012_ch']
puts "db not found" if db == nil
$db_icd = {}
$db_icd["de"] = db['de']
$db_icd["it"] = db['it']
$db_icd["fr"] = db['fr']

db = client['fachgebieteUndSpezialisierungen']
$db_fachgebiete = db['fachgebiete']
$db_spezialisierungen = db['spezialisierungen']
$db_fachgebieteUndSpezialisierungen = db['fachgebieteUndSpezialisierungen']

db = client['relationFSZuICD']
$db_relationFSZuICD = db['relationFSZuICD']

