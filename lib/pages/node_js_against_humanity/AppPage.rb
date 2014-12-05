require_relative '../BasePage'

module NodeJsAgainstHumanity
  class AppPage < BasePage
    def initialize(test_env)
      super test_env
      @home = "http://#{test_env[:url]}"
      @player1 = @browsers[0]
      @player2 = @browsers[1]
      @player3 = @browsers[2]
      @player4 = @browsers[3]
    end

    def create_user(browser=0)
      name = @browsers[browser].find_element(:css, "input[placeholder='enter your name']")
      name.send_keys(@test_env[:random_string])
    end

    def create_game(browser=0)
      create_game_el = @browsers[browser].find_element(:css, '#aCreatGame a')
      create_game_el.click

      wait = Selenium::WebDriver::Wait.new(:timeout => @wait_timeout)
      wait.until {
        @browsers[browser].find_element(:css, '#gameName')
      }
    end

    def join_game(index=0, browser=0)
      join_game_el = @browsers[browser].find_element(:css, '#availableGames button')
      join_game_el.click

      wait = Selenium::WebDriver::Wait.new(:timeout => @wait_timeout)
      wait.until {
        @browsers[browser].find_element(:css, '#gameName')
      }
    end

    def assert_player_count(players, browser=0)
      players_in_game = []
      wait = Selenium::WebDriver::Wait.new(:timeout => @wait_timeout)
      wait.until {
        players_in_game = @browsers[browser].find_elements(:css, '#roundHistory li')
      }

      fail "Expected 4 players, but found #{players_in_game.count}" unless players_in_game.count == 4
    end
  end
end