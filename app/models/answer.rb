class Answer < ActiveRecord::Base
  has_and_belongs_to_many :options

  accepts_nested_attributes_for :options

  def to_h
    @hsh ||= begin
      hsh = {
        input_type: input_type
      }
      hsh.merge!(options: Options.new(options).to_h) if options.any?
      hsh
    end
  end

  class Options
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def to_a
      options.map { |o| [o.name, o.value] }
    end

    def to_h
      Hash[*to_a.flatten]
    end
  end
end
