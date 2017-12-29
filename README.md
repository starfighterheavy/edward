# Edward

[![Code Climate](https://codeclimate.com/github/starfighterheavy/edward/badges/gpa.svg)](https://codeclimate.com/github/starfighterheavy/edward)
[![Dependency Status](https://gemnasium.com/starfighterheavy/edward.svg)](https://gemnasium.com/starfighterheavy/edward)

Edward is an experimental Ruby-on-Rails application intended to drive conversation based user interfaces. It is currently under development and actively used, but could removed or modified at any time. Use at your own risk.

## Installation

To setup an Edward server on your local machine, run the following:

```
git clone git@github.com:starfighterheavy/edward.git
...
cd edward
bundle install
...
rake db:create db:schema:load db:seed
...
rails s
```

Or you can deploy directly to Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/starfighterheavy/edward)

## Useage

Edward has a very simple user facing API - you make a POST call to `/api/workflows/[YOUR_WORKFLOW]/prompt`, with a request body that looks like:

```
"facts": {
  "first_name": "Han",
  "last_name": "Solo",
  "desires": "money"
}
```

Edward will search your Workflow for a Step with conditions that match the facts you've supplied, and execute that step and returns a JSON object with the result. To continue the example above, lets say your workflow had a step with a condition of `first_name!=&desires=money`. That condition reads: `first_name` must not equal blank, and `desires` must equal "money". This matches the facts we provided, so that step will execute and return the following:

```
{
  "text": "Money, {{@first_name}}? How much? {{?how_much}}",
  "cta": "Next",
  "parts": [
    { "type": "text",  "content": "Money" },
    { "type": "text", "content": "Han" },
    { "type": "punctuation", "content": "?" },
    { "type": "text", "content": "How" },
    { "type": "text", "content": "much" },
    { "type": "punctuation", "content": "?" },
    { "type": "short_text", "name": "how_much" }
  ]
}
```

So what does that all mean? Lets break down the response bit by bit.

##### text

The `text` is the heart of the Step, and determines the structure of the response and is broken down into individual parts - which are returned in the `parts` field.

##### parts

The `parts` field is an array that contains each individual part of the Step's `text`. Edward has no opinion about how it's Steps are rendered for the user - that is up to the consumer of the API to determine - but in order to help standardize what the intent of each Step is, it is broken down into parts that can be rendered differently depending on the context. Each part can be of type "text", "punctuation", "newline", "short_text", "select", "hidden", "link", or "choice".

##### cta

The `cta` field contains the text that should be used in the "Call-to-action", which is typically a button that the user presses to continue to the next step.

#### Okay, so what do I do with this?

How you render what Edward returns is up to you and depends on the use case. See [Edward's Voice](https://github.com/starfighterheavy/edwards-voice) for an example implementation of an Edward client built in VueJS.

To see everything that Edward can do, refer to the workflow feature tests that outline the various kinds of applications Edward can be suited to: [Feature tests](https://github.com/starfighterheavy/edward/tree/master/features/api/workflows)

## Examples

### BridgeCare Finance

Edward is used to drive a simple calculator on the [BridgeCare Finance Homepage](https://www.bridgecarefinance.com). Using Edward has allowed BridgeCare to iterate quickly through different calculator designs without building or modifying any UI code.

## Interested?

If you'd like to contribute ideas or code to Edward, please reach out to [jskirst](https://github.com/jskirst).
