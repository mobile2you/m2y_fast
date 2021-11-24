# frozen_string_literal: true

module M2yFast
  class Configuration

    attr_writer :username, :password, :cnpj, :proxy, :env, :wsdl, :savon_client,
                :eximia_wsdl, :eximia_username, :eximia_password, :eximia_client

    def initialize #:nodoc:
      @username = nil
      @password = nil
      @cnpj = nil
      @proxy = nil
      @env = nil
      @wsdl = nil
      @savon_client = nil
      # Eximia configuration
      @eximia_wsdl = nil
      @eximia_username = nil
      @eximia_password = nil
      @eximia_client = nil
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
        wsdl: wsdl,
        log: true,
        proxy: proxy,
        log_level: production? ? :info : :debug,
        pretty_print_xml: true,
        open_timeout: 30,
        read_timeout: 30
      )
    end

    # Eximia configuration

    def eximia_wsdl
      @eximia_wsdl
    end

    def eximia_username
      @eximia_username
    end

    def eximia_password
      @eximia_password
    end

    def eximia_client
      @eximia_client ||= Savon.client(
        wsdl: eximia_wsdl,
        log: true,
        proxy: proxy,
        log_level: production? ? :info : :debug,
        pretty_print_xml: true,
        open_timeout: 30,
        read_timeout: 30,
        headers: eximia_authentication_headers
      )
    end

    def eximia_authentication_headers
      {
        username: eximia_username,
        password: eximia_password
      }
    end

    def production?
      env.to_s.upcase == 'PRD'
    end
  end
end
