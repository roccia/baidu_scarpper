require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'mechanize'
require 'benchmark'
require 'uri'

class CnInfo

  Agent = Mechanize.new{|a|
    a.follow_meta_refresh = true
    a.user_agent_alias = 'Mac Safari 4'
    a.keep_alive=false
    a.open_timeout   = 5
    a.read_timeout   = 5
    a.follow_meta_refresh = true
  }
  URL = "http://www.cninfo.com.cn/cninfo-new/announcement/query"

  def self.first_query
    params = {
        stock: '',
        searchkey:'',
        plate: 'sz',
        category: 'category_ndbg_szsh',
        trade: '',
        column:'szse_main',
        columnTitle: '历史公告查询',
        pageNum: 1,
        pageSize:50,
        tabName: 'fulltext',
        sortName: '',
        sortType:'',
        limit:'',
        showTitle: 'category_ndbg_szsh/category/年度报告;sz/plate/深市公司',
        seDate: '2017-01-01 ~ 2017-03-09'
    }
    response =  RestClient.post(URL, params)
    puts response
    res = JSON.parse response
    total_num =  res["totalAnnouncement"]
    total_num
  end

  def self.get_result
    ary = []
   res =  first_query
    p res

  pages = res/50
    p pages
   pages.times do |p|
    params = {
        stock: '',
        searchkey:'',
        plate: 'sz',
        category: 'category_ndbg_szsh',
        trade: '',
        column:'szse_main',
        columnTitle: '历史公告查询',
        pageNum: p,
        pageSize:50,
        tabName: 'fulltext',
        sortName: '',
        sortType:'',
        limit:'',
        showTitle: 'category_ndbg_szsh/category/年度报告;sz/plate/深市公司',
        seDate: '2017-01-01 ~ 2017-03-09'
    }
    response =  RestClient.post(URL, params)
    res = JSON.parse response
    puts  res["announcements"]
  end

  end

   get_result
  #first_page = Agent.get(url)
end