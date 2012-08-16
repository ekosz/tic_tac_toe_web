require_relative 'test_helper'

class PlayTest < MiniTest::Unit::TestCase
  @@content = File.read(File.expand_path(File.dirname(__FILE__) + '/../views/play.erb'))

  def setup
    @player = TicTacToe::HumanPlayer.new(letter: 'x')
    @player_1 = TicTacToe::PlayerPresenter.new(@player)
    @player_2 = TicTacToe::PlayerPresenter.new(@player)
  end

  def test_empty_board_form_count
    create_game

    node = Nokogiri::HTML(ERB.new(@@content).result(binding))

    assert_equal 9, node.css('form').count
  end

  def test_displays_correct_number
    create_game

    node = Nokogiri::HTML(ERB.new(@@content).result(binding))

    assert_equal '1', node.css("form")[0].text.strip
    assert_equal '9', node.css("form")[-1].text.strip
  end

  def test_displays_correct_letter
    grid = [['x', nil, nil], [nil,nil,nil], [nil, nil, 'o']]
    create_game(grid, @player, @player)
    node = Nokogiri::HTML(ERB.new(@@content).result(binding))

    assert_equal 'x', node.css("form")[0].text.strip
    assert_equal 'o', node.css("form")[-1].text.strip
  end

  def test_player_json
    grid = [['x', nil, nil], [nil,nil,nil], [nil, nil, 'o']]
    create_game(grid, @player, @player)
    node = Nokogiri::HTML(ERB.new(@@content).result(binding))
    player_1_json = node.css("form")[0].css("input[name='player_1']").attr('value').value

    assert_equal 'x', JSON.parse(player_1_json)['letter']
  end

  private 

  def create_game(grid=nil, player_1=nil, player_2=nil)
    @game = TicTacToe::Game.new(grid, player_1, player_2)
    @presented_game = TicTacToe::GamePresentor.new(@game)
  end
end
