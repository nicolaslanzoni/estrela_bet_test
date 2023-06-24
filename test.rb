require 'uri'
require 'net/http'
require 'openssl'

url = URI("https://estrelabet.com/api-v2/name-search/d/23/estrelabet/cruzeiro")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["cookie"] = 'NCC=PTB'
request["Accept"] = 'application/json, text/plain, */*'
request["Cache-Control"] = 'no-cache'
request["Connection"] = 'keep-alive'
request["Content-Type"] = 'application/json'
request["Cookie"] = '_fbp=fb.1.1687558884740.53973423; _ga_JNY80EMZ8E=GS1.1.1687558885.12.0.1687558885.60.0.0; __nxquid=xFPdUxcKyJcRPXohKGV8Ruo7HiTRWA==0014'
request["Origin"] = 'https://estrelabet.com'
request["Pragma"] = 'no-cache'
request["Referer"] = 'https://estrelabet.com/ptb/bet/search/cruzeiro'
request["Sec-Fetch-Dest"] = 'empty'
request["Sec-Fetch-Mode"] = 'cors'
request["Sec-Fetch-Site"] = 'same-origin'
request["User-Agent"] = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 OPR/95.0.0.0'
request["bragiurl"] = 'https://bragi.sportingtech.com/'
request["sec-ch-ua"] = '"Opera";v="95", "Chromium";v="109", "Not;A=Brand";v="24"'
request["sec-ch-ua-mobile"] = '?0'
request["sec-ch-ua-platform"] = '"Linux"'
request.body = "{\"requestBody\":{\"name\":\"cruzeiro\",\"bragiUrl\":\"https://bragi.sportingtech.com/\"},\"device\":\"d\",\"languageId\":23}"

response = http.request(request)
puts response.read_body