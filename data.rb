require 'rubygems'
require 'json'
class Data

 s = {"xml":
       {"cisReports":
            {"batNo":"2016091816016293","unitName":"易思互动（北京）科技有限公司","subOrgan":"CEO","queryUserID":"yswsquery1","queryCount":"1","receiveTime":"20160918 16:45:49",
             "cisReport":
                 {"reportID":"2016091816016423","buildEndTime":"2016-09-18 16:45:52","queryReasonID":"901","subReportTypes":"14502,14501","treatResult":"5,1","subReportTypesShortCaption":"1、卡交易分析含卡核查(14502) 2、个人卡核查(14501) ","hasSystemError":"false","isFrozen":"false",
                  "queryConditions":
                      {"item":
                           [
                               {"name":"name","caption":"被查询者姓名","value":"刘玉环"},
                               {"name":"documentNo","caption":"被查询者证件号码","value":"370123199402033820"},
                               {"name":"cardNos","caption":"卡号","value":"6227002298022415252"},
                               {"name":"beginDate","caption":"开始日期","value":"2016-03-01"},
                               {"name":"endDate","caption":"结束日期","value":"2016-07-31"}
                           ]
                      },
                  "personCardTransInfo":
                      {"subReportType":"14502","subReportTypeCost":"14502","treatResult":"1","errorMessage":"",
                       "cardInfos":
                           {
                               "item":
                                   {"cardNo":"6227002298022415252","openBank":"中国建设银行","cardLevelID":"0","cardLevel":"未知","cardAttrID":"01","cardAttr":"借记卡","cardClass":"人民币卡","cardClassID":"01","cardBrand":"62银联标准卡","cardBrandID":"12","cardProduct":"通用卡","cardProductID":"00","totalIncome":"0.00","totalIncomeTimes":"0","totalExpense":"4830.00","totalExpenseTimes":"15"
                                   }
                           }, "importantInfo":null,
                       "transOverview":
                           {"totalIncome":"0.00","totalIncomeTimes":"0","totalExpense":"4830.00","totalExpenseTimes":"15","avgMonthIncome":"0.00","avgMonthIncomeTimes":"0","avgMonthExpense":"965.00","avgMonthExpenseTimes":"3"},
                       "allCardsMonthTransStatis":
                           {"totalExpense":"4830.00","totalExpenseTimes":"15","avgMonthExpense":"965.00","avgMonthExpenseTimes":"3","totalIncome":"0.00","avgMonthIncome":"0.00",
                            "item":[
                                {"month":"201603","monthTotalExpense":"2500.00","monthTotalExpenseTimes":"5","monthTotalIncome":"0.00","monthTotalIncomeTimes":"0"},
                                {"month":"201604","monthTotalExpense":"2200.00","monthTotalExpenseTimes":"9","monthTotalIncome":"0.00","monthTotalIncomeTimes":"0"},
                                {"month":"201605","monthTotalExpense":"130.00","monthTotalExpenseTimes":"2","monthTotalIncome":"0.00","monthTotalIncomeTimes":"0"},
                                {"month":"201606","monthTotalExpense":"0.00","monthTotalExpenseTimes":"0","monthTotalIncome":"0.00","monthTotalIncomeTimes":"0"},
                                {"month":"201607","monthTotalExpense":"0.00","monthTotalExpenseTimes":"0","monthTotalIncome":"0.00","monthTotalIncomeTimes":"0"}
                            ]
                           },
                       "allDebitCardsExpense":
                           {"totalExpense":"4830.00","avgMonthExpense":"965.00","monthTotalHighestExpense":"2500.00","singleHighestExpense":"900.00","singleHighestCategoryID":"S22","singleHighestCategory":"消费","monthHighest":"201603"},
                       "allCreditCards":null,
                       "allCardsCategoryStatis":
                           {"item":
                                [
                                    {"merchantType":"生活日用","merchantTypeID":"05","totalExpense":"3850.00","totalExpenseTimes":"12","perTimeExpense":"350.00","percent":"79.78"},
                                    {"merchantType":"其他","merchantTypeID":"99","totalExpense":"380.00","totalExpenseTimes":"1","perTimeExpense":"380.00","percent":"7.87"},
                                    {"merchantType":"旅游","merchantTypeID":"11","totalExpense":"350.00","totalExpenseTimes":"2","perTimeExpense":"175.00","percent":"7.29"},
                                    {"merchantType":"家用电器/电子产品","merchantTypeID":"08","totalExpense":"125.00","totalExpenseTimes":"1","perTimeExpense":"125.00","percent":"2.57"},
                                    {"merchantType":"餐饮","merchantTypeID":"09","totalExpense":"120.00","totalExpenseTimes":"1","perTimeExpense":"120.00","percent":"2.49"}
                                ]
                           },
                       "allDebitCardsCategoryStatis":
                           {"item":
                                [
                                    {"merchantType":"生活日用","merchantTypeID":"05","totalExpense":"3850.00","totalExpenseTimes":"12","perTimeExpense":"350.00","percent":"79.78"},
                                    {"merchantType":"其他","merchantTypeID":"99","totalExpense":"380.00","totalExpenseTimes":"1","perTimeExpense":"380.00","percent":"7.87"},
                                    {"merchantType":"旅游","merchantTypeID":"11","totalExpense":"350.00","totalExpenseTimes":"2","perTimeExpense":"175.00","percent":"7.29"},
                                    {"merchantType":"家用电器/电子产品","merchantTypeID":"08","totalExpense":"125.00","totalExpenseTimes":"1","perTimeExpense":"125.00","percent":"2.57"},
                                    {"merchantType":"餐饮","merchantTypeID":"09","totalExpense":"120.00","totalExpenseTimes":"1","perTimeExpense":"120.00","percent":"2.49"}
                                ]
                           },
                       "allCreditCardsCategoryStatis":null,
                       "allCardsSingleExpenseTop5":
                           {"item":
                                [
                                    {"expense":"900.00","transTime":"20160304","cardNo":"6227002298022415252","openBank":"中国建设银行","cardAttr":"借记卡","cardAttrID":"01","merchantType":"超级市场 ","merchantTypeID":"5411","city":"临沂市","areaCode":"371300"},
                                    {"expense":"650.00","transTime":"20160304","cardNo":"6227002298022415252","openBank":"中国建设银行","cardAttr":"借记卡","cardAttrID":"01","merchantType":"服装服饰","merchantTypeID":"5691","city":"山东省","areaCode":"370000"},
                                    {"expense":"600.00","transTime":"20160304","cardNo":"6227002298022415252","openBank":"中国建设银行","cardAttr":"借记卡","cardAttrID":"01","merchantType":"服装服饰","merchantTypeID":"5691","city":"山东省","areaCode":"370000"},
                                    {"expense":"380.00","transTime":"20160420","cardNo":"6227002298022415252","openBank":"中国建设银行","cardAttr":"借记卡","cardAttrID":"01","merchantType":"生活日用","merchantTypeID":"4814","city":"济南市","areaCode":"370100"},
                                    {"expense":"350.00","transTime":"20160420","cardNo":"6227002298022415252","openBank":"中国建设银行","cardAttr":"借记卡","cardAttrID":"01","merchantType":"超级市场 ","merchantTypeID":"5411","city":"济南市","areaCode":"370100"}
                                ]
                           },
                       "onlineTotalExpenseStatis":null,
                       "BigExpense":null,
                       "TimeSeriesExpenseTimesStatis":
                           {"item":
                                [
                                    {"timeSeries":"00:00-1:00","percent":"0.00"},
                                    {"timeSeries":"01:00-2:00","percent":"0.00"},
                                    {"timeSeries":"02:00-3:00","percent":"0.00"},
                                    {"timeSeries":"03:00-4:00","percent":"0.00"},
                                    {"timeSeries":"04:00-5:00","percent":"0.00"},
                                    {"timeSeries":"05:00-6:00","percent":"0.00"},
                                    {"timeSeries":"06:00-7:00","percent":"0.00"},
                                    {"timeSeries":"07:00-8:00","percent":"0.00"},
                                    {"timeSeries":"08:00-9:00","percent":"0.00"},
                                    {"timeSeries":"09:00-10:00","percent":"6.25"},
                                    {"timeSeries":"10:00-11:00","percent":"6.25"},
                                    {"timeSeries":"11:00-12:00","percent":"12.50"},
                                    {"timeSeries":"12:00-13:00","percent":"0.00"},
                                    {"timeSeries":"13:00-14:00","percent":"6.25"},
                                    {"timeSeries":"14:00-15:00","percent":"0.00"},
                                    {"timeSeries":"15:00-16:00","percent":"6.25"},
                                    {"timeSeries":"16:00-17:00","percent":"6.25"},
                                    {"timeSeries":"17:00-18:00","percent":"12.50"},
                                    {"timeSeries":"18:00-19:00","percent":"25.00"},
                                    {"timeSeries":"19:00-20:00","percent":"12.50"},
                                    {"timeSeries":"20:00-21:00","percent":"6.25"},
                                    {"timeSeries":"21:00-22:00","percent":"0.00"},
                                    {"timeSeries":"22:00-23:00","percent":"0.00"},
                                    {"timeSeries":"23:00-24:00","percent":"0.00"}
                                ]
                           },
                       "areaExpenseStatis":
                           {"domestic":
                                {"item":
                                     [
                                         {"city":"济南市","areaCode":"370100","totalExpenseTimes":"9","totalExpense":"1940.00","totalExpensePercent":"40.22","totalDays":"6"},
                                         {"city":"山东省","areaCode":"370000","totalExpenseTimes":"3","totalExpense":"1370.00","totalExpensePercent":"28.40","totalDays":"2"},
                                         {"city":"临沂市","areaCode":"371300","totalExpenseTimes":"3","totalExpense":"1430.00","totalExpensePercent":"29.56","totalDays":"3"},
                                         {"city":"青岛市","areaCode":"370200","totalExpenseTimes":"1","totalExpense":"90.00","totalExpensePercent":"1.82","totalDays":"1"}
                                     ]
                                },
                            "intern":null},
                       "moreThan2000Statis":null
                      },
                  "personBankCheckInfo":
                      {"subReportType":"14501","subReportTypeCost":"14501","treatResult":"1","errorMessage":"",
                       "item":{"condition":{"name":"刘玉环","documentNo":"370123199402033820","accountNo":"6227002298022415252","accountBankNo":"105584000005","accountBankName":"中国建设银行","checkType":"姓名、证件号码和卡号"},"status":"1"}}}}}}


  p  s.to_s

  end