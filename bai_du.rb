require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'mechanize'
require 'benchmark'
require 'uri'


class BaiDu

  WORD = '东风日产'
  TIME = '=1451520000,1472601600|stftype=1'
  BASE_URI = "http://www.baidu.com/s?"
  PerPage = 50
  Agent = Mechanize.new
  Agent.user_agent_alias = 'Mac Safari 4'
   #Agent.set_proxy('182.90.252.10', '2226')
  Agent.follow_meta_refresh = true

  def self.query(word)
    q = Array.new
    q << "wd=#{word}"
    q << "rn=#{PerPage}"
    q << "gpc=stf#{URI.encode(TIME)}"
    query_str = q.join("&")
    uri = URI.encode(BASE_URI+ query_str)
    uri
  end

  def self.generate_url
    words = []
    sites = []
    all_url = []

    #File.read("words.txt").each_line{|line| words << line.chop}

    File.read("sites.txt").each_line{|line|  sites << line.chop}
     puts sites.size
      sites.each do |s|
        all_url << "http://www.baidu.com/s?wd=intitle:#{URI.encode(WORD)}%20site:%20#{s}&rn=50&gpc=stf#{URI.encode(TIME)}"

    end
    all_url
  end

  $total_time_begin = Time.now.to_i

  def self.generate_page
    queue = Queue.new
    #threads = []
    generate_url.each{|u| queue.push(u) }
    #threadNums = 1000
    #threadNums.times do
      #threads<<Thread.new do
        until queue.empty?
          url = queue.pop(true) rescue nil
          first_page = Agent.get(url)
          rs = get_all_pages(first_page)
            if no_result(first_page) == nil
              return '无数据'
            end

            if one_page(first_page) == nil
             save_to get_real_urls(single_page(first_page))
            end
            if rs.class == Array
                  rs.each{|s|  save_to "#{get_real_urls(s)} \n"
                   }
            else
                #puts get_real_urls(rs) unless rs != ' '
               save_to "#{get_real_urls(rs)} \n" unless rs != ' '
            end

     #    end
     #  end
     #
     # threads.each{|t| t.join}
    end

    $total_time_end = Time.now.to_i
   # puts "线程数：" + threadNums.to_s
    puts "执行时间：" + ($total_time_end - $total_time_begin).to_s + "秒"
  end

  def self.save_to(data)

    File.open("test1.txt", "a+") do |f|
      f.write(data)
    end
  end

  def self.click_to_next_page(page)
    Agent.click(page.link_with(:text=>/下一页/)) unless page.link_with(:text=>/下一页/).nil?
  end

  def self.get_all_pages(page)
    results = []
    url_arys = []
    np = click_to_next_page(page)
    results.push(np)
    until !np
      np = click_to_next_page(np)
      np && results.push(np)
    end

    results.push(page)
    results

    results.each do |rs|
      return '' if rs.nil?
      rs.search('//div[@class="result c-container "]//h3[@class="t"]/a').each do |p|
        url_arys << p['href']
      end

    end
     url_arys

  end

  def self.get_all_urls(page)
    url_arys = []
    p get_all_pages(page)

    get_all_pages(page).each do |rs|
           rs.search('//div[@class="result c-container "]//h3[@class="t"]/a').each do |p|
            url_arys << p['href']
           end
    end
    url_arys
  end

 def self.no_result(page)
   page.search('//div[@class="content_none"]')
 end

 def self.one_page(page)
   page.search('//div[@id="page"]')
 end

 def self.single_page(page)
   url_arys = []
   page.search('//div[@class="result c-container "]//h3[@class="t"]/a').each do |p|
     url_arys << p['href']
   end
   url_arys
 end

  def self.get_real_urls(uri)
    RestClient.get(uri){ |response, request, result, &block|
      if [301, 302, 307].include? response.code
        redirected_url = response.headers[:location]
      else
        response.return!(request, result, &block)
      end
      redirected_url
    }

  end


 puts generate_page

  #File.open('test2.txt', 'w') { |file| file.write(rs) }
end


