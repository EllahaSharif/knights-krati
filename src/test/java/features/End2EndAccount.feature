Feature: End to end account creation

  Background: Setup Test get token
    Given url BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    * def token = "Bearer " + tokenResult.response.token

  @End2End
  Scenario:Create Account end to end.
    Given path "/api/accounts/add-primary-account"
    * def data = Java.type('data.DataGenerator')
    * def emailData = data.getEmail()
    And request

    """
{
  "email": "#(emailData)",
  "title": "Mr.",
  "firstName": "Ahmad",
  "lastName": "Ahmadi",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Actor",
  "dateOfBirth": "2000-10-20"
}

  """
  And header Authorization = token
  When method post
  Then status 201
  And assert response.email == emailData
    * def createdAccountId = response.id
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    And request
    """
{
  "addressType": "123456 hollywood road",
  "addressLine1": "",
  "city": "Falls Church",
  "state": "Virginia",
  "postalCode": "77880",
  "countryCode": "",
  "current": true
}
   """
    When method post
    Then status 201
    And assert response.postalCode == "77880"
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    And request
    """
    {
  "make": "Toyota",
  "model": "Camry",
  "year": "2023",
  "licensePlate": "try-56782"
}
    """
    And method post
    Then status 201
    And assert response.make == "Toyota"
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    And request
    """
  {
  "phoneNumber": "9876578975",
  "phoneExtension": "",
  "phoneTime": "Anytime",
  "phoneType": "cell phone"
}
    """
    When method post
    Then status 201
    And assert response.phoneNumber == "9876578975"
    And print createdAccountId
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    And method delete
    Then status 200
    And match response == {"status": true,"httpStatus": "OK","message": "Account Successfully deleted"}




