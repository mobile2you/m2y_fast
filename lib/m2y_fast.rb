require 'm2y_fast/configuration/configuration'
require 'm2y_fast/constants/constants'
require 'm2y_fast/modules/card'
require 'm2y_fast/modules/cardholder'
require 'm2y_fast/xml/xml_builder'
require 'm2y_fast/xml/xml_response_parser'

module M2yFast

  # Gives access to the current Configuration.
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    config = configuration
    yield(config)
  end

  def self.with_configuration(config)
    original_config = {}

    config.each do |key, value|
      original_config[key] = configuration.send(key)
      configuration.send("#{key}=", value)
    end

    yield if block_given?
  ensure
    original_config.each { |key, value| configuration.send("#{key}=", value) }
  end

end
