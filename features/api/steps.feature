Feature: Steps API

  Background:
    Given I am Ragnar Lothbrok
    And I send and accept JSON

  Scenario: Create inline step with multiple answers
    When I send a POST request to "/api/steps/" with the following:
    """
    {
      "facts": {}
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "text": "My first name is {{user_first_name}}, and my last name is {{user_last_name}}.",
      "answers": {
        "user_first_name": {
          "input_type": "short_text"
        },
        "user_last_name": {
          "input_type": "short_text"
        }
      },
      "parts": [
        { "type": "text", "content": "My first name is " },
        { "type": "answer", "answer": { "name": "user_first_name", "input_type": "short_text" } },
        { "type": "text", "content": ", and my last name is " },
        { "type": "answer", "answer": { "name": "user_last_name", "input_type": "short_text" } },
        { "type": "text", "content": "." }
      ]
    }
    """

  Scenario: Create inline step with a single inline option answer
    When I send a POST request to "/api/steps/" with the following:
    """
    {
      "facts": {
        "user_first_name": "Giles",
        "user_last_name": "Rotherbrok"
      }
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "text": "Generally I prefer {{user_style_preference}} wines.",
      "answers": {
        "user_style_preference": {
          "input_type": "select",
          "options": {
            "red": "red",
            "white": "white"
          }
        }
      },
      "parts": [
        { "type": "text", "content": "Generally I prefer " },
        {
          "type": "answer",
          "answer": {
            "name": "user_style_preference",
            "input_type": "select",
            "options": {
              "red": "red",
              "white": "white"
            }
          }
        },
        { "type": "text", "content": " wines." }
      ]
    }
    """

  Scenario: Create inline step with a single option answer
    When I send a POST request to "/api/steps/" with the following:
    """
    {
      "facts": {
        "user_first_name": "Giles",
        "user_last_name": "Rotherbrok",
        "user_style_preference": "white"
      }
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
    "text": "Would you like any white wine recommendations?\n{{user_desires_recommendations}}",
      "answers": {
        "user_desires_recommendations": {
          "input_type": "select",
          "options": {
            "yes": "Yes",
            "no": "No"
          }
        }
      },
      "parts": [
        { "type": "text", "content": "Would you like any white wine recommendations?\n" },
        {
          "type": "answer",
          "answer": {
            "name": "user_desires_recommendations",
            "input_type": "select",
            "options": {
              "yes": "Yes",
              "no": "No"
            }
          }
        }
      ]

    }
    """

  Scenario: Create step with no answers
    When I send a POST request to "/api/steps/" with the following:
    """
    {
      "facts": {
        "user_first_name": "Giles",
        "user_last_name": "Rotherbrok",
        "user_style_preference": "white",
        "user_desires_recommendations": "yes"
      }
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "text": "I recommend the Russian River Chardonnay.",
      "parts": [
        { "type": "text", "content": "I recommend the Russian River Chardonnay." }
      ]
    }
    """
