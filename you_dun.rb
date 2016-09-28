require 'digest'
require 'json'
require 'rest-client'
require 'openssl'

class YouDun



   def phone_check

     key = 'zeXY4zZAHQMlDDoVo721'
     num  = (1..1000000).to_a.shuffle
      s  = {"header": {
         "version":"1.0",
         "product":"B1001156",
         "merchant":"201609140262",
         "outOrderId":num.pop,
     },
            "body":{
                "mobile":"18910151372",
                "relationMobile":"18910151372"
            }
     }

     rs = s.to_json + key

    respones = RestClient.get "http://api.yimeijian.cn:7080/helper/ecodeByMD5?originstr=#{rs}"
   result = respones.gsub("\r\n\t", "")
      message ={"request":s,
         "sign":result
     }
     site = RestClient::Resource.new('https://api.udcredit.com/api/credit/v1/go_moblies_contactfrequency')
       data =  site.post(message.to_json,:content_type => 'application/json'
                         )
      data
   end

end

t = YouDun.new
  r =  JSON.parse(t.phone_check)
  if r['response']['body']  == '1'

  else
    puts '32'
  end
