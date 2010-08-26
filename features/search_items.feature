Feature: Search items
  In order to find an item
  a user
  wants to be able to search for a given item

  Scenario: Search for an item
    Given the following items exist:
      |name|description|price|url|shop_name|shop_address|shop_suburb|shop_city|shop_state|shop_country|group|
      |alpha 1|description 1|1|/|1_name|1_address|1_suburb|1_city|1_state|1_country|tester|
      |bravo 2|description 2|2|url_2|2_name|2_address|2_suburb|2_city|2_state|2_country|tester|
      |charlie 3|description 3|3|url_3|3_name|3_address|3_suburb|3_city|3_state|3_country|tester|
      |delta 4|description 4|4|url_4|4_name|4_address|4_suburb|4_city|4_state|4_country|tester|
    Given I am on the homepage
    When I fill in "term" with "alpha 1"
    And I press "Search"
    Then I should see "Results of your search for 'alpha 1'"
    And I should see "alpha 1"
    And I follow "alpha 1"
    Then I should be on "the homepage"
