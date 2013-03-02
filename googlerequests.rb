#http://stackoverflow.com/questions/3193538/ruby-retrieve-contents-of-url-as-string 

require 'net/http'
require 'uri'

def open(url)
  Net::HTTP.get(URI.parse(url))
end

def is_number?(s)
    true if Float(s) rescue false
end

def googleCount(s)
    s = URI.escape(s) #s.gsub!(" ", "+")

    page_content = open('http://www.google.ch/search?hl=en&nfpr=1&q='+s)
    #puts page_content
    return 0 if page_content.index("did not match any") != nil || page_content.index("No results found for") != nil  

    # doesn't happen with nfpr=1
#    if page_content.index("Showing results for") != nil
#        puts "not the results you wanted for "+s
#        return 0
#    end

    i = page_content.index('id=resultStats>')
    i = page_content.index('"resultStats">') if i == nil

    if i == nil
        puts "couldn't count occurences of "+s
        puts page_content
        return 0
    end
    while !is_number?(page_content[i])
        i += 1 
    end
    oi = i
    while is_number?(page_content[i]) || page_content[i] == ','
        i += 1
    end

    results = page_content.slice(oi, i-oi)
    #puts results
    results.gsub!(",", "")
    results = Integer(results)
    #puts results
    return results
end

