require 'm2y_fast/configuration/configuration'
require 'm2y_fast/constants/constants'
require 'm2y_fast/modules/base'
require 'm2y_fast/modules/card'
require 'm2y_fast/modules/cardholder'
require 'm2y_fast/modules/eximia'
require 'm2y_fast/modules/statement'
require 'm2y_fast/modules/limit'
require 'm2y_fast/modules/virtual_card'
require 'm2y_fast/xml/xml_builder'
require 'm2y_fast/xml/xml_response_parser'
require 'm2y_fast/xml/cardholder/cardholder_xml_builder'
require 'm2y_fast/xml/cardholder/cardholder_xml_response_parser'
require 'm2y_fast/xml/virtual_card/virtual_card_xml_builder'
require 'm2y_fast/xml/virtual_card/virtual_card_xml_response_parser'
require 'm2y_fast/xml/eximia/eximia_xml_builder'
require 'm2y_fast/xml/eximia/eximia_xml_response_parser'
require 'm2y_fast/xml/statement/statement_xml_builder'
require 'm2y_fast/xml/statement/statement_xml_response_parser'
require 'm2y_fast/xml/limit/limit_xml_builder'
require 'm2y_fast/xml/limit/limit_xml_response_parser'

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
