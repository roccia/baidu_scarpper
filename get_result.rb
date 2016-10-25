require 'mechanize'
require 'nokogiri'
require 'rest-client'
 require 'pathname'

class GetResult

  def get_words
    words = []
    threads =[]
    queue = Queue.new
    File.read("words.txt").each_line{|line| words << line.chop}
    words.each{|w| queue.push w}
    words.each do
      threadsnums = 10
       threadsnums.times do
         threads << Thread.new do
            until queue.empty?
               word = queue.pop(true) rescue nil
              save_to(word,"#{generate_url(word)}")

            end
         end
       end
      threads.each{|t| t.join}
    end

  end

  def save_to(name,data)

    File.open("#{name}.txt", "a+") do |f|
      f.write(data)
    end
  end

  def  generate_url(word)
    start_time = Date.new(2016,01,01).to_time.to_i
    end_time = Time.now.to_time.to_i
    t = "=#{start_time},#{end_time}|stftype=1"
    sites = []
    all_url = []
    File.read("sites.txt").each_line{|line|  sites << line.chop}
    sites.each do |s|
      all_url << "http://www.baidu.com/s?wd=intitle:#{URI.encode(word)}%20site:%20#{s}&rn=50&gpc=stf#{URI.encode(t)}"
    end
    all_url.join("\n")
  end


end




   g = GetResult.new
  g.get_words


