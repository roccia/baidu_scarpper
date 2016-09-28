require 'rest-client'
require 'json'
require 'base64'

# https://portaltest-credit.tongdun.cn/port-desc#risk-item-table

class TongDun

  @@partner_code='yimeijian'
  @@secret_key='c645f9538075454ca335f83a2adff914'


  def preloan_apply(params)

    response = RestClient.post "https://api.tongdun.cn/preloan/apply/v1?partner_code=#{@@partner_code}&partner_key=#{@@secret_key}&app_name=yimeijian_web",params

   response.to_str

    result = JSON.parse(response.to_str)
      result['success']
     result['report_id']
  end


  def school_roll(params)
    response = RestClient.post "https://api.tongdun.cn/identification/school.roll/v1?partner_code=#{@@partner_code}&partner_key=#{@@secret_key}",params
     p response
   # response.to_str

   # result = JSON.parse(response.to_str)
   #result
  end

  def preloan_report(report_id)
    response = RestClient.get "https://api.tongdun.cn/preloan/report/v1?partner_code=#{@@partner_code}&partner_key=#{@@secret_key}&app_name=yimeijian_web&report_id=#{report_id}"
    response

  end


  def tongdun_risk(params)
  response = RestClient.post"https://api.tongdun.cn/riskService?partner_code=#{@@partner_code}&secret_key=ac2b507bd4cd4a37b0bfe833d86fc030&event_id=loan_credit_web_yimeijian_web",params
     response
  end

  def tongdun_rule
    response = RestClient.get"https://api.tongdun.cn/risk/rule.detail/v3?partner_code=#{@@partner_code}&partner_key=#{@@secret_key}&sequence_id=1474196032015064S180F165D3156241"
    response
  end


  def check_risk
    params = {id_number:'321283198305027639',name:'龙庆',mobile:'18778308926',card_number: '6217996100009899582'
    }
    result = tongdun_risk(params)
    result
  end

  def check_school

    params =
        {id_number:'530428199209081319',name:'陈永福',school_name:'杭州大学',study_type:2,  education_degree:1,enrol_date:2014}

     result=school_roll(params)
     result
    # JSON.pretty_print(result)
    # rs = JSON.parse(result.to_json)
    # rs
     # result.encoding
     # result.force_encoding('UTF-8')
  end

  def check

  params = {id_number:'321283198305027639',name:'龙庆',mobile:'18778308926',card_number: '6217996100009899582'
  }

    report_id = preloan_apply( params)

    result= preloan_report(report_id)
    j =JSON.parse(result)
    while not j['success']
      sleep(2)
      result= preloan_report(report_id)
      j =JSON.parse(result)
    end
      result.encoding
      result.force_encoding('UTF-8')
  end

end


   t = TongDun.new
   s = t.tongdun_rule
    rs = JSON.parse(s)
    puts JSON.pretty_generate(rs)
  #  p  rs = JSON.parse(t.check_risk)
 # s =   t.check_school
 #  p s.to_s
 # p result = {"success"=>true, "result"=>0, "display"=>{"enrol_date_result"=>0, "education_degree_result"=>1, "school_name_result"=>1}}

#  result["success"]
# sb = ''
# rs = result['display']['enrol_date_result'] ==0 && result['display']['education_degree_result'] ==0 && result['display']['school_name_result'] ==0
# rs2 = result['display']['enrol_date_result'] ==1 && result['display']['education_degree_result'] ==1 && result['display']['school_name_result'] ==1
#
# if result['success'] == false && result[ 'reason_code'] != 200
#   sb += '查询失败'
#   end
# if rs == true
#   sb += "学籍信息无异常\n"
# end
# if rs2 == true
#   sb += "学籍信息全部异常\n"
# end
# if  result['display']['enrol_date_result'] == 1
#   sb += "入学年份异常\n"
# end
# if  result['display']['education_degree_result']== 1
#   sb += "学位信息异常\n"
# end
# if  result['display']['school_name_result']== 1
#   sb += "学校名称异常\n"
# end
#
#
#
#
#  puts sb


#  t.check
#
#  puts result = JSON.parse(t.check)
# sb=''
#  sb+= "建议: #{result[ 'final_decision']}\n"
#  sb+= "分数: #{result[ 'final_score']}\n"
# unless result[ 'risk_items' ].nil?
#    result['risk_items']
#   result[ 'risk_items' ].map do |risk|
#           s =  risk.to_hash
#           puts s
#       puts s['item_detail']
#
#       puts  rs =  s['item_detail']['frequency_detail']
#    rs1 = s['item_detail']['platform_detail']
#          sb+= "风险项: #{risk['item_name' ]}\n"
#          sb += "风险指数: #{risk['risk_level']}\n"
#          sb+= "风险项详情: #{rs.inspect || rs1 }  \n \n"
#       end
#
# else
#   sb += "风险项: 无\n"
# end
#   puts sb
