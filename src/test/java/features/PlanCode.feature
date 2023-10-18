Feature: plan code Testing

  Background: Setup test
    Given url "https://qa.insurance-api.tekschool-students.com"

    Scenario: Validate /api/plans/get-all-plan-code
      Given path "/api/token"
      Given request {"username" : "supervisor", "password" : "tek_supervisor"}
      When method post
      Then status 200
      And print response

      * def validToken = "Bearer " + response.token
      Given path "/api/plans/get-all-plan-code"
      And header Authorization = validToken
      When method get
      Then status 200
      And print response
      And assert response[0].planExpired == false
      And assert response[1].planExpired == false
      And assert response[2].planExpired == false
      And assert response[3].planExpired == false

   # Story 7) Activity

    #Endpoint: /api/accounts/get-account

   # Send request

   # Validate response status is 200

      #And Response contain primary person id