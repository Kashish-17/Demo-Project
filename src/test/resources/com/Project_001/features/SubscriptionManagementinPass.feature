
Feature: SubscriptionManagementinPass @feature_subscription_management

Background: 
  Given the user is logged into the Passenger Application

@validate_subscription_plans
Scenario Outline: Validate that a logged-in passenger can view all available subscription plans on the subscription management screen
  Given the user navigates to the Subscription Management screen
  Then the Subscription Management screen is displayed
  And both Weekly and Monthly plans are visible
  And each plan has a functional Buy button
  When the user clicks on the Buy button for the Weekly plan
  Then the system redirects to the Payment Method screen
  And the correct plan details are shown
  And promotional messages are displayed if applicable
  And the UI is responsive and meets accessibility standards
  And no errors are present in the UI

  Examples:
    | username | password |
    | user1    | pass1    |

@buy_monthly_plan
Scenario Outline: Validate Subscription Management Functionality
  When the user clicks on the "Buy" button for the Monthly plan
  Then the user should be redirected to the Payment Method screen
  And the Payment Method screen should be displayed
  And the saved card(s) should be listed
  And the "Done" button should be visible
  And the UI elements should be accessible
  And no error messages should be shown

Examples: 
  | <username> |
  | valid_user  |

@validate_payment_with_saved_card
Scenario Outline: Validate that a passenger can proceed with payment using a saved card by clicking the "Done" button
  When the user selects a saved card for payment
  And the user clicks the "Done" button
  Then the confirmation popup should appear
  And the popup should display correct payment details
  And the message about not navigating back should be visible
  And the payment process should initiate successfully
  And the UI should remain responsive

Examples:
  | saved_card |
  | Card 1     |

@validate_confirmation_popup
Scenario Outline: Validate Confirmation Popup Before Purchase
  Given the user selects a saved card
  When the user clicks the "Done" button
  Then the confirmation popup appears
  And the options Yes and No are visible
  And the message prompts the user for confirmation
  And the popup prevents interaction with the background
  And the UI is accessible and usable
  Then no errors are present

  Examples:
    | <saved_card> |
    | Sample Card  |

@cancel_purchase
Scenario Outline: Validate Cancelling Purchase in Confirmation Popup
  When the user selects a saved card
  And the user clicks the Done button
  And the user selects No in the confirmation popup
  Then the system cancels the purchase
  And the user is redirected back to the Subscription Management screen
  And no purchase is processed
  And the UI remains responsive

Examples:
  | saved_card |
  | Card123    |

@validate_payment_process
Scenario Outline: Validate that selecting "Yes" in the confirmation popup starts the payment process and shows a message not to navigate back
  When the user selects a saved card
  And the user clicks the "Done" button
  And the user selects "Yes" in the confirmation popup
  Then the system response should be observed
  And the message indicating not to navigate back should be visible
  And the payment process should start
  And the UI should be responsive

Examples:
  | saved_card |
  | Card 1     |

@warning_message_on_back_navigation
Scenario Outline: Validate Warning When Navigating Back During Payment Process
  When the user selects a saved card
  And the user clicks the "Done" button
  And the user selects "Yes" in the confirmation popup
  And the user attempts to navigate back to the Subscription Management screen
  Then a warning message should be displayed
  And the payment process should continue without interruption
  And the UI should remain responsive 

Examples:
  | <saved_card> |
  | Sample Card  |

@validate_payment_confirmation
Scenario Outline: Validate Payment Confirmation for Subscription Activation
  When the user selects a saved card
  And the user clicks the Done button
  And the user selects Yes in the confirmation popup
  And the user completes the payment process
  Then the user observes the confirmation message
  And the message indicates successful activation
  And the UI is responsive

Examples:
  | <saved_card> |
  | Card 1      |

@validate_active_plan
Scenario Outline: Validate that the activated plan is displayed under Active Plan
  When the user navigates to the Subscription Management screen
  And the user observes the Active Plan section
  Then the activated plan should be displayed
  And other Buy buttons should be disabled
  And the UI should be responsive
  And the plan details should be correct
  And no error messages should be shown

Examples:
  |   |
  |   |

@validate_free_rides
Scenario Outline: Validate that a passenger receives two free rides per day
  When the user completes the payment process successfully
  And the user navigates to the ride booking screen
  And the user attempts to book a ride
  Then two free rides should be available
  When the user books one ride using the free ride option
  Then one free ride should remain after booking
  When the user attempts to book another ride
  Then the UI should remain responsive

  Examples:
    | <payment_status> | <ride_booking_screen> | <free_rides_available> | <ride_booked> | <remaining_free_rides> | <ui_responsive> |
    | successful        | displayed            | available              | booked         | remaining             | responsive       |

@validate_cancelled_ride_availability
Scenario Outline: Validate that cancelled free rides remain available for the same day
  When the user navigates to the ride booking screen
  And the user books two rides using the free ride option
  And the user cancels one of the booked rides
  Then the user should check the availability of free rides
  And the user attempts to book another ride
  Then the user verifies that the cancelled ride is still available
  And the user validates that the UI is responsive

  Examples:
    |   |
    |   |

@validate_email_receipt
Scenario Outline: Validate that a passenger receives an email receipt after a successful purchase of a subscription
  When I check the email inbox associated with the account
  Then an email receipt should be received from the application
  When I open the email receipt
  Then the receipt should contain correct subscription details
  And the email should be formatted correctly and readable
  And promotional messages should be included if applicable
  Then the UI should remain responsive

  Examples:
    | <email_inbox> |
    | user@example.com |

@validate-accessibility
Scenario Outline: Validate Accessibility of Subscription Management Screen
  When I use a screen reader to read the page content
  Then the screen reader should read the content correctly
  And I verify that all UI elements are labeled correctly
  And I check keyboard navigation through the screen
  Then keyboard navigation should be smooth and functional
  And I ensure that all buttons and links are reachable via keyboard
  And I validate that tooltips are available for all interactive elements
  And I confirm that the page structure is logical and easy to follow
  And I validate that the UI is responsive

Examples:
  | screen_reader_action |
  | read page content    |

  @feature_subscription_management
  @validate_subscription_screen
  Scenario Outline: Validate that the Subscription Management screen is responsive and usable on mobile devices
    When the user navigates to the Subscription Management screen
    Then all subscription plans are displayed correctly
    And the "Buy" buttons are functional
    And the layout adapts to the mobile screen size
    And text is readable without zooming
    And all interactive elements are easily tappable
    And the UI remains responsive

    Examples:
      |   |
      |   |

@invalid_payment_method
Scenario Outline: Validate Error Message for Invalid Payment Method
  When I select an "<payment_method>"
  And I click the "Done" button
  Then the system should display an error message
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

  Examples:
    | payment_method              |
    | invalid or expired saved card |

@network_failure
Scenario Outline: Validate Network Failure during Payment Process
  When the user selects a valid saved card
  And the user clicks the "Done" button
  And a network failure is simulated during the payment process
  Then an error message is displayed indicating the network issue
  And the user remains on the Payment Method screen
  And the UI remains responsive

Examples:
  | <saved_card> |
  | valid_card    |

@server-error
Scenario Outline: Validate Error Message for Server Error During Payment Process
  Given the user selects a valid saved card
  And the user clicks the "Done" button
  When a server error is simulated during the payment process
  Then an error message should be displayed indicating the server issue
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

Examples:
  |  |
  |  |

@invalid_card_details
Scenario Outline: Validate error message for invalid card details
  Given the user selects a saved card
  When the user edits the card details to "<card_number>", "<expiration_date>", "<CVV>", "<cardholder_name>"
  And the user clicks the "Done" button
  Then the user should see an error message indicating the invalid card details
  And the user should remain on the Payment Method screen
  And the UI should remain responsive

  Examples:
    | card_number        | expiration_date | CVV | cardholder_name |
    | 1234 5678 9012 3456 | 12/20           | 123 | John Doe        |

@expired-card-selection
Scenario Outline: Validate Error Message for Expired Card Selection
  When the user selects an expired saved card
  And the user clicks the Done button
  Then the system processes the payment attempt
  And an error message is displayed indicating the card is expired
  And the user remains on the Payment Method screen
  And the UI remains responsive
  And the error message is clear and actionable

  Examples:
    | <expired_card> |
    | expired_card_1 |

@active_subscription_error
Scenario Outline: Validate Error Message for Active Subscription Purchase
  When the user completes the payment process successfully for a subscription
  And the user navigates to the Subscription Management screen
  And the user clicks the "Buy" button for the same subscription plan
  Then the system should display an error message indicating the subscription is already active
  And the user should remain on the Subscription Management screen
  And the UI should remain responsive
  And the error message should be clear and actionable

Examples:
  | <payment_status> | <screen_displayed> | <error_message> | <ui_responsive> |
  | success          | Subscription Management screen | Subscription is already active | true |

@invalid-email-format
Scenario Outline: Validate error message for invalid email format
  When the user navigates to the user profile settings
  And the user changes the email to "<email>"
  And the user saves the changes
  Then the user observes the system response
  And the user verifies the error message displayed
  And the user checks that they remain on the profile settings screen
  And the user validates that the UI is responsive

  Examples:
    | email  |
    | abc@   |

  @error-message-display
  Scenario Outline: Validate error message for no card selection
    Given no card is selected
    When the user clicks the "Done" button
    Then an error message is displayed indicating a card must be selected
    And the user remains on the Payment Method screen
    And the UI remains responsive
    And the error message is clear and actionable

    Examples:
      | card_selection |
      | no_card       |

  @concurrent_purchase_attempt
  Scenario Outline: Validate multiple concurrent purchase attempts
    Given the user completes the payment process successfully for a subscription
    When the user opens a second instance of the application
    And the user attempts to purchase the same subscription in the second instance
    Then the user observes the system response
    And the error message displayed in the second instance indicates the subscription is already active
    And the user remains on the Subscription Management screen in the first instance
    And the UI is responsive in both instances
    And the error message is clear and actionable in the second instance

    Examples:
      |  |
      |  |

@session_timeout_error
Scenario Outline: Validate Session Timeout During Payment Process
  When the user selects a valid saved card
  And the user clicks the Done button
  And a session timeout is simulated during the payment process
  Then an error message is displayed indicating the session has expired
  And the user is redirected to the login screen
  And the UI remains responsive

Examples:
  | <saved_card> |
  | valid_card    |

  @invalid_subscription_plan
  Scenario Outline: Validate Error Message for Invalid Subscription Plan
    When the user attempts to select an invalid subscription plan
    And the user clicks the "Buy" button
    Then an error message is displayed indicating the plan is invalid
    And the user remains on the Subscription Management screen
    And the UI remains responsive
    And the error message is clear and actionable
    And no errors are present
    And the UI is accessible

    Examples:
      | subscription_plan  |
      | Non-existent Plan   |
      | Invalid Plan        |

@invalid-payment-method
Scenario Outline: Validate error message for invalid payment method
  When the user selects an "<payment_method>"
  And the user clicks the "Done" button
  Then an error message should be displayed
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    | payment_method                |
    | invalid or expired saved card  |

@network_failure_error
Scenario Outline: Validate Error Message During Payment Process
  When the user selects a valid saved card
  And the user clicks the "Done" button
  And a network failure is simulated during the payment process
  Then an error message should be displayed indicating the network issue
  And the user should remain on the Payment Method screen
  And the UI should remain responsive

Examples:
  | <saved_card> |
  | valid_card   |

@validate_error_message
Scenario Outline: Validate error message during payment process
  When the user selects a valid saved card
  And the user clicks the "Done" button
  And a server error is simulated during the payment process
  Then the user should observe the system response
  And the user should see an error message indicating the server issue
  Then the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    |   |
    |   |

  @invalid_card_details
  Scenario Outline: Validate Error Message for Invalid Card Details
    Given the user selects a saved card
    When the user edits the card details to invalid values "<card_number>", "<expiration_date>", "<CVV>", "<cardholder_name>"
    And the user clicks the "Done" button
    Then an error message should be displayed indicating the invalid card details
    And the user should remain on the Payment Method screen
    And the UI should remain responsive

    Examples:
      | card_number           | expiration_date | CVV | cardholder_name |
      | 1234 5678 9012 3456  | 12/20           | 123 | John Doe       |

@expired-card-selection
Scenario Outline: Validate error message for selecting an expired card
  When the user selects an expired saved card
  And the user clicks the "Done" button
  Then the system should process the payment attempt
  And an error message should be displayed indicating the card is expired
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    | No input data required |

  @feature_subscription_management
  @error_message_display
  Scenario Outline: Validate Error Message for Active Subscription
    When the user navigates to the Subscription Management screen
    And the user clicks the "Buy" button for the same subscription plan
    Then an error message should be displayed indicating the subscription is already active
    And the user should remain on the Subscription Management screen
    And the UI should remain responsive
    And the error message should be clear and actionable

  Examples:
    | action |
    | Buy    |

  @invalid-email-format
  Scenario Outline: Validate error message for invalid email format
    When the user changes the email to "<email>"
    And the user saves the changes
    Then an error message should be displayed indicating the email format is invalid
    And the user should remain on the Profile Settings screen
    And the UI should remain responsive

    Examples:
      | email  |
      | abc@   |

@card_selection_error
Scenario Outline: Validate error message when no card is selected
  Given no card is selected
  When I click the "Done" button
  Then an error message should be displayed indicating a card must be selected
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

Examples:
  | title                                         |
  | Subscription Management in Passenger Application |

  @feature_subscription_management
  @concurrent_purchase_handling
  Scenario Outline: Validate Multiple Concurrent Purchase Attempts
    Given the user completes the payment process successfully for a subscription
    When the user opens a second instance of the application
    And the user attempts to purchase the same subscription in the second instance
    Then the system response should be observed
    And an error message should be displayed in the second instance indicating the subscription is already active
    And the user should remain on the Subscription Management screen in the first instance
    And the UI should be responsive in both instances
    And the error message should be clear and actionable in the second instance

    Examples:
      | Placeholder |
      |-------------|

@session-timeout-error
Scenario Outline: Validate Session Timeout During Payment Process
  When the user selects a valid saved card
  And the user clicks the "Done" button
  And a session timeout occurs during the payment process
  Then an error message should be displayed indicating the session has expired
  And the user should be redirected to the login screen
  And the UI should remain responsive

Examples:
  | <saved_card> |
  | ValidCard1   |

@invalid-subscription-plan
Scenario Outline: Validate that an appropriate error message is displayed if the user attempts to select an invalid subscription plan
  When the user attempts to select an invalid or non-existent subscription plan
  And the user clicks the "Buy" button
  Then the system should display an error message indicating the plan is invalid
  And the user should remain on the Subscription Management screen
  And the UI should remain responsive
  And the error message should be clear and actionable

Examples:
  | invalid_plan |
  | NonExistentPlan |

  @error_message_display
  Scenario Outline: Validate error message without subscription plan selection
    Given no subscription plan is selected
    When the user clicks the "Buy" button
    Then an error message should be displayed indicating a subscription must be selected
    And the user should remain on the Subscription Management screen
    And the UI should be responsive
    And the error message should be clear and actionable

  Examples:
    | subscription_plan |
    | none              |

@invalid-payment-amount
Scenario Outline: Validate Error Message for Invalid Payment Amount
  When the user selects a valid saved card
  And the user edits the payment amount to "<payment_amount>"
  And the user clicks the "Done" button
  Then an error message should be displayed indicating the payment amount is invalid
  And the user should remain on the Payment Method screen
  And the UI should be responsive

  Examples:
    | payment_amount |
    | abc            |

@payment_method_not_found
Scenario Outline: Validate Error Message for Deleted Payment Method
  When the user selects a payment method that has been deleted or is no longer available
  And the user clicks the "Done" button
  Then the system should process the payment attempt
  And an error message should be displayed indicating the payment method is not found
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

Examples:
  | payment_method |
  | deleted_method |

@payment_timeout_error
Scenario Outline: Validate Payment Method Timeout Error Message
  Given the user selects a valid saved card
  When the system simulates a timeout during payment processing
  And the user clicks the "Done" button
  Then an error message is displayed indicating the payment method timed out
  And the user remains on the Payment Method screen
  And the UI is responsive

  Examples:
    | action      |
    | Simulate    |

@payment-authorization-failure
Scenario Outline: Validate Error Message for Unauthorised Payment Method
  When the user selects a valid saved card
  And the system simulates an authorization failure during payment processing
  And the user clicks the "Done" button
  Then the user should see an error message indicating the payment method is not authorized
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

Examples:
  | <valid_saved_card> |
  | Valid Card 1       |

@payment-decline-error
Scenario Outline: Validate error message on declined payment method
  When the user selects a valid saved card
  And simulates a decline during payment processing
  And clicks the "Done" button
  Then the error message should be displayed indicating the payment method was declined
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    | <none> |

@unsupported_payment_method
Scenario Outline: Validate Unsupported Payment Method Error
  When I select a payment method that is not supported
  And I click the "Done" button
  Then an error message should be displayed indicating the payment method is not supported
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

Examples:
  | Payment Method          |
  | PayPal                  |
  | Bank Transfer           |

@error_message_display
Scenario Outline: Validate Error Message for Unavailable Payment Method
  When the user selects a payment method that is not available
  And the user clicks the "Done" button
  Then the user should observe the system response
  And the error message should indicate the payment method is not available
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

Examples:
   | unavailable_payment_method     |
   | Credit Card not accepted       |

@unconfigured_payment_method
Scenario Outline: Validate Unconfigured Payment Method Error Message
  When the user selects a payment method that is not configured
  And the user clicks the "Done" button
  Then the system should display an error message indicating the payment method is not configured
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

  Examples:
    | payment_method         |
    | Credit Card (Dummy)    |

@error-message-unrecognized-payment
Scenario Outline: Validate that an appropriate error message is displayed if the selected payment method is not recognized
  When the user selects a payment method that is not recognized
  And the user clicks the "Done" button
  Then the system should process the payment attempt
  And an error message is displayed indicating the payment method is not recognized
  And the user remains on the Payment Method screen
  And the UI remains responsive
  And the error message is clear and actionable

  Examples:
    | payment_method         |
    | UnrecognizedMethod123  |

@invalid-payment-method
Scenario Outline: Validate Error Message for Invalid Payment Method
  When the user selects "<payment_method>"
  And the user clicks the "Done" button
  Then an error message should be displayed indicating the payment method is not valid
  And the user should remain on the Payment Method screen
  And the UI should remain responsive
  And the error message should be clear and actionable

  Examples:
    | payment_method       |
    | invalid payment method |

@unsupported_payment
Scenario Outline: Validate Unsupported Payment Method Error
  When the user selects <payment_method> as a payment method that is not supported by the bank
  And the user clicks the "Done" button
  Then an error message is displayed indicating the payment method is not supported by the bank
  And the user remains on the Payment Method screen
  And the UI remains responsive
  And the error message is clear and actionable

Examples:
  | payment_method |
  | Credit Card    |
  | e-Wallet       |

@error_payment_method
Scenario Outline: Validate Error Message for Unavailable Payment Method
  When the user selects a payment method that is not available for the transaction
  And the user clicks the "Done" button
  Then the system processes the payment attempt
  And the user observes the system response
  Then an error message is displayed indicating the payment method is not available for the transaction
  And the user remains on the Payment Method screen
  And the UI remains responsive
  And the error message is clear and actionable

  Examples:
    | payment_method      |
    | Credit Card        |
    | PayPal             |

@error-message-validation
Scenario Outline: Validate Error Message for Unconfigured Payment Method
  When I select a payment method that is not configured for the transaction
  And I click the "Done" button
  Then an error message should be displayed indicating the payment method is not configured for the transaction
  And the user should remain on the Payment Method screen
  And the UI should be responsive
  And the error message should be clear and actionable

Examples:
  | payment_method |
  | unconfigured_payment_method |

@validate_max_saved_cards
Scenario Outline: Validate that the system can handle the maximum number of saved cards
  When I add the maximum number of saved cards allowed
  Then all cards should be displayed correctly
  And I click the "Done" button with one of the cards selected
  And I observe the system response
  Then there should be no performance issues
  And the UI should be responsive
  And no error messages should be shown

Examples:
  | max_saved_cards |
  | 10              |

@validate_minimum_card_details
Scenario Outline: Validate that the system can handle the minimum required card details without errors
  When I enter "<cardnumber>"
  And I enter "<expirationdate>"
  And I enter "<cvv>"
  And I enter "<cardholdername>"
  And I click the "Done" button
  Then the system processes the payment successfully
  And no error messages are displayed
  And the UI remains responsive
  And the payment details are correct

  Examples:
    | cardnumber         | expirationdate | cvv | cardholdername |
    | 4111111111111111   | 12/25          | 123 | John Doe       |

@valid_payment_processing
Scenario Outline: Validate Maximum Payment Amount Processing
  When the user selects a valid saved card
  And the user enters the maximum payment amount allowed "<paymentamount>"
  And the user clicks the "Done" button
  Then the system should process the payment successfully
  And no error messages are displayed
  And the UI remains responsive

  Examples:
    | paymentamount |
    | 999999.99     |

  @minimum_payment_validation
  Scenario Outline: Validate Minimum Payment Amount
    When the user selects a valid saved card
    And the user enters "<minimum_payment_amount>"
    And the user clicks the "Done" button
    Then the system processes the payment successfully
    And no error messages are displayed
    And the UI remains responsive

    Examples:
      | minimum_payment_amount |
      | 10                     |
