
require 'rest-client'
class ZhiMa

  def zhima_antifraud(id, name,mobile,address,card_num)

    response = RestClient.get "http://api.yimeijian.cn:7080/alipay/testIvsGet?idCard=#{id}&name=#{URI.encode(name)}&mobile=#{mobile}&address=#{URI.encode(address)}&bankCard=#{card_num}"
    response
  end


end


  z = ZhiMa.new

   puts rs = z.zhima_antifraud("659001198609251830", "闫威臻","18515920925","立水桥","6217000010069969643")
s = JSON.parse(rs)
data = ' '
data += "#{s['ivsDetail'][0]['description']}\n"
data += "#{s['ivsDetail'][1]['description']}\n "
data += " #{s['ivsDetail'][2]['description']}\n"
data += "#{s['ivsDetail'][3]['description']}\n "
data += " #{s['ivsDetail'][4]['description']}\n"
data +=  "可信度(1-100): #{s['ivsScore']}\n"
    data