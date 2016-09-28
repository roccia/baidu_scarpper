
require 'nokogiri'
require 'open-uri'
class Yoga
   def get_data
      n = "瑜伽柠檬"
        url = "http://weixin.sogou.com/weixin?type=1&query=(#{URI.encode(n)})&ie=utf8&_sug_=n&_sug_type_="
         puts doc = Nokogiri::HTML(open(url))
      info_imgs =  doc.xpath("//div[@class='img-box']/img")
         info_urls = doc.xpath("//div[@target='_blank']")
       url = []
       info_urls.each do |i|
     puts  url.push(i.at_xpath("//@label[name='em_weixinhao']"))

      end

      #info_gzhs = doc.xpath("//div[@class='wx-rb wx-rb3']/div[2]/div/a")
     # info  = doc.xpath("//@label[name='em_weixinhao']")
     #  puts info
end
end
  y = Yoga.new
  puts y.get_data