require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'mechanize'

class YogaScarpper
  # agent = Mechanize.new{|a|
  #   a.follow_meta_refresh = true
  #   a.user_agent_alias = 'Mac Safari 4'
  #   a.keep_alive= true
  #   a.open_timeout   = 5
  #   a.read_timeout   = 5
  #   a.follow_meta_refresh = true
  # }
  #
  # #  sig = "signature=z9op0KfwHl93Ybvuw6DAAwnUYrGOv5noaq437ddSauCmY270r8iFH65abpW1OPab9SE174zvzPn*KrKXWQVj*A=="
  # # uri = "http://mp.weixin.qq.com/profile?src=3&timestamp=1476935204&ver=1&#{sig}"
  #  uri = "http://weixin.sogou.com/weixin?type=1&query=%E7%91%9C%E4%BC%BD%E6%9F%A0%E6%AA%AC&ie=utf8&_sug_=n&_sug_type_="
  #       page =  agent.get(uri)
  #  rs = page.search('div.wx-rb').first
  #
  #   p wechat_url =  rs.attributes["href"].value
  #    p  wechat_page = agent.get(wechat_url)
  #  p wechat_page.search('div.weui_msg_card_bd')
  #   p

  def get_birthday_by_id(id)
    return unknown if id.nil?     # 我觉得到了这步了就应该再检查id格式是否正确了 检查nil足够
    (id.size == 18) ? id[6, 8] : "19" + review.id_cardnumber[6, 6]
  end


end

    y =  YogaScarpper.x
puts y.get_birthday_by_id("659001198609251830")