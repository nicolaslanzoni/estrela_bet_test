# frozen_string_literal: true
require "mechanize"
require "json"
require 'irb'
require './crawler/estrela.rb'
class Crawler
    attr :host, :routes, :search_query, :headers
    attr :agent, true
    def initialize
        @agent = Mechanize.new
        @agent.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 OPR/95.0.0.0"
        @uri = URI(Estrela[:host])
        @http = Net::HTTP.new(@uri.host, @uri.port)
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    def from_cookie_string str , &b
       parse = proc{Mechanize::Cookie.parse URI(Estrela[:host]), _1}

       str.split.each &parse >> b
    end

    def post route, query: nil, header: {}
        #return @agent.post "#{@host}#{route}", query, header if route.is_a? String
        
        request = Net::HTTP::Post.new(URI(route))
        request = Estrela.add_headers request 
        request.body = "{\"requestBody\":{\"name\":\"cruzeiro\",\"bragiUrl\":\"https://bragi.sportingtech.com/\"},\"device\":\"d\",\"languageId\":23}"
        @http.request(request)
        #@agent.post  route, query , header
    
    
    end

    def get  route, query: nil, header: {}
        #return @agent.get "#{@host}#{route}", query, header if route.is_a? String
        
        @agent.get  route#, query, header
    end

    
    
    def set_cookie 
        test_c = "_gcl_au=1.1.830381358.1686951875; _fbp=fb.1.1686951880438.172289487; vs_vid=LaxjlEDwVTrQq; vs_vfs=1; vs_sid=QXBRWgLjGc4Q; lvisionUserId=5f5eb89a-7959-44e1-8f4c-5e2f2f1fe578; _ga_XFRKZSHTQQ=GS1.1.1687031982.1.1.1687032215.0.0.0; vs_lift_ai=95-100; NCC=PTB; lang=ptb; _gid=GA1.2.223541999.1687555824; vs_conv_ai=50-54; _gat_UA-225043663-3=1; _ga_JNY80EMZ8E=GS1.1.1687555823.11.1.1687556011.45.0.0; _ga=GA1.1.1211388805.1686951876; _ga_E2ZYXEN6NV=GS1.2.1687555826.9.1.1687556013.0.0.0"
        p = ->(x){[ x.uri].each {pp _1}}
        p.call get(Estrela.route :set_cookie) 
        p.call get(Estrela.route(:detail)['48442316'])
        p.call get(:manifest)
        from_cookie_string(test_c) {@agent.cookie_jar << _1[0]}
        #p.call post(Estrela.route(:detail_api)['48442316'], query: %({"requestBody":{"fixtureIds":[48442310],"bragiUrl":"https://bragi.sportingtech.com/"},"device":"d","languageId":23})) 


    end
    
    def name_search  name
        get Estrela.route(:get_search)[name]
        t ||= 5 
        #crawler.agent.post 'https://estrelabet.com/api-v2/name-search/d/23/estrelabet/cruz'
        return post(Estrela.route(:name_search)[name], query: self.search_query,header: self.headers)
        print ' ✓ '
    rescue => e
        print ' ✗ '

        retry if 0<=(t-=1)
        binding.irb
        raise e
    end
    
    
end
def parser raw_body
    parsed_body = JSON.parse raw_body, symbolize_names: true
    #puts parsed_body.keys
    parsed_body[:data]
end
def filter_dataset data 
    data.dig 0, :cs, 0, :sns, 0, :fs, 0
end


def search_for name 
    c = Crawler.new
   
    re1 = c.set_cookie

    re2 = c.name_search name
    d = parser re2.body
    ds = filter_dataset d
end


items = search_for "palmeiras"
a = items[:hcN]; b = items[:acN]
puts "#{a } vs #{b }"
res = items[:btgs][0][:fos]
_a = res[0][:hO]
_nil = res[1][:hO]
_b= res[2][:hO]
puts <<-MSG
#{a} => odds de #{_a}
empate => odds de #{_nil}
#{b} => odds de #{_b}
MSG