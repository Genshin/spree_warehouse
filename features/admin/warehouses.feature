Feature: Managing Warehouses
  In order to have a working warehouses extension
  As an admin
  I want to be able to create, update and delete warehouses

  Background:
    Given I am admin
    Given I am at warehouses menu
 
  Scenario: Listing warehouses
    Given there are 30 warehouses
    When I visit warehouses listing
    Then we should have 30 warehouses

  Scenario: Creating a warehouse
    When I start creating a warehouse
    And I submit the following warehouse:
      | Name    | Huge Warehouse   |
      | Details | We are ... |
    Then we should have the following warehouse:
      | Name    | Huge Warehouse   |
      | Details | We are ... |
  
  Scenario: Showing a warehouse
    Given a warehouse "Subaru" exists
    When I visit the warehouse path
    Then we should see the "Subaru" warehouse
    

  @wip
  @javascript
  Scenario: Deleting a warehouse
    Given a warehouse "Huge Warehouse" exists
    When I delete the "Huge Warehouse" warehouse
    Then we should have flash message


