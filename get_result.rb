
require 'rest-client'

class GetResult

    def result

      redirected_urls =[]
    #s = BaiDu.get_real_urls(rs)
     rs =  File.read('test1.txt').split("[]")
      rs.each do |s|
      RestClient.get(s){ |response, request, result, &block|
        if [301, 302, 307].include? response.code
          redirected_url = response.headers[:location]
        else
          response.return!(request, result, &block)
        end
          redirected_url.class
        redirected_url
      }
     end
   end
end


    r = GetResult.new
    puts r.result.size