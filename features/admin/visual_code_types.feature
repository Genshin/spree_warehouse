Feature: Managing Visual Code Types
  As an admin
  I want to be able to create, update and delete visual code types

  Background:
    Given I am admin
    Given I am at warehouses menu
     
  Scenario: Listing visual code types
    Given a visual code type exists
    When I visit visual code types listing
    Then we should have 1 visual code types
    And we should have a "Delete" link
    And we should have a "Edit" link
    
  Scenario: Listing visual code types without delete link
    Given a barcode exists
    When I visit visual code types listing
    Then we should not have a "Delete" link
    And we should not have a "Edit" link


  Scenario: Creating a visual code type
    When I visit visual code types listing
    And I start creating a visual code type
    And I fill the visual code type form 
    Then we should see the new visual code type
    And we should have 1 visual code types
    And we should have a "Delete" link
    And we should have a "Edit" link
    
  Scenario: Editting a visual code type
    Given a visual code type exists
    When I visit visual code types listing
    And I click edit button
    And I edit the visual code type
    Then we should see the editted visual code type
    And we should have 1 visual code types
    

