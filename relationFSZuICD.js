// first do use relationFSZuICD and db.createCollection("relationFSZuICD")
// run via mongo pse4.iam.unibe.ch relationFSZuICD.js
// http://docs.mongodb.org/manual/tutorial/write-scripts-for-the-mongo-shell/

conn = new Mongo("pse4.iam.unibe.ch");
db = conn.getDB("relationFSZuICD");
db.relationFSZuICD.drop();
db.createCollection("relationFSZuICD");

var fs = db.getSiblingDB('fachgebieteUndSpezialisierungen').fachgebieteUndSpezialisierungen.find({}, {code:1, _id:0}); 
var fss = new Array();

fs.forEach(function (fs_entry) {fss.push(fs_entry);})
print(fss.length);

var j = 0;

var icd = db.getSiblingDB('icd_2012_ch').de.find({}, {code:1, _id:0}); 
icd.forEach(function (icd_entry) {
    for (i = 0; i < fss.length; i++) {
        fs_entry = fss[i];
        db.relationFSZuICD.insert(
            {"fs_code" : fs_entry.code, "icd_code" : icd_entry.code});
    }
    j += 1;

    if (j % 100 == 0) print(icd_entry.code + " finished, "+db.relationFSZuICD.find().count());
});


