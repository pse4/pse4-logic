require_relative 'classify_code_modified.rb'
require_relative 'common.rb'

#e.g. 
#ruby parse_thesaurus.rb "Chirurgie-Thesaurus-_Kitteltaschenversion_tool2.txt" Chirurgie
puts ARGV[0] # file
puts ARGV[1] # collection

file = File.open(ARGV[0], "rb")
contents = file.read

i = 0
while 1
    break if i >= contents.length 
    #puts i
    ct= get_code_type(contents.slice(i, contents.length-i)) 
    if ct == :icd
        #puts ct
        j = i
        while contents[i].match(/\A([A-Z]|\.|[0-9])/) do
            i += 1
        end
        code  = contents.slice(j, i-j)
        print code+" "
        c = {"icd_code" => code}
        $db_thesauren[ARGV[1]].insert(c)
    end
    i += 1
end
