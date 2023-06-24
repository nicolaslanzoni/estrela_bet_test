Estrela = {
    host: 'https://estrelabet.com',
    routes: {
        set_cookie: '/api-v2/left-menu/d/23/estrelabet/eyJyZXF1ZXN0Qm9keSI6e319',
            name_search: ->(n){'/api-v2/name-search/d/23/estrelabet/' << n},
            detail_api: ->(n){'/api-v2/fixture-detail/d/23/estrelabet/' << n},
            detail: ->(n){'/ptb/bet/fixture-detail/' << n},
            manifest:  '/manifest.webmanifest',
            get_search: ->x{"/ptb/bet/search/#{x}"}
    },
    search_query: ->(n){ 
        {requestBody: { 
            name: n,
            bragiUrl: 'https://bragi.sportingtech.com/'
        },
        device: ?d,
        languageId: 23}
    },
    referer: ->n{"https://estrelabet.com/ptb/bet/search/#{n}"},
    search_query2: ->n{"{\"requestBody\":{\"name\":\"#{n}\",\"bragiUrl\":\"https://bragi.sportingtech.com/\"},\"device\":\"d\",\"languageId\":23}"},
    fixture_query: ->n{%({"requestBody":{"fixtureIds":["#{n}"],"bragiUrl":"https://bragi.sportingtech.com/"},"device":"d","languageId":23})},
    cookies: ->(n){"_fbp=fb.1.1687558884740.53973423; _ga_JNY80EMZ8E=GS1.1.1687558885.12.0.1687558885.60.0.0; #{n}"}

}

def Estrela.add_headers request 
    request["cookie"] = 'NCC=PTB'
    request["Accept"] = 'application/json, text/plain, */*'
    request["Cache-Control"] = 'no-cache'
    request["Connection"] = 'keep-alive'
    request["Content-Type"] = 'application/json'
    #request["Cookie"] = '_fbp=fb.1.1687558884740.53973423; _ga_JNY80EMZ8E=GS1.1.1687558885.12.0.1687558885.60.0.0; __nxquid=xFPdUxcKyJcRPXohKGV8Ruo7HiTRWA==0014'
    request["Origin"] = 'https://estrelabet.com'
    request["Pragma"] = 'no-cache'
    #request["Referer"] = 'https://estrelabet.com/ptb/bet/search/cruzeiro'
    request["Sec-Fetch-Dest"] = 'empty'
    request["Sec-Fetch-Mode"] = 'cors'
    request["Sec-Fetch-Site"] = 'same-origin'
    request["User-Agent"] = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 OPR/95.0.0.0'
    request["bragiurl"] = 'https://bragi.sportingtech.com/'
    request["sec-ch-ua"] = '"Opera";v="95", "Chromium";v="109", "Not;A=Brand";v="24"'
    request["sec-ch-ua-mobile"] = '?0'
    request["sec-ch-ua-platform"] = '"Linux"'
    request
end

def Estrela.route sym 
    rt = Estrela[:routes][sym]
    case rt
    when String then Estrela[:host] + rt
    when Proc then ->x{Estrela[:host] + rt[x]}
    end
end