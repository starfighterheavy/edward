Given(/^I am Ragnar Lothbrok$/) do
  Step.create!(text: "My first name is [:user_first_name], and my last name is [:user_last_name].",
               conditions: URI.escape("user_first_name=&user_last_name="))
  Answer.create!(name: "user_first_name", input_type: "short_text")
  Answer.create!(name: "user_last_name", input_type: "short_text")

  Step.create!(text: "Generally I prefer [:user_style_preference] wines.",
               conditions: URI.escape("user_style_preference="))
  Answer.create!(name: "user_style_preference",
                 input_type: "select",
                 options_attributes: [
                   { name: "red", value: "red" },
                   { name: "white", value: "white" }
                 ])

  Step.create!(text: "Would you like any white wine recommendations?\n[:user_desires_recommendations]",
               conditions: URI.escape("user_desires_recommendations="))
  Answer.create!(name: "user_desires_recommendations",
                 input_type: "select",
                 options_attributes: [
                   { name: "yes", value: "Yes" },
                   { name: "no", value: "No" }
                 ])

  Step.create!("text": "I recommend the Russian River Chardonnay.",
                conditions: URI.escape("user_style_preference=white&user_desires_recommendations=yes"))
end
