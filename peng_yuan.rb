require 'rest-client'
require 'ostruct'
require 'nokogiri'
require 'json'
require 'active_support/all'
require 'xml/to/json'

class PengYuan

   def pengyuan_tel_query(mobile_num, name)

    response = RestClient.get "http://test.yimeijian.cn:7080/test/pengyuan/telQuery?tel=#{mobile_num}&ownerName=#{URI.encode(name)}&subreportIDs=21603&queryReasonID=901&queryType=25129"
     response
  end

  def pengyuan_cardTrad_query(name,idcard_num,*card_num)
    begin_date =  (Date.today<<6).strftime("%Y-%m")
    end_date = Date.today.strftime("%Y-%m")
 p   "http://test.yimeijian.cn:7080/test/pengyuan/cardTradQuery?name=#{URI.encode(name)}&documentNo=#{idcard_num}&cardNos=#{card_num.join(', ')}&beginDate=#{begin_date}&endDate=#{end_date}&queryReasonID=901"
    response = RestClient.get  "http://test.yimeijian.cn:7080/test/pengyuan/cardTradQuery?name=#{URI.encode(name)}&documentNo=#{idcard_num}&cardNos=#{card_num.join(', ')}&beginDate=#{begin_date}&endDate=#{end_date}&queryReasonID=901"
    puts response
  end


  def pengyuan_income_query( name,idcard_num,company_name,position)

    response = RestClient.get "http://test.yimeijian.cn:7080/test/pengyuan/testwsQuery?name=#{URI.encode(name)}&documentNo=#{idcard_num}&corpName=#{URI.encode(company_name)}&positionName=#{URI.encode(position)}&subreportIDs=14004&queryReasonID=901&queryType=25180"
   puts response
  end


def pengyuan_phone_check(name,idcard_num,phone_num)
  response = RestClient.get "http://test.yimeijian.cn:7080/test/pengyuan/checkPhone?name=#{URI.encode(name)}&documentNo=#{idcard_num}&phone=#{phone_num}"
  result = Nokogiri.XML(response,nil,'utf-8')
   puts result
end

end

p = PengYuan.new
debit = '6212260302019136555'
credit = '4041170058157763'
 puts p.pengyuan_cardTrad_query('李小琴','33032819621221004X', [debit,credit])
#
#    result = pengyuan_phone_check('闫威臻 ', '659001198609251830','18515920925')
#
# data = ''
# sb = ''
#  if result.xpath("//mobileCheckInfo").first["treatResult"] == "1"
# result.xpath("//mobileCheckInfo/item").each do |o|
#
#          data += "姓名检查结果: #{o.at_xpath('nameCheckResult').text} \n"
#          data += "身份证检查结果: #{o.at_xpath('documentNoCheckResult').text} \n"
#          data += "电话号码检查结果: #{o.at_xpath('phoneCheckResult').text} \n"
#          data += "归属地: #{o.at_xpath('areaInfo').text} \n"
#            if o.at_xpath('operator').text == "1"
#              data += "运营商:  中国电信 \n"
#            end
#          if o.at_xpath('operator').text == "2"
#            data += "运营商:  中国移动 \n"
#          end
#          if o.at_xpath('operator').text == "3"
#            data += "运营商:  中国联通 \n"
#          end
#      end
#        puts data
#
# result.xpath("//mobileStatusInfo/item").each do |o|
#
#   sb += "在网时长: #{o.at_xpath('timeLength').text} \n"
#   if o.at_xpath('phoneStatus').text  == "1"
#        sb +=  "手机状态 ：正常在用\n"
#   end
#   if o.at_xpath('phoneStatus').text  == "2"
#     sb +=  "手机状态 ：停机\n"
#   end
#   if o.at_xpath('phoneStatus').text  == "3"
#     sb +=  "手机状态 ：未启用\n"
#   end
#   if o.at_xpath('phoneStatus').text  == "4"
#     sb +=  "手机状态 ：已销号\n"
#   end
#   if o.at_xpath('phoneStatus').text  == "5"
#     sb +=  "手机状态 ：其他\n"
#   end
#   if o.at_xpath('phoneStatus').text  == "6"
#     sb +=  "手机状态 ：预销号\n"
#   end
#   sb += "最近一次销号时间: #{o.at_xpath('cancelTime').text} \n"
#
# end
#
# puts sb
#  else
#    puts '未查到数据'
# end

     # result = p.pengyuan_income_query('陈梦', '430802199708270928' , '张家界市华天大酒店', '服务人员' )
#    phone = '18515920925'
#    #puts phone.gsub!(/\D/, "")[0..-5]
# if phone.match(/(^(13\d|15[^4\D]|17[13678]|18\d)\d{8}|170[^346\D]\d{7})$/)
#   puts $1
# end
# if phone.match(/^(\d{3}-\d{8}|\d{4}-\d{7,8})-*\d{0,4}/)
#     puts rsss = $1.gsub!(/\D/, "")
# else
#     puts '2'
#     end

   #   puts  result = p.pengyuan_tel_query(phone, '易思互动')
    # puts rs = Nokogiri.XML(result,nil,'utf-8')
   #
   # data = ''
   #        rs.xpath("//PersonIncomeValuation").each do |o|
   #          data += "评估结果: #{o.at_xpath('valuationResult').text} \n"
   #          data += "评测描述信息: #{o.at_xpath('valuationResult').text} \n"
   #
   #          #data += "个人收入: #{o.at_xpath('valuationResult').text} \n"
   #
   #
   #
   #      end
   #        puts data


       p   s = p.pengyuan_cardTrad_query('易淑飞', '420324198610074616', '6216912600541687,  ')
#            ss = "<xml>#{s}</xml>"
#         p result = Hash.from_xml(ss)
#
#        puts    rs = JSON.parse(result)
# puts rs[ 'xml']['cisReports']['cisReport']
       # rs = Nokogiri.XML(s,nil,'utf-8')
    #JSON.pretty_generate(rs.root).to_s

# @overview = ''
# rs.xpath("//transOverview").each do |o|
#   @overview += "收入总金额: #{o.at_xpath('totalIncome').text} \n"
#   @overview += "收入总次数: #{o.at_xpath('totalIncomeTimes').text} \n"
#   @overview += "支出总金额: #{o.at_xpath('totalExpense').text} \n"
#   @overview += "支出总次数: #{o.at_xpath('totalExpenseTimes').text} \n"
#   @overview += "月平均收入金额: #{o.at_xpath('avgMonthIncome').text} \n"
#   @overview += "月平均收入次数: #{o.at_xpath('avgMonthIncomeTimes').text} \n"
#   @overview += "月平均支出金额: #{o.at_xpath('avgMonthExpense').text} \n"
#   @overview += "月平均支出次数: #{o.at_xpath('avgMonthExpenseTimes').text} \n*******************************\n"
# end
#
# @month_trans = ''
# rs.xpath("//allCardsMonthTransStatis").each do |m|
#
#   @month_trans += "支出总金额: #{m.at_xpath('totalExpense').text} \n"
#   @month_trans += "支出总次数: #{m.at_xpath('totalExpenseTimes').text} \n"
#   @month_trans += "月平均支出金额: #{m.at_xpath('avgMonthExpense').text} \n"
#   @month_trans += "月平均支出次数: #{m.at_xpath('avgMonthExpenseTimes').text} \n"
#   @month_trans += "总收入金额: #{m.at_xpath('totalIncome').text} \n"
#   @month_trans += "月平均收入金额: #{m.at_xpath('avgMonthIncome').text} \n----------------------------------- "
# end
#
#
# @item =  ''
# rs.xpath("//allCardsMonthTransStatis/item").each do |i|
#   @item +=  "\n月份: #{i.at_xpath('month').text} \n\n"
#   @item += "月支出金额: #{i.at_xpath('monthTotalExpense').text} \n"
#   @item += "月支出次数: #{i.at_xpath('monthTotalExpenseTimes').text} \n"
#   @item += "月收入总金额: #{i.at_xpath('monthTotalIncome').text} \n"
#   @item += "月收入总次数: #{i.at_xpath('monthTotalIncomeTimes').text} \n \n"
# end
#
# @debit_card = ''
# rs.xpath("//allDebitCardsExpense").each do |d|
#   @debit_card += "支出总金额: #{d.at_xpath('totalExpense').text} \n"
#   @debit_card += "月平均支出金额: #{d.at_xpath('avgMonthExpense').text} \n"
#   @debit_card += "月统计最高支出金额: #{d.at_xpath('monthTotalHighestExpense').text} \n"
#   @debit_card += "单笔最高支出金额: #{d.at_xpath('singleHighestExpense').text} \n"
#   @debit_card += "单笔最高支出金额类别id: #{d.at_xpath('singleHighestCategoryID').text} \n"
#   @debit_card += "单笔最高支出金额类别名称: #{d.at_xpath('singleHighestCategory').text} \n"
#   @debit_card += "月统计最高支出金额月份: #{d.at_xpath('monthHighest').text} \n*******************************\n"
# end
#
#
# if  rs.xpath("//allCreditCards").nil?
#   @credit_card = ''
#   rs.xpath("//allCreditCards").each do |c|
#     @credit_card += "支出总金额: #{c.at_xpath('totalExpense').text} \n"
#     @credit_card += "月平均支出金额: #{c.at_xpath('avgMonthExpense').text} \n"
#     @credit_card += "月统计最高支出金额: #{c.at_xpath('monthTotalHighestExpense').text} \n"
#     @credit_card += "单笔最高支出金额: #{c.at_xpath('singleHighestExpense').text} \n"
#     @credit_card += "单笔最高支出金额类别id: #{c.at_xpath('singleHighestCategoryID').text} \n"
#     @credit_card += "单笔最高支出金额类别名称: #{c.at_xpath('singleHighestCategory').text} \n"
#     @credit_card += "提现总金额: #{c.at_xpath('totalCashAdvance').text} \n"
#     @credit_card += "单笔最高提现: #{c.at_xpath('singleHighestCategory').text} \n"
#     @credit_card += "有提现的月份: #{c.at_xpath('monthsCashAdvance').text} \n"
#     @credit_card += "提现次数: #{c.at_xpath('cashAdvanceTimes').text} \n*******************************\n"
#   end
#
# end
#
# @crads_stat = ''
# rs.xpath("//allCardsCategoryStatis/item").each do |c|
#   @crads_stat +=  "\n类别名称: #{c.at_xpath('merchantType').text} \n\n"
#   @crads_stat += "类别编码: #{c.at_xpath('merchantTypeID').text} \n"
#   @crads_stat += "支出总金额: #{c.at_xpath('totalExpense').text} \n"
#   @crads_stat += "支出总次数: #{c.at_xpath('totalExpenseTimes').text} \n"
#   @crads_stat += "单次平均支出金额: #{c.at_xpath('perTimeExpense').text} \n"
#   @crads_stat += "占总支出金额比例: #{c.at_xpath('percent').text} \n------------------------ \n"
# end
#
# @d_crads_stat = ''
# rs.xpath("//allDebitCardsCategoryStatis/item").each do |s|
#   @d_crads_stat +=  "\n类别名称: #{s.at_xpath('merchantType').text} \n\n"
#   @d_crads_stat += "类别编码: #{s.at_xpath('merchantTypeID').text} \n"
#   @d_crads_stat += "支出总金额: #{s.at_xpath('totalExpense').text} \n"
#   @d_crads_stat += "支出总次数: #{s.at_xpath('totalExpenseTimes').text} \n"
#   @d_crads_stat += "单次平均支出金额: #{s.at_xpath('perTimeExpense').text} \n"
#   @d_crads_stat += "占总支出金额比例: #{s.at_xpath('percent').text} \n------------------------ \n"
# end
#
# @c_crads_stat = ''
# rs.xpath("//allCreditCardsCategoryStatis/item").each do |cc|
#   @c_crads_stat +=  "\n类别名称: #{cc.at_xpath('merchantType').text} \n\n"
#   @c_crads_stat += "类别编码: #{cc.at_xpath('merchantTypeID').text} \n"
#   @c_crads_stat += "支出总金额: #{cc.at_xpath('totalExpense').text} \n"
#   @c_crads_stat += "支出总次数: #{cc.at_xpath('totalExpenseTimes').text} \n"
#   @c_crads_stat += "单次平均支出金额: #{cc.at_xpath('perTimeExpense').text} \n"
#   @c_crads_stat += "占总支出金额比例: #{cc.at_xpath('percent').text} \n------------------------ \n"
# end
#
# @top5 = ''
# rs.xpath("//allCardsSingleExpenseTop5/item").each do |t|
#   @top5 +=  "\n支出金额: #{t.at_xpath('expense').text} \n\n"
#   @top5 += "交易时间: #{t.at_xpath('transTime').text} \n"
#   @top5 += "卡号: #{t.at_xpath('openBank').text} \n"
#   @top5 += "发卡行: #{t.at_xpath('cardAttrID').text} \n"
#   @top5 += "卡性质: #{t.at_xpath('cardAttr').text} \n"
#   @top5 += "卡性质名称: #{t.at_xpath('merchantTypeID').text} \n"
#   @top5 += "商户类型id: #{t.at_xpath('merchantType').text} \n"
#   @top5 += "城市区划编码: #{t.at_xpath('areaCode').text} \n"
#   @top5 += "城市名称: #{t.at_xpath('city').text} \n------------------------ \n"
# end
#
#
#  @online = ''
#  rs.xpath("//onlineTotalExpenseStatis").each do |on|
#    @online +=  "支出金额: #{on.at_xpath('totalExpense').text} \n\n"
#    @online += "交易时间: #{on.at_xpath('totalExpenseTimes').text} \n"
#    @online += "卡号: #{on.at_xpath('percent').text} \n------------------------"
#  end
#
# @online_item =  ''
# rs.xpath("//onlineTotalExpenseStatis/onlineSingleExpenseTop5/item").each do |oi|
#   @online_item +=  "\n支出金额: #{oi.at_xpath('expense').text} \n"
#   @online_item += "交易时间: #{oi.at_xpath('transTime').text}\n"
#   @online_item += "卡号: #{oi.at_xpath('cardNo').text}\n"
#   @online_item += "发卡行: #{oi.at_xpath('openBank').text}\n"
#   @online_item += "商户类别名称: #{oi.at_xpath('merchantType').text} \n"
#   @online_item += "城市名称: #{oi.at_xpath('city').text}\n"
# end
#
# @big_ex =''
# rs.xpath("//BigExpense/item").each do |big|
#   @big_ex +=  "\n支出金额: #{big.at_xpath('expense').text} \n"
#   @big_ex += "交易时间: #{big.at_xpath('transTime').text}\n"
#   @big_ex += "商户类别名称: #{big.at_xpath('merchantType').text}\n"
#   @big_ex += "商户名称: #{big.at_xpath('merchantName').text}\n"
#   @big_ex += "城市名称: #{big.at_xpath('city').text}\n"
# end
#
#
# @time = ''
# rs.xpath("//TimeSeriesExpenseTimesStatis/item").each do |tm|
#   @time +=  "\n时间段名称: #{tm.at_xpath('timeSeries').text} \n"
#   @time += "百分比: #{tm.at_xpath('percent').text}\n"
# end
#
#
# @stat = ''
# rs.xpath("//moreThan2000Statis/item").each do |st|
#   @stat +=  "\n收入金额: #{st.at_xpath('income').text} \n"
#   @stat += "币种名称: #{st.at_xpath('currency').text}\n"
#   @stat += "交易时间: #{st.at_xpath('transTime').text}\n"
#   @stat += "卡号: #{st.at_xpath('cardNo').text}\n"
#   @stat += "发卡行: #{st.at_xpath('openBank').text}\n"
#   @stat += "卡性质: #{st.at_xpath('cardAttrID').text}\n"
#   @stat += "卡性质名称: #{st.at_xpath('cardAttr').text}\n"
# end
#
#
#
#  ov = "交易总览（含借记卡和信用卡):\n\n#{@overview} "
#  mt =  "所有卡支出、收入情况:\n\n#{@month_trans} "
#  it  =  @item +'*******************************'
#  dc =   "借记卡支出信息:\n\n#{@debit_card} "
#  cc =  "信用卡支出信息:\n\n#{@credit_card} "
#  cs =  "支出详情总分析（含借记卡和信用卡）:\n\n#{@crads_stat} " +'*******************************'
#  dcs =  "借记卡支出详情分析:\n\n#{@d_crads_stat} " +'*******************************'
#  ccs = "信用卡支出详情分析:\n\n#{@c_crads_stat} " +'*******************************'
#  tp =   "单笔支出金额前五名（含借记卡和信用卡）:\n\n#{@top5} " +'*******************************'
#  onl =  "线上支出总金额（含借记卡和信用卡）:\n\n#{@online} "
#  onli =  @online_item +'*******************************'
#  be =  "固定资产、大宗商品、投资、理财、保险等支出信息:\n\n#{@big_ex}" +'*******************************'
#  ti =  "支出交易次数时间分布:\n\n#{@time}" +'*******************************'
#  sta = "单笔2000以上的收入交易信息:\n\n#{@stat}" +'*******************************'
#
#   data  =  ov,mt,it,dc,cc,cs,dcs,ccs,tp,onl,onli,be,ti,sta
#    print data.join("\n")