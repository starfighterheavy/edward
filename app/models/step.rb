class Step < ActiveRecord::Base
  def self.match(data)
    all.find { |step| step.match?(data) }
  end

  def match?(data)
    URI.unescape(conditions)
       .split("&")
       .map { |c| c.split("=") }
       .all? { |key,value| data[key] == value }
  end

  def to_h
    @hsh ||= begin
      hsh = { text: text }
      answers = Answers.new(text).to_h
      hsh[:answers] = answers unless answers.empty?
      hsh
    end
  end

  class Answers
    attr_reader :items

    def initialize(text)
      @items = text.scan(/\[:([a-z_]+)\]/)
                   .flatten
                   .map { |name| Answer.find_by(name: name) }
    end

    def to_a
      @items.map { |a| [a.name, a.to_h] }
    end

    def to_h
      @hsh ||= Hash[*to_a.flatten]
    end
  end
end
