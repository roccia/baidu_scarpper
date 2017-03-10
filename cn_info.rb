require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'mechanize'
require 'benchmark'
require 'uri'
require 'json'
require 'active_record'
require 'mysql2'

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

  def self.connect_database
    ActiveRecord::Base.establish_connection(
        adapter:  'mysql2',
        database: 'PDF',
        username: 'meiuser',
        password: '_m3iu$er_',
        host:     'localhost'
    )
  end

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

    res = JSON.parse response.body

    total_num = res["totalAnnouncement"]

  end

  def self.get_result
    ary = []
    res =  first_query
    pages = (res/50.to_f).round
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
      puts  res["announcements"][0]["announcementTitle"]
      # puts  commpany_code =  res["announcements"]["secCode"]
      # puts commpany_name =  res["announcements"]["secName"]
      # puts  title =  res["announcements"]["announcementTitle"].exclude?("摘要")
    end

  end

  p connect_database
  #first_page = Agent.get(url)
end