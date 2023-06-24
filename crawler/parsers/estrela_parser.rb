require_relative '../match.rb'
class EstrelaParser
    def initialize body
        @body = parser body
        @data = filter_dataset
    end
    def parser raw_body
        parsed_body = JSON.parse raw_body, symbolize_names: true
        parsed_body[:data]
    end

    def filter_dataset  
        @body.dig 0, :cs, 0, :sns, 0, :fs, 0
    end


    def parse 
        a = @data[:hcN]; b = @data[:acN]
        res = @data[:btgs][0][:fos]
        odds = []
        odds[0] =  res[0][:hO]
        odds[1] =  res[1][:hO]
        odds[2]= res[2][:hO]

        team_a = Team.new(a)
        team_b = Team.new(b)

        match = Match.new(team_a, team_b, odds)

        return team_a, team_b, match
    end
end