Feature: Create Account Testing

#  Story 9) Activity
#  Endpoint: /api/accounts/add-primary-account
#  Send request
#  Validate response is 201
#  And validate response contain correct email entity
  Background: Setup test
    Given url "https://qa.insurance-api.tekschool-students.com"
    * def tokenResult = callonce read('GenerateToken.feature')
    * def token = "Bearer " + tokenResult.response.token

  Scenario: Create Valid account
    Given path "/api/accounts/add-primary-account"
    And request
    """
    {
      "email": "mohammad_instructor12345@tekschool.us",
      "firstName": "Mohammad",
      "lastName": "Shokriyan",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "Instructor",
      "dateOfBirth": "1992-10-18"
     }
    """
    When method post
    And print response
    Then status 201
    And assert response.email == "mohammad_instructor12345@tekschool.us"
    * def createdAccountId = response.id
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    When method delete
    Then status 200
    And print response
    And match response contains {"message" :  "Account Successfully deleted" , "status" :  true}

