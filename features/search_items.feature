Feature: Search items
  In order to find an item
  a user
  wants to be able to search for a given item

  Scenario: Search for an item
    Given the following items:
      |name|description|price|url|
      |name 1|description 1|1|/about|
      |name 2|description 2|2|url_2|
      |name 3|description 3|3|url_3|
      |name 4|description 4|4|url_4|
    Given I am on the homepage
    When I fill in "term" with "description 1"
    And I press "Search"
    Then I should see "name 1"
    And I should see "description 1"
    And I should see "1"
    And I follow "name 1"
    Then I should be on "the about page"
