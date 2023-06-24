
class Match 
    Outcome = Struct.new(:winner, :loser, :odds)
    def initialize(a,b, odds)
        @team_a = a 
        @team_b = b 
        @won = Outcome[@team_a,@team_b, odds[0]]
        @lost = Outcome[@team_b,@team_a, odds[1]]
        @draw = Outcome[nil,nil, odds[2]]
    end
    
    def outcome(won:) 
        case won 
        when @team_a then @won 
        when @team_b then @lost 
        when nil then @draw
        end
    end
end

class Team
    attr :name 
    
    def initialize name 
        @name = name
    end

    
end