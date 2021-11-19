# frozen_string_literal: true

module M2yFast
  class Configuration

    attr_writer :username, :password, :cnpj, :proxy, :env, :wsdl, :savon_client

    def initialize #:nodoc:
      @username = nil
      @password = nil
      @cnpj = nil
      @proxy = nil
      @env = nil
      @wsdl = nil
      @savon_client = nil
    end

    def username
      @username
    end

    def password
      @password
    end

    def cnpj
      @cnpj
    end

    def proxy
      @proxy
    end

    def env
      @env
    end

    def wsdl
      @wsdl
    end

    def savon_client
      @savon_client ||= Savon.client(
        wsdl: M2yFast.configuration.wsdl,
        log: true,
        proxy: M2yFast.configuration.proxy,
        log_level: M2yFast.configuration.production? ? :info : :debug,
        pretty_print_xml: true,
        open_timeout: 30,
        read_timeout: 30
      )
    end

    def production?
      env.to_s.upcase == 'PRD'
    end
  end
end
