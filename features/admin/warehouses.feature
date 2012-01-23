Feature: Managing Warehouses
  In order to have a working warehouses extension
  As an admin
  I want to be able to create, update and delete warehouses

  Background:
    Given I am admin

  Scenario: Creating a warehouse
    When I start creating a warehouse
    And I submit the following warehouse:
      | Name    | Huge Warehouse   |
      | Details | We are ... |
    Then we should have the following warehouse:
      | Name    | Huge Warehouse   |
      | Details | We are ... |

  Scenario: Listing warehouses
    Given there are 30 warehouses


