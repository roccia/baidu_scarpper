require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'curb'
require 'mechanize'

class BaiDu
  WORD = '广汽本田'
  TIME = '=1451520000,1472601600|stftype=1'
  BASE_URI = "http://www.baidu.com/s?"
  PerPage = 50

  def initialize
    @agent = Mechanize.new
    @page
  end

  def query(word)
    q = Array.new
    q << "wd=#{word}"
    q << "rn=#{PerPage}"
    q << "gpc=stf#{URI.encode(TIME)}"
    query_str = q.join("&")
    uri = URI.encode(BASE_URI+ query_str)

  end

  def generate_page
    url = "http://www.baidu.com/s?wd=intitle:#{URI.encode(WORD)}%20site:sina.com.cn&rn=50&gpc=stf#{URI.encode(TIME)}"
   @page = @agent.get(url)

  end

  def  get_page
    # url = "http://www.baidu.com/s?wd=intitle:#{URI.encode(WORD)}%20site:sina.com.cn&rn=50&gpc=stf#{URI.encode(TIME)}"
    #
    # # agent = Mechanize.new
    #  @page =  @agent.get(url)

  puts next_page(generate_page)
    # p agent.page.link_with(:text => '下一页>').click unless page.link_with(:text=>/下一页/).nil?

    #
    #  s = first_page.xpath('//div[@id="page"]/a/@href')
    #     s.each do |i|
    #     p urls =  URI.join(BASE_URI,i)
    #     end
     url_arys = []
    generate_page.search('//div[@class="result c-container "]//h3[@class="t"]/a').each do |p|

      url_arys << p['href']
    end

  end


  def next_page(page)
   np =  page.link_with(:text=>/下一页/)
  puts get_np = Mechanize.new.click(np) unless np.nil?



   next_page(get_np)

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

end

 b = BaiDu.new
puts b.get_page
