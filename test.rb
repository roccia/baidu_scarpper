
require 'json'
require 'rest-client'
require 'openssl'
require 'base64'
require 'digest/sha1'
class TEST

  @@pemfile='key.pem'


  def self.des_encrypt( encrypted_string)

    key ='nXu8XF9_EBYM8T576Z1Y1P72'
    cipher = OpenSSL::Cipher::Cipher.new('des-ede3')
    cipher.encrypt
    cipher.key = key
    output = cipher.update(encrypted_string)<< cipher.final
    Base64.encode64(output)
  end

  def self.des_decrypt(encrypted_string)
    data = Base64.decode64(encrypted_string)
    key ='nXu8XF9_EBYM8T576Z1Y1P72'

    aes = OpenSSL::Cipher::Cipher.new("des-ede3")
    aes.decrypt
    aes.key = key

    txt = aes.update(data)<< aes.final
    txt

  end


  def self.sha1withrsa(encrypted_string )
    private_key = OpenSSL::PKey::RSA.new File.read(@@pemfile), 'ymj2015!'
    data = private_key.sign('sha1', encrypted_string.force_encoding('utf-8') )
    Base64.encode64(data)
  end

  def self.sha1(string)
    Digest::SHA1.hexdigest string
  end

  def  self.getSecurityInfo( signatureValue,  pwd)
    "{\"signatureValue\":\"" + signatureValue + "\",\"userName\":\"yshudongOper\",\"userPassword\":\"" + pwd + "\"}"
  end


  def self.get_header

    header = {
        orgCode: "91110108597695393T",
        chnlId:  "yshudong",
        transNo: "T#{Time.now.to_i}",
        transDate:"#{Time.now.strftime('%F %T' )}",
        authCode: "CNS0783XX",
        authDate:"#{Time.now.strftime('%F %T')}"

    }
    h = "\"header\":" + header.to_json
  end

  def self.intimacy(name,id_no,contact, contact_mobile)
    num =  (1..1000000).to_a.shuffle
    intimacy_busiData = {
        batchNo:"T#{Time.now.to_i}",
        subProductInc:'0000000000010000',
        records:[{
                     idNo: id_no,
                     idType: "0",
                     name: name,
                     refName:contact,
                     refMobileNo: contact_mobile,
                     reasonNo: "01",
                     entityAuthCode: num.pop,
                     entityAuthDate: "#{Time.now.strftime('%F')}",
                     seqNo: "T#{Time.now.to_i}"
                 }]
    }
    intimacy = intimacy_busiData.to_json

    encBusiData = des_encrypt(intimacy)
    busiData = "\"busiData\":\"" + encBusiData + "\""
    sigValue = sha1withrsa(encBusiData)
    pwd = sha1("ymj2015!")
    securityInfo = "\"securityInfo\":" + getSecurityInfo(sigValue, pwd)
    message =  "{" + get_header + "," + busiData + "," + securityInfo+ "}"

    site = RestClient::Resource.new('https://qhzx-dcs.pingan.com.cn/do/dmz/verify/eChkPkgs/v1/MSC8107')
  puts  response=  site.post(message,{:content_type => :json})
    s = JSON.parse(response)
    des_decrypt(s['busiData']).force_encoding('UTF-8')
  end


  def self.black_list_check(name,id_no,mobile_no,card_no)
    num =  (1..1000000).to_a.shuffle

    black_list_busiData = {
        batchNo:"T#{Time.now.to_i}",
        records:[{
                     idNo: id_no,
                     idType: "0",
                     cardNos: card_no,
                     mobileNos: mobile_no,
                     name: name,
                     reasonNo: "01",
                     entityAuthCode: num.pop,
                     entityAuthDate: "#{Time.now.strftime('%F')}",
                     seqNo: "T#{Time.now.to_i}"
                 }]
    }
    black_list = black_list_busiData.to_json

    encBusiData = des_encrypt(black_list)
    busiData = "\"busiData\":\"" + encBusiData + "\""
    sigValue = sha1withrsa(encBusiData)
    pwd = sha1("ymj2015!")
    securityInfo = "\"securityInfo\":" + getSecurityInfo(sigValue, pwd)
     message =  "{" + get_header + "," + busiData + "," + securityInfo+ "}"

    site = RestClient::Resource.new('https://qhzx-dcs.pingan.com.cn/do/dmz/query/rskdoo/v1/MSC8036')
     response=  site.post(message,{:content_type => :json})
     s = JSON.parse(response)
    des_decrypt(s['busiData']).force_encoding('UTF-8')
  end

  def self.address_check(name,id_no,mobile_no,address)
    num =  (1..1000000).to_a.shuffle

    address_busiData = {
        batchNo:"T#{Time.now.to_i}",
        records:[{
                     idNo: id_no,
                     idType: "0",
                     mobileNo: mobile_no,
                     address: address,
                     name: name,
                     reasonNo: "01",
                     entityAuthCode: num.pop,
                     entityAuthDate: "#{Time.now.strftime('%F')}",
                     seqNo: "T#{Time.now.to_i}"
                 }]
    }

    address =  address_busiData.to_json
    encBusiData = des_encrypt(address)
    busiData = "\"busiData\":\"" + encBusiData + "\""
    sigValue = sha1withrsa(encBusiData)
    pwd = sha1("ymj2015!")
    securityInfo = "\"securityInfo\":" + getSecurityInfo(sigValue, pwd)
     message =  "{" + get_header + "," + busiData + "," + securityInfo+ "}"

    site = RestClient::Resource.new('https://qhzx-dcs.pingan.com.cn/do/dmz/query/address/v1/MSC8007')
    response=  site.post(message,{:content_type => :json})

   puts s = JSON.parse(response)

    puts  des_decrypt(s['busiData'])
  end


  def self.trusty_check(name,id_no,mobile_no,card_no)
    num =  (1..1000000).to_a.shuffle

    trusty_busiData = {
        batchNo:"T#{Time.now.to_i}",
        records:[{
                     idNo: id_no,
                     idType: "0",
                     name: name,
                     mobileNo: mobile_no,
                     cardNo: card_no,
                     reasonNo: "04",
                     # email: "roccia@qq.com",
                     # weiboNo: "roccia@qq.com",
                     # weixinNo: "112389654",
                     # qqNo: "112389654",
                     # taobaoNo: "lzzylzzy",
                     # jdNo: "rocciavia",
                     entityAuthCode: num.pop,
                     entityAuthDate: "#{Time.now.strftime('%F')}",
                     seqNo: "T#{Time.now.to_i}"
                 }]
    }

    trusty =  trusty_busiData.to_json
    encBusiData = des_encrypt(trusty)
    busiData = "\"busiData\":\"" + encBusiData + "\""
    sigValue = sha1withrsa(encBusiData)
    pwd = sha1("ymj2015!")
    securityInfo = "\"securityInfo\":" + getSecurityInfo(sigValue, pwd)
     message =  "{" + get_header + "," + busiData + "," + securityInfo+ "}"

    site = RestClient::Resource.new('https://qhzx-dcs.pingan.com.cn/do/dmz/query/credoo/v1/MSC8005')
    response=  site.post(message,{:content_type => :json})
    s = JSON.parse(response)
    des_decrypt(s['busiData']).force_encoding('UTF-8')
  end

  def self.trans_qianhai_address

      result = JSON.parser
     p result
      format =  "格式化地址: "
      if result['records'][10]['fmtAddress'] = -1
        format+= '权限不足'
      else
        format
      end
      state = '查询数据状态:'
      if result['records'][23]['state'] == -1
        s += '权限不足'
      elsif result['records'][23]['state'] == 1
        s += '精准地址'
      elsif result['records'][23]['state'] == 2
        s += '疑似附近地址信息'
      elsif result['records'][23]['state'] == 3
        s += '模糊地址'
      elsif  result['records'][23]['state'] == 4
        s += '疑似虚假地址'
      end
      s
      format

    end


end

#puts TEST.intimacy('闫威臻','659001198609251830','闫学柱','13909936403')
# puts TEST.black_list_check('闫威臻','659001198609251830','6217000010069969643','18515920925')
     s =  TEST.address_check('闫威臻','659001198609251830','18515920925','北京市朝阳区汤立路201号二号楼一单元1108')
   # s  = TEST.trusty_check('闫威臻','659001198609251830','18515920925' ,'6217000010069969643')
   #puts  TEST.trans_qianhai_address(s)
  # puts rs = JSON.parse(s)

   # puts sss = TEST.des_decrypt(rs["busiData"]).force_encoding('UTF-8')
    # ss =  JSON.parse(sss)


# ss = rs["records"][0]
# data = ''
# data +=  "综合评分:#{ss['credooScore']} \n"
# data +=  "身份特征:#{ss['bseInfoScore']} \n"
# data += "履约能力:#{ss['finRequireScore']} \n"
# data += "失信风险:#{ss['payAbilityScore']} \n"
# data +=  "消费偏好:#{ss['performScore']} \n"
# data +=  "行为特征:#{ss['actionScore']} \n"
# data +=  "社交信用:#{ss['virAssetScore']} \n"
# data +=  "成长潜力:#{ss['trendScore']} \n"
# puts data


  # if x[0]['state'] == '-1'
  #   data_status = '查询数据状态: "权限不足'
  # elsif x[0]['state'] == '1'
  #   data_status = '查询数据状态:  精准地址'
  # elsif x[0]['state'] == '2'
  #   data_status =  '查询数据状态: 疑似附近地址信息'
  # elsif x[0]['state'] == '3'
  #   data_status =  '查询数据状态: 模糊地址'
  # elsif x[0]['state'] == '4'
  #   data_status =  '查询数据状态: 疑似虚假地址'
  # end
  #
  # if x[0]['fmtAddress'] == '-1'
  #   fmt_add =  '格式化地址: 权限不足 '
  # else
  #   fmt_add =  ' 格式化地址: ' + x[0]['fmtAddress']
  # end
  #
  # if x[0]['addressPorperty'] == '-1'
  #   add_por = rs['addressPorperty'] + '地址属性: 权限不足'
  # elsif  x[0]['addressPorperty'] == 'home'
  #   add_por =  rs['addressPorperty']+ '地址属性: 疑似家庭地址'
  # elsif  x[0]['addressPorperty'] == 'work'
  #   add_por = rs['addressPorperty'] + '地址属性:疑似单位地址'
  # elsif  x[0]['addressPorperty'] == 'other'
  #   add_por =  rs['addressPorperty'] +'地址属性: 其他高频地址'
  # end
  # p data  =  "#{data_status}" +
  #  "#{fmt_add}" +
  #  "#{add_por}"

