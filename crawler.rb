# frozen_string_literal: true

require_relative 'crawler/crawler.rb'

def search_for name 
    c = Crawler.new
   
    re1 = c.set_cookie

    re2 = c.name_search name
    d = EstrelaParser.new re2.body
    d.parse
end


team_a, team_b, match = search_for "cruzeiro"


puts <<-MSG
#{team_a.name} vs #{team_b.name}
#{team_a.name} => odds de #{match.outcome(won: team_a).odds}
empate => odds de #{match.outcome(won: team_b).odds}
#{team_b.name} => odds de #{match.outcome(won: nil).odds}
MSG