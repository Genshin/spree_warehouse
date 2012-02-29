Feature: Managing Visual Codes
  As an admin
  I want to be able to create, update and delete visual codes

  Background:
    Given I am admin
    Given a visual code type exists
    Given a visual code exists
    Given I am at warehouses menu
    Given I am at visual codes sub menu
 
  Scenario: Listing visual codes
    When I visit visual code listing
    Then we should have 1 visual codes

  Scenario: Creating a visual code
    When I start creating a visual code
    And I fill the visual code form 
    Then we should see the new visual code
    And we should have 2 visual codes
    
  Scenario: Editting a visual code
    When I click edit 
    And I edit the visual code 
    Then we should see the editted visual code
    And we should have 1 visual codes

