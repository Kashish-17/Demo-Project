
Feature: SubscriptionManagementinPass @feature_subscription_management

Background: 
  Given the user is logged into the Passenger Application

@validate_subscription_plans
Scenario Outline: Validate Subscription Management in Passenger Application
  Given the user navigates to the Subscription Management screen
  Then the Subscription Management screen is displayed
  And both Weekly and Monthly plans are visible
  And each plan has a functional Buy button
  When the user clicks on the Buy button for the Weekly plan
  Then the system redirects to the Payment Method screen
  And the correct plan details are shown
  And promotional messages are displayed if applicable
  Then the UI is responsive and meets accessibility standards
  And no errors are present in the UI

Examples:
  |  |
  |  |

@validate_payment_with_saved_card
Scenario Outline: Validate that a passenger can proceed with payment using a saved card
  When the user selects a saved card for payment
  And the user clicks the "Done" button
  Then the confirmation popup should appear
  And the popup should display correct payment details
  And the message about not navigating back should be visible
  And the payment process should initiate successfully
  And the UI should remain responsive throughout

Examples:
  | saved_card       |
  | Card ending in 1234 |

  @buy_monthly_plan
  Scenario Outline: Validate Redirection to Payment Method Screen
    When the user clicks on the "Buy" button for the Monthly plan
    Then the Payment Method screen should be displayed
    And saved card(s) should be listed
    And the "Done" button should be visible
    And the UI elements should be accessible
    And no error messages should be shown

  Examples:
    | <username> | <password> |
    |            |            |

@confirmation_popup
Scenario Outline: Validate Confirmation Popup Before Processing Purchase
  When the user selects a saved card
  And the user clicks the "Done" button
  Then the confirmation popup appears
  And the options Yes and No are visible
  And the message prompts the user for confirmation
  And the popup prevents interaction with the background
  And the UI is accessible and usable
  Then no errors are present

  Examples:
    | saved_card |
    | Card 1     |

@cancel_purchase
Scenario Outline: Validate cancelling purchase in confirmation popup
  When the user selects a saved card
  And the user clicks the Done button
  And the user selects No in the confirmation popup
  Then the system cancels the purchase
  And the user is redirected back to the Subscription Management screen
  And no purchase is processed
  And the UI remains responsive
  And no errors are present

  Examples:
    | <title>                                      |
    | Subscription Management in Passenger Application |


@warning_displayed_on_navigate_back
Scenario Outline: Validate warning message when navigating back during payment
  When the user selects a saved card
  And the user clicks the Done button
  And the user selects Yes in the confirmation popup
  And the user attempts to navigate back to the Subscription Management screen
  Then a warning message should be displayed
  And the payment process should not be interrupted
  And the UI should remain responsive

  Examples:
    | saved_card |
    | Card 1     |

@payment_confirmation
Scenario Outline: Validate Subscription Activation after Payment
  When the user selects a saved card
  And the user clicks the "Done" button
  And in the confirmation popup, the user selects "Yes"
  And the user completes the payment process
  Then the user observes the confirmation message
  And the message indicates successful activation
  And the UI is responsive

Examples:
  | <saved_card> |
  | Card 1      |

@payment_process
Scenario Outline: Validate Payment Process on Confirmation
  When the user selects a saved card
  And the user clicks the Done button
  And the user selects Yes in the confirmation popup
  Then the payment process should start
  And the user should see the message indicating not to navigate back
  And the payment process should be ongoing
  And the UI should remain responsive

Examples:
  | saved_card |
  | Card 1     |

@validate_active_plan_display
Scenario Outline: Validate Activated Plan under Active Plan
  When the user navigates to the Subscription Management screen
  And the user observes the Active Plan section
  Then the activated plan should be displayed
  And other Buy buttons should be disabled
  And the UI should be responsive
  And the plan details should be correct
  And no error messages should be shown

Examples:
  | No input data required |

@validate_cancelled_free_rides
Scenario Outline: Validate that cancelled free rides remain available
  Given the payment process completes successfully
  When the user navigates to the ride booking screen
  And the user books two rides using the free ride option
  And the user cancels one of the booked rides
  Then the availability of free rides remains unchanged
  When the user attempts to book another ride
  Then the cancelled ride is still available for booking
  And the UI remains responsive

Examples:
  |   |
  |   |

@free-ride-validation
Scenario Outline: Validate passenger receives two free rides per day
  When I complete the payment process successfully
  And I navigate to the ride booking screen
  And I attempt to book a ride
  Then two free rides should be available
  When I book one ride using the free ride option
  Then one free ride should remain after booking
  When I attempt to book another ride
  Then the second ride should be booked successfully
  And the UI should remain responsive

Examples:
  | <payment_status> | <ride_booking_screen> | <free_rides_available> | <ride_booked> | <remaining_free_rides> | <ui_responsive> |
  | successful        | displayed            | available              | booked         | remaining             | responsive       |

@successful_purchase_receipt
Scenario Outline: Validate Email Receipt After Successful Purchase of Subscription
  When I check the email inbox associated with the account
  Then I should look for an email receipt from the application
  When I open the email receipt
  Then I should verify the details in the receipt (subscription type, amount, date)
  And I should confirm that the email is formatted correctly
  And I should check for any promotional messages in the email
  Then I should validate that the UI is responsive

  Examples:
    | email_inbox |
    | user@example.com |

  Scenario Outline: Validate that the Subscription Management screen is responsive and usable on mobile devices
    When I navigate to the Subscription Management screen
    Then I verify that all subscription plans are displayed correctly
    And I check the functionality of the "Buy" buttons
    And I ensure that the layout adapts to the screen size
    And I validate that text is readable without zooming
    And I confirm that all interactive elements are easily tappable
    And I validate that the UI is responsive
    Then the application opens successfully on the mobile device
    And the Subscription Management screen is displayed correctly
    And all subscription plans are visible and formatted properly
    And the "Buy" buttons are functional
    And the layout adapts to the mobile screen size
    And text is readable without zooming
    And all interactive elements are easily tappable
    And the UI remains responsive

  Examples:
    | mobile_device |
    | device_1      |

  Scenario Outline: Validate error message for invalid email format
    When the user changes the email to "<email>"
    And the user saves the changes
    Then the system should respond with an error message
    And the user should remain on the profile settings screen
    And the UI should remain responsive
    And the error message should be clear and actionable

    Examples:
      | email   |
      | abc@    |

  Scenario Outline: Validate error message when no card is selected
    When the user clicks the "Done" button
    Then the system processes the payment attempt
    And an error message is displayed indicating a card must be selected
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable

  Examples:
    |  |
    |  |

  Scenario Outline: Validate that an appropriate error message is displayed if the user enters invalid card details
    When the user selects a saved card
    And the user edits the card details to invalid values
    And the user clicks the "Done" button
    Then the system processes the payment attempt
    And an error message is displayed indicating the invalid card details
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable

    Examples:
      | card_number         | expiration_date | CVV | cardholder_name |
      | 1234 5678 9012 3456 | 12/20           | 123 | John Doe        |

  Scenario Outline: Complete the payment process successfully for a subscription
    When the user completes the payment process successfully for a subscription
    Then the payment process completes successfully in the first instance

  Scenario Outline: Open a second instance of the application
    When the user opens a second instance of the application
    Then the second instance is opened

  Scenario Outline: Attempt to purchase the same subscription in the second instance
    When the user attempts to purchase the same subscription in the second instance
    Then an error message is displayed in the second instance indicating the subscription is already active

  Scenario Outline: Observe the system response
    When the user observes the system response
    Then the user remains on the Subscription Management screen in the first instance

  Scenario Outline: Verify the error message displayed in the second instance
    When the user verifies the error message displayed in the second instance
    Then the error message is clear and actionable in the second instance

  Scenario Outline: Check that the user remains on the Subscription Management screen in the first instance
    When the user checks that they remain on the Subscription Management screen in the first instance
    Then the UI remains responsive in both instances

  Scenario Outline: Validate that the UI is responsive in both instances
    When the user validates that the UI is responsive in both instances
    Then no errors are present

  Scenario Outline: Confirm that the error message is clear and actionable in the second instance
    When the user confirms that the error message is clear and actionable in the second instance
    Then the UI is accessible

Examples:
  | action                                                                 |
  | Complete the payment process successfully for a subscription           |
  | Open a second instance of the application                               |
  | Attempt to purchase the same subscription in the second instance       |
  | Observe the system response                                             |
  | Verify the error message displayed in the second instance              |
  | Check that the user remains on the Subscription Management screen      |
  | Validate that the UI is responsive in both instances                   |
  | Confirm that the error message is clear and actionable in the second instance |

  Scenario Outline: Validate that the Subscription Management screen is accessible for users with disabilities
    When the user uses a screen reader to read the page content
    Then the screen reader reads the content correctly
    When the user verifies that all UI elements are labeled correctly
    Then all UI elements are labeled appropriately
    When the user checks keyboard navigation through the screen
    Then keyboard navigation is smooth and functional
    When the user ensures that all buttons and links are reachable via keyboard
    Then all buttons and links are accessible via keyboard
    When the user validates that tooltips are available for all interactive elements
    Then tooltips are available for interactive elements
    When the user confirms that the page structure is logical and easy to follow
    Then the page structure is logical and easy to navigate
    When the user validates that the UI is responsive
    Then the UI remains responsive

  Examples:
    | action |
    | Follow the step actions |

  Scenario Outline: Validate network failure during payment process
    When the user selects a valid saved card
    And the user clicks the "Done" button
    And a network failure is simulated during the payment process
    Then an error message is displayed indicating the network issue
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable

  Examples:
    | valid_card       |
    | <valid_card>     |

  Scenario Outline: Validate server error message during payment process
    When the user selects a valid saved card
    And the user clicks the "Done" button
    And a server error is simulated during the payment process
    Then the system should display an error message indicating the server issue
    And the user should remain on the Payment Method screen
    And the UI should remain responsive
    And the error message should be clear and actionable

  Examples:
    | saved_card       |
    | Valid Saved Card |

  Scenario Outline: Validate session timeout during payment process
    When the user selects a valid saved card
    And the user clicks the Done button
    And the session times out during the payment process
    Then the system displays an error message indicating the session has expired
    And the user is redirected to the login screen
    And the UI remains responsive
    And the error message is clear and actionable

    Examples:
      | valid_card       |
      | <valid_card>     |

  Scenario Outline: Validate that an appropriate error message is displayed if the user enters invalid card details
    When the user selects a saved card
    And the user edits the card details to invalid values
    And the user clicks the "Done" button
    Then the system processes the payment attempt
    And an error message is displayed indicating the invalid card details
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable

    Examples:
      | card_number         | expiration_date | CVV | cardholder_name |
      | 1234 5678 9012 3456 | 12/20           | 123 | John Doe        |

  Scenario Outline: Validate server error message during payment process
    When the user selects a valid saved card
    And the user clicks the "Done" button
    And a server error is simulated during the payment process
    Then the system should display an error message indicating the server issue
    And the user should remain on the Payment Method screen
    And the UI should remain responsive
    And the error message should be clear and actionable

  Examples:
    | valid_saved_card |
    | <valid_saved_card> |

  Scenario Outline: Validate that an appropriate error message is displayed if the user selects an expired card for payment
    When the user selects an expired saved card
    And the user clicks the Done button
    Then the system processes the payment attempt
    And an error message is displayed indicating the card is expired
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable
    And no errors are present

  Examples:
    | expired_card |
    | Card 1234    |

  Scenario Outline: Attempt to purchase an active subscription
    When the user clicks the "Buy" button for the same subscription plan
    Then the system should display an error message indicating the subscription is already active
    And the user should remain on the Subscription Management screen
    And the UI should remain responsive
    And the error message should be clear and actionable

  Examples:
    | subscription_plan |
    | Basic Plan        |

  Scenario Outline: Validate that an appropriate error message is displayed if the selected payment method is invalid
    When the user selects an <payment_method>
    And the user clicks the "Done" button
    Then the system processes the payment attempt
    And an error message is displayed
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable

    Examples:
      | payment_method                |
      | invalid or expired saved card  |

  Scenario Outline: Validate that an appropriate error message is displayed if the user attempts to select an invalid subscription plan
    When the user attempts to select an invalid subscription plan
    And the user clicks the Buy button
    Then the system should display an error message indicating the plan is invalid
    And the user should remain on the Subscription Management screen
    And the UI should remain responsive
    And the error message should be clear and actionable

  Examples:
    | invalid_subscription_plan |
    | NonExistentPlan          |

  Scenario Outline: Validate that an appropriate error message is displayed if the user attempts to proceed with an invalid payment amount
    When the user selects a valid saved card
    And the user edits the payment amount to "<payment_amount>"
    And the user clicks the Done button
    Then the system processes the payment attempt
    And an error message is displayed indicating the payment amount is invalid
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable

    Examples:
      | payment_amount |
      | abc            |

  Scenario Outline: Validate that an appropriate error message is displayed if the user selects an expired card for payment
    When the user selects an expired saved card
    And the user clicks the Done button
    Then the system processes the payment attempt
    And an error message is displayed indicating the card is expired
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable

  Examples:
    | expired_card |
    | Card 1234    |

  Scenario Outline: Attempt to purchase an active subscription
    When the user clicks the "Buy" button for the same subscription plan
    Then the system should display an error message indicating the subscription is already active
    And the user should remain on the Subscription Management screen
    And the UI should remain responsive
    And the error message should be clear and actionable

  Examples:
    | subscription_plan |
    | Basic Plan        |

@invalid-subscription-plan
Scenario Outline: Validate error message for invalid subscription plan
  When I attempt to select an invalid or non-existent subscription plan
  And I click the "Buy" button
  Then an error message should be displayed indicating the plan is invalid
  And the user should remain on the Subscription Management screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    | action                |
    | select invalid plan   |

  @feature_subscription_management
  @network_failure_error
  Scenario Outline: Validate Error Message during Network Failure
    When the user selects a valid saved card
    And the user clicks the "Done" button
    And the system simulates a network failure during the payment process
    Then an error message should be displayed indicating the network issue
    And the user should remain on the Payment Method screen
    And the UI should remain responsive

  Examples:
    | <saved_card> |
    | valid_card    |

@invalid_payment_method
Scenario Outline: Validate Error Message for Invalid Payment Method
  When the user selects "<card>"
  And the user clicks the "Done" button
  Then an error message should be displayed
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

  Examples:
    | card                          |
    | invalid or expired saved card |

  @invalid_email_format
  Scenario Outline: Validate Error Message for Invalid Email Format
    When the user changes the email to "<email>"
    And the user saves the changes
    Then an error message should be displayed indicating the email format is invalid
    And the user should remain on the profile settings screen
    And the UI should remain responsive

    Examples:
      | email  |
      | abc@   |

@error-message-no-card-selected
Scenario Outline: Validate Error Message when No Card is Selected
  Given no card is selected
  When the user clicks the "Done" button
  Then an error message should be displayed indicating a card must be selected
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    |   |
    |   |

@session_timeout
Scenario Outline: Validate Session Timeout During Payment Process
  When the user selects a valid saved card
  And the user clicks the Done button
  And a session timeout is simulated during the payment process
  Then the user should observe an error message indicating the session has expired
  And the user should be redirected to the login screen
  And the UI should remain responsive

Examples:
  | saved_card       |
  | valid_saved_card |

  @feature_subscription_management
  @concurrent_purchase_attempt
  Scenario Outline: Validate Concurrent Purchase Attempts
    Given the user completes the payment process successfully for a subscription
    When the user opens a second instance of the application
    And the user attempts to purchase the same subscription in the second instance
    Then the system should display an error message indicating the subscription is already active
    And the user should remain on the Subscription Management screen in the first instance
    And the UI should remain responsive in both instances
    And the error message should be clear and actionable in the second instance

    Examples:
      | <subscription> |
      | active         |

@unauthorized_payment
Scenario Outline: Validate Error Message for Unauthorized Payment Method
  When the user selects a valid saved card
  And the system simulates an authorization failure during payment processing
  And the user clicks the "Done" button
  Then an error message should be displayed indicating the payment method is not authorized
  And the user should remain on the Payment Method screen
  And the UI should remain responsive

Examples:
  | <valid_saved_card> |
  | Valid Card 1       |

@error_message_display
Scenario Outline: Validate Error Message for Deleted Payment Method
  When the user selects a payment method that has been deleted or is no longer available
  And the user clicks the "Done" button
  Then the system should process the payment attempt
  And an error message should be displayed indicating the payment method is not found
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

Examples:
  | payment_method   |
  | Deleted Method 1 |
  | Deleted Method 2 |

  @error-message-no-plan-selected
  Scenario Outline: Validate Error Message Without Subscription Plan
    Given no subscription plan is selected
    When the user clicks the "Buy" button
    Then an error message should be displayed indicating a subscription must be selected
    And the user should remain on the Subscription Management screen
    And the UI should be responsive
    And the error message should be clear and actionable

    Examples:
      |    |
      |    |

@timeout_error_message
Scenario Outline: Validate that an appropriate error message is displayed if the payment method times out during processing
  When the user selects a valid saved card
  And a timeout is simulated during payment processing
  And the user clicks the "Done" button
  Then the error message should be displayed indicating the payment method timed out
  And the user should remain on the Payment Method screen
  And the UI should remain responsive

  Examples:
    | <saved_card> |
    | valid_card   |

@unsupported_payment_method
Scenario Outline: Validate Unsupported Payment Method
  When the user selects a payment method that is not supported
  And the user clicks the "Done" button
  Then an error message indicating the payment method is not supported should be displayed
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

Examples:
  | unsupported_payment_method |
  | Credit Card Not Accepted   |

@unavailable_payment_method
Scenario Outline: Validate Error Message for Unavailable Payment Method
  When the user selects a payment method that is not available
  And the user clicks the "Done" button
  Then the system should display an error message indicating the payment method is not available
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

Examples:
  | payment_method |
  | Credit Card    |

@payment-method-decline
Scenario Outline: Validate Error Message for Declined Payment Method
  When the user selects a valid saved card
  And the system simulates a decline during payment processing
  And the user clicks the "Done" button
  Then the user should observe the system response
  And the error message should indicate the payment method was declined
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    |   |
    |   |

  Scenario Outline: Validate minimum required card details
    When I enter the minimum required card details with card number <card_number>, expiration date <expiration_date>, cvv <cvv>, and cardholder name <cardholder_name>
    And I click the "Done" button
    Then I observe the system response
    And I verify that the payment is processed successfully
    And I check for any error messages
    And I validate that the UI is responsive
    And I confirm that the payment details are correct

    Examples:
      | card_number        | expiration_date | cvv | cardholder_name |
      | 4111111111111111   | 12/25           | 123 | John Doe        |

  Scenario Outline: Validate that the system can handle the maximum payment amount without errors
    When the user selects a valid saved card
    And the user enters the maximum payment amount allowed as <payment_amount>
    And the user clicks the "Done" button
    Then the system processes the payment successfully
    And no error messages are displayed
    And the UI remains responsive
    And the payment details are correct
    And the payment is processed without issues
    And no errors are present

  Examples:
    | payment_amount |
    | 999999.99      |

  @feature_subscription_management
  @unsupported_payment_method
  Scenario Outline: Validate Unsupported Payment Method Error Message
    When the user selects a payment method that is not supported by the bank
    And the user clicks the "Done" button
    Then the system should display an error message indicating the payment method is not supported by the bank
    And the user should remain on the Payment Method screen
    And the UI should be responsive
    And the error message should be clear and actionable

  Examples:
    | payment_method           |
    | Credit Card from Bank X  |

@unconfigured_payment_method
Scenario Outline: Validate Unconfigured Payment Method Error Message
  When I select a payment method that is not configured
  And I click the "Done" button
  Then the system processes the payment attempt
  And the system displays an error message indicating the payment method is not configured
  And the user remains on the Payment Method screen
  And the UI remains responsive
  Then the error message is clear and actionable

  Examples:
    | payment_method        |
    | Credit Card (Test Card) |

@unrecognized_payment_method
Scenario Outline: Validate error message for unrecognized payment method
  When I select a payment method that is not recognized
  And I click the "Done" button
  Then the system should process the payment attempt
  And an error message should be displayed indicating the payment method is not recognized
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    | paymentMethod     |
    | Unknown Card Type |

@invalid-payment-method
Scenario Outline: Validate Error Message for Invalid Payment Method
  When the user selects "<payment_method>"
  And the user clicks the "Done" button
  Then an error message is displayed indicating the payment method is not valid
  And the user remains on the Payment Method screen
  And the UI is responsive
  And the error message is clear and actionable

  Examples:
    | payment_method      |
    | invalid payment method |

@unconfigured_payment_method
Scenario Outline: Validate error message for unconfigured payment method
  When the user selects a payment method that is not configured for the transaction
  And the user clicks the "Done" button
  Then an error message should be displayed indicating the payment method is not configured for the transaction
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    | payment_method      |
    | Unconfigured Card   |

@unavailable_payment_method
Scenario Outline: Validate Error Message for Unavailable Payment Method
  When the user selects a payment method that is not available for the transaction
  And the user clicks the "Done" button
  Then an error message should be displayed indicating the payment method is not available for the transaction
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

Examples:
  | unavailable_payment_method     |
  | Credit Card Not Supported      |

@max_saved_cards
Scenario Outline: Validate Maximum Number of Saved Cards
  When I add the maximum number of saved cards allowed
  Then all cards should be displayed correctly
  And I click the "Done" button with one of the cards selected
  And I observe the system response
  And I check for any performance issues
  And I validate that the UI is responsive
  And I confirm that no error messages are shown

  Examples:
    | <saved_card_count> |
    | 5                   |

@valid-minimum-payment
Scenario Outline: Validate Minimum Payment Amount Handling
  When the user selects a valid saved card
  And the user enters the minimum payment amount "<minimum_payment_amount>"
  And the user clicks the "Done" button
  Then the system processes the payment successfully
  And no error messages are displayed
  And the UI remains responsive

  Examples:
    | minimum_payment_amount |
    | 10                     |
