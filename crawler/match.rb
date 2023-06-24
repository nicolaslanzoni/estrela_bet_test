require 'set'

class Match 
    Measure = Data.define(:odds, :outcome,:match) 
    Outcome = Struct.new(:won, :lost)
    def initialize(a,b)
        @team_a = a 
        @team_b = b 
        @teams = Set[a,b]

    end
    def outcomes
        [Outcome[a,b], Outcome[b,a] ,Outcome[@teams,@teams]]
    end

    def odds 
end

class Team
end

class 