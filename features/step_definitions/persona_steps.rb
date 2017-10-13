Given(/^I am (.*)$/) do |name|
  Cucumber::Persona.find(name).create
end
