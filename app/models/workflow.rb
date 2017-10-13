class Workflow < ActiveRecord::Base
  has_many :steps
  has_many :answers

  before_create do
    self.token ||= SecureRandom::hex(8)
  end

  def match(data)
    matched_step = steps.find { |step| step.match?(data) }
    return matched_step if matched_step
    raise UnmatchableDataError
  end

  class UnmatchableDataError < StandardError; end
end

