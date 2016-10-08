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
  Agent = Mechanize.new

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
    url = []

    File.read("words.txt").each_line{|line| words << line.chop}

    File.read("sites.txt").each_line{|line|  sites << line.chop}
    words.each do |w|
      sites.each do |s|
        url << "http://www.baidu.com/s?wd=intitle:#{URI.encode(w)}%20site:#{s}&rn=50&gpc=stf#{URI.encode(TIME)}"
      end
    end
    url
  end

  def self.generate_page
    queue = Queue.new
    threads = []
    generate_url.each{|u| queue.push(u) }
    threadNums = 1000
    threadNums.times do
      threads<<Thread.new do
        until queue.empty?
          url = queue.pop(true) rescue nil
          page = Agent.get(url)
          puts get_all_urls(page)
        end
      end
    end
    threads.each{|t| t.join}

  end


  def self.click_to_next_page(page)
    Agent.click(page.link_with(:text=>/下一页/)) unless page.link_with(:text=>/下一页/).nil?
  end

  def self.get_all_next_pages(n_page)
    results = []
    np = click_to_next_page(n_page)
    results.push(np)
    until !np
      np = click_to_next_page(np)
      np && results.push(np)
    end

      results
  end

  def self.get_all_urls(page)
    url_arys = []
    next_pages = get_all_next_pages(page)
    next_pages.each do |rs|
      rs.search('//div[@class="result c-container "]//h3[@class="t"]/a').each do |p|
        url_arys << p['href']
      end
    end
    url_arys
  end

  def self.get_real_urls
     redirected_urls =[]

       get_all_urls.each do |u|
         result = Curl::Easy.perform(u) do |curl|
           curl.follow_location = true
         end
          redirected_urls << result.last_effective_url
       end
       puts  redirected_urls
  end


   puts generate_page
end


