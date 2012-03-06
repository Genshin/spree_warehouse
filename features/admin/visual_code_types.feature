Feature: Managing Visual Code Types
  As an admin
  I want to be able to create, update and delete visual code types

  Background:
    Given I am admin
    Given a visual code type exists
    Given I am at warehouses menu
    Given I am at visual code types sub menu
 
  Scenario: Listing visual code types
    When I visit visual code types listing
    Then we should have 1 visual code types

  Scenario: Creating a visual code type
    When I start creating a visual code type
    And I fill the visual code type form 
    Then we should see the new visual code type
    And we should have 2 visual code types
    
  Scenario: Editting a visual code type
    When I click edit button
    And I edit the visual code type
    Then we should see the editted visual code type
    And we should have 1 visual code types

