require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'mechanize'
require 'benchmark'
require 'uri'

class BaiDu
  $keywords = gets.strip
  Agent = Mechanize.new{|a|
    a.follow_meta_refresh = true
    a.user_agent_alias = 'Mac Safari 4'
    a.keep_alive=false
    a.open_timeout   = 5
    a.read_timeout   = 5
    a.follow_meta_refresh = true
  }

  $total_time_begin = Time.now.to_i

  def self.generate_page(uri)
      queue = Queue.new
      queue.push(uri)
    until queue.empty?
      url = queue.pop(true) rescue nil
      begin
      first_page = Agent.get(url)
      rs = get_all_pages(first_page)

        if no_result(first_page) == nil
        return '无数据'
        end

        if one_page(first_page) == false
        single_page(first_page).each{|s|save_to "#{get_real_urls(s)} \n"}
        end

        if rs.class == Array
        rs.each{|s| save_to "#{get_real_urls(s)} \n"}
        else
           save_to "#{get_real_urls(rs)} \n" unless rs != ' '
        end

      rescue => e
        puts e.message
        puts e.backtrace.inspect
      end
    end

    $total_time_end = Time.now.to_i
    puts "执行时间：" + ($total_time_end - $total_time_begin).to_s + "秒"
  end


  def self.save_to(data)
    File.open("#{$keywords}_result.txt", "a+") do |f|
      f.write(data)
    end
  end


  def self.click_to_next_page(page)
    Agent.click(page.link_with(:text=>/下一页/)) unless page.link_with(:text=>/下一页/).nil?
  end

  #  return all found urls for one keyword
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
    results.each do |rs|
      return '' if rs.nil?
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
   page.search('//div[@id="page"]').empty?
  end


  def self.single_page(page)
   url_arys = []
   page.search('//div[@class="result c-container "]//h3[@class="t"]/a').each do |p|
     url_arys << p['href']
   end
    url_arys
  end

  def self.get_real_urls(uri)
    site = RestClient::Resource.new(uri, :verify_ssl =>  OpenSSL::SSL::VERIFY_PEER)
    site.get{ |response|
        redirected_url = response.headers[:location]
        redirected_url
    }

  end

 def self.final_result
    url = []
    s = File.read("#{$keywords}.txt").each_line{|line| url << line.chop}
    url.each do |u|
     generate_page(u)
    end
 end

  puts "keywords: "
  puts $keywords
  puts final_result
end


