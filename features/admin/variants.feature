Feature: Attach visual code to a product variant
  As an admin
  I want to be able to update variant's visual code 

  Background:
    Given I am admin
    Given a visual code type exists
    Given a product and variant exist
    Given I am at products edit view
    
  @wip  
  Scenario: Creating a variant
    When I click variants button
    And I start creating a variant
    And I fill the variant form
    Then we should have 1 variants
  
  @wip
  Scenario: Updating a variant's visual code 
    When I click variants button
    And I click edit button
    And I click variants button
    And I click edit button
    And we should have 1 variants