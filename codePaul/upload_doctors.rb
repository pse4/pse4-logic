#encoding: utf-8
require_relative 'common'

i = 0
File.readlines('doktor.csv').each { |line| line = line[0...-1]
    #line.force_encoding(Encoding::ISO_8859_1)
    #line.force_encoding(Encoding::UTF_8)
    i += 1
if i <= 1
    next
end

f = line.split('|')

h = {"name" => f[0], 
     "title"=> f[1], 
     "address" => f[2], 
     "email" => f[3], 
     "phone1" => f[4], 
     "phone2" => f[5], 
     "canton" => f[6], 
     "docfield" => f[7]
}
#if h["docfield"].include?(" ") ||
#   h["docfield"].include?("k")
#    puts h
#end
$db_doctors.insert(h)
 print "." if i % 100 == 0
}



