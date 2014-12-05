require_relative '../../lib/pages/node_js_against_humanity/AppPage'

Given /^four players open cards against humanity$/ do
  @page = NodeJsAgainstHumanity::AppPage.new(@test_env)
  (0..3).step do |i|
    @page.load_home(i)
  end
end

And /^each player logs into the game$/ do
  (0..3).step do |i|
    @page.create_user(i)
  end
end

And /^player "(\d+)" creates the game$/ do |player|
  player = player.to_i
  @page.create_game(player - 1)
end

And /^player "(\d+)" joins the first game available$/ do |player|
  player = player.to_i
  @page.join_game(0, player - 1)
end

And /^there should be "(\d+)" players in the game according to player "(\d+)"$/ do |num_players, player|
  player = player.to_i
  @page.assert_player_count(num_players, player - 1)
end
