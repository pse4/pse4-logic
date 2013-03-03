require "rubygems"
require "net/http"
#require "open-uri"

module Crawler
 class NetHttp
   def initialize(proxy_host, proxy_port=80, proxy_user = nil, proxy_pass = nil)
     @proxy_host =  proxy_host;
     @proxy_port =  proxy_port;
     @proxy_user =  proxy_user;
     @proxy_pass =  proxy_pass;
   end
  
   def get(uri_str, limit = 10)
     begin
       http = Net::HTTP::Proxy(@proxy_host, @proxy_port, @proxy_user, @proxy_pass)      
       result = http.get_response(URI.parse(uri_str))             
       case result
       when Net::HTTPSuccess     then result
       when Net::HTTPRedirection then get(result['location'], limit - 1)
       else
         result.error!
       end
     rescue Exception => e
         puts e.message
         return false
     end
   end
 end
end

