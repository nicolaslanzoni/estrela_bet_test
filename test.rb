require "minitest/autorun"
require_relative 'crawler/crawler.rb'

class TestCrawler < Minitest::Test
  def setup
    @crawler = Crawler.new
  end

  def test_that_crawler_can_get
    assert_equal '200', @crawler.get("https://estrelabet.com").code
  end

  def test_that_model_can_get_route
    p = Estrela.route :detail 
    t = 'TESTING_URL'
    assert_equal "https://estrelabet.com/ptb/bet/fixture-detail/#{t}", p[t]
  end
  
  def test_that_crawler_can_post
    @crawler.get("https://estrelabet.com/api-v2/left-menu/d/23/estrelabet/eyJyZXF1ZXN0Qm9keSI6e319")
    res = @crawler.post(Estrela.route(:detail_api)['48442316'], query: %({"requestBody":{"fixtureIds":[48442310],"bragiUrl":"https://bragi.sportingtech.com/"},"device":"d","languageId":23})) 
    assert_equal '200', res.code
  end

  def test_that_team_model_works
    assert_equal 'A', Team.new('A').name
  end

  def test_that_match_model_works
    a = Team.new('A')
    b = Team.new('b')
    odds = [1,2,3]
    m = Match.new(a,b,odds)

    assert_equal({ winner: a, loser: b, odds: 1}, m.outcome(won:a).to_h)
    assert_equal({winner: b, loser: a, odds: 2}, m.outcome(won:b).to_h)
    assert_equal({winner: nil, loser: nil, odds: 3}, m.outcome(won:nil).to_h)
  end


end