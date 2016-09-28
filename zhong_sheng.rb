require 'rest-client'
require 'json'
require 'digest/md5'
require 'net/http'
require 'openssl'


class ZhongSheng
  @@token=nil
  @@time=nil
  @@curl=nil


  def self.aes_encrypt(encrypted_string)
    a=[45, -39, -64, 24, -16, -12, 70, 99, 108, 45, 27, 88, 97, -69, 11, -122]
    key=a.pack('c*')
    aes = OpenSSL::Cipher::Cipher.new("AES-128-ECB")
    aes.encrypt
    aes.key = key
    txt = aes.update(encrypted_string) << aes.final
    txt.unpack('H*')[0].upcase
  end

  def self.aes_decrypt(encrypted_string)
    a=[45, -39, -64, 24, -16, -12, 70, 99, 108, 45, 27, 88, 97, -69, 11, -122]
    key=a.pack('c*')
    aes = OpenSSL::Cipher::Cipher.new("AES-128-ECB")
    aes.decrypt
    aes.key = key
    result = aes.update([encrypted_string].pack('H*'))
    result << aes.final

    result
  end


  def self.md5(str)
    Digest::MD5.hexdigest(str).upcase[8..23]
  end


  @@username ='yshd' #'xly_zz' #'yshd'
  @@password = '9dML2L2h' #'zscs151230' #zz123456' #'9dML2L2h'
  @@msg = @@username + md5(@@password)

  @@url="http://api10.g315.net:8511/wndc/tkn/queryaccount.do?msg=#{@@msg}&token=&action=login"


   def self.mobile_duration(token,mobile)

    ori_msg={mobile => {cid: '' , mobile:mobile}}

    msg = aes_encrypt(ori_msg.to_json)
    query_url="#{@@curl}?mid=114&action=mobinnet&token=#{token}&f=1&msg=#{msg}"
     ori_msg.to_json
     query_url
    response = RestClient.get query_url

    response.to_str

    result = JSON.parse(response.to_str)
     aes_decrypt(result['msg'])
    aes_decrypt(result['msg'])
  end

  def self.mobile_status(token,mobile)

       ori_msg={ mobile => { cid: '', mobile:mobile}}
    msg = aes_encrypt(ori_msg.to_json)
    query_url="#{@@curl}?mid=116&action=mobstat&token=#{token}&f=1&msg=#{msg}"
    ori_msg.to_json
    query_url
    response = RestClient.get query_url

    response.to_str

    result = JSON.parse(response.to_str)
    aes_decrypt(result['msg'])
    aes_decrypt(result['msg'])
  end

  def self.mobile_real_name(token,mobile,id_number,name)

     ori_msg={mobile => {idNo: id_number, idType: "0101", name: name, cid: '', mobile:mobile}}
     puts ori_msg
    msg = aes_encrypt(ori_msg.to_json)
    query_url="#{@@curl}?mid=112&action=mobid4&token=#{token}&f=1&msg=#{msg}"
    ori_msg.to_json
    query_url
    response = RestClient.get query_url

    response.to_str

    result = JSON.parse(response.to_str)
    aes_decrypt(result['msg'])
    aes_decrypt(result['msg'])
  end


  def self.login
    if @@token and @@token.length>0 and  @@time and Time.now-@@time < 1800
      return @@token
    end

     @@url
    response = RestClient.get @@url
      response

     result = JSON.parse(response.to_str)
    @@token= URI.encode(result['msg'])
    @@time= Time.now
    @@curl = result['callbackUrl']
    URI.encode(result['msg'])
  end

  def self.check_duration
     token = login
      mobile_duration(token,'18515920925')
  end


  def self.check_status
    token = login
    mobile_status(token,'13511111111')
  end

  def self.check_real
    token = login
    mobile_real_name(token,'18515920925' ,'659001198609251830' ,'闫威臻')
  end

end

    #  s = ZhongSheng.check_duration


   # '在网状态'  + ZhongSheng.check_status
  puts rs = ZhongSheng.check_real


