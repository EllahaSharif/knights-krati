Feature: Create Account Testing

#  Story 9)

  #Endpoint: /api/accounts/add-primary-account

  #Send request

  #Validate response is 201

  #And validate response contain correct email entity
  Background: setup test
    Given url "https://qa.insurance-api.tekschool-students.com"

    Scenario: Create Valid account
      Given path "/api/accounts/add-primary-account"
      And request
      """
      {
  "id": 0,
  "email": "string",
  "firstName": "string",
  "lastName": "string",
  "title": "string",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "string",
  "dateOfBirth": "2023-10-18T01:34:33.082Z",
  "new": true
}
      """

