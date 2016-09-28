require 'nokogiri'
require 'open-uri'
require 'curb'


class BaiDu



  def  self.get_first_page
    word = '东风日产'
    url = "http://www.baidu.com/s?wd=site:www.gmw.cn #{URI.encode(word)}"
    first_page =  Nokogiri::HTML(open(url))
    get_url(first_page)

  end

  def self.get_next_page
    word = '东风日产'
    base_uri = "http://www.baidu.com"
    url = "http://www.baidu.com/s?wd=site:www.gmw.cn #{URI.encode(word)}"
    first_page =  Nokogiri::HTML(open(url))
      page  =  first_page.xpath('//div[@id="page"]/a').map { |link|  link['href']}
    puts next_page =  URI.join(base_uri,page.last).to_s
     res = Nokogiri::HTML(open(next_page))
     result = get_url(res)
    result

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

    puts get_first_page

end
