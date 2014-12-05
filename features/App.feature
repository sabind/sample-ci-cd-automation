@hi
Feature: The Cards Against Humanity Home Page

  Scenario: Viewing the Home Page
    Given four players open cards against humanity
    And each player logs into the game
    And player "1" creates the game
    And player "2" joins the first game available
    And player "3" joins the first game available
    And player "4" joins the first game available
    Then there should be "3" players in the game according to player "1"
