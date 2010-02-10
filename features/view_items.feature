Feature: View all items
  In order to find an item
  an administrator
  wants to be able to view all items

  Scenario: Search for an item
    Given a fresh database
    Given the following items:
      |name|description|price|url|shop_name|shop_address|shop_suburb|shop_city|shop_state|shop_country|
      |name 1|description 1|1|/about|1_name|1_address|1_suburb|1_city|1_state|1_country|
      |name 2|description 2|2|url_2|2_name|2_address|2_suburb|2_city|2_state|2_country|
      |name 3|description 3|3|url_3|3_name|3_address|3_suburb|3_city|3_state|3_country|
      |name 4|description 4|4|url_4|4_name|4_address|4_suburb|4_city|4_state|4_country|
    Given I am on the item index page
    Then I should see "name 1"
    And I should see "1"
    And I should see "1_suburb"
    And I should see "1_city"