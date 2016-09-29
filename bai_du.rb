require 'nokogiri'
require 'rest-client'

require 'open-uri'
require 'curb'
require 'mechanize'


class BaiDu

  def set_paramter

  end


  def  self.get_page
    word = '广汽本田'
    url = "http://www.baidu.com/s?wd=site:people.com.cn #{URI.encode(word)}"

    base_uri = "http://www.baidu.com"
     first_page =  Nokogiri::HTML(open(url))

      s = first_page.xpath('//div[@id="page"]/a/@href')
   puts s
        s.each do |i|

           page = URI.join(base_uri,i).to_s
            rs =  Nokogiri::HTML(open(page))
             result = get_url(rs)

        end

  end

  def self.get_url(doc)

     url_arys = []
     redirect_urls =[]
      doc.xpath('//div[@class="result c-container "]//h3[@class="t"]/a').map { |link| url_arys << link['href'] }
       url_arys.each do |u|
         result = Curl::Easy.perform(u) do |curl|
           curl.follow_location = true
         end
          redirect_urls << result.last_effective_url
       end
        redirect_urls
  end

    puts get_page

end
