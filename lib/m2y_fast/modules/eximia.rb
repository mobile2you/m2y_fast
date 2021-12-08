# frozen_string_literal: true
module M2yFast
  class Eximia < Base
    # find_conta_dta_venc
    def self.get_pdf_id(fast_account, due_date)
      xml = EximiaXmlBuilder.get_pdf_id_body(fast_account, due_date)
      response = M2yFast.configuration.eximia_client.call(:find_conta_dta_venc, xml: xml)
      full_response(EximiaXmlResponseParser.get_pdf_id_response(response.body), xml, response.body, :find_conta_dta_venc)
    rescue StandardError => error
      eximia_error(xml, error, :find_conta_dta_venc)
    end

    # find_pdf
    def self.get_pdf(id)
      xml = EximiaXmlBuilder.get_pdf_body(id)
      response = M2yFast.configuration.eximia_client.call(:find_pdf, xml: xml)
      full_response(EximiaXmlResponseParser.get_pdf_response(response.body), xml, response.body, :find_pdf)
    rescue StandardError => error
      eximia_error(xml, error, :find_pdf)
    end

    def self.eximia_error(request, error, endpoint)
      error_message = { error: true, message: error.message, code: error&.http&.code }
      full_response(error_message, request, nil, endpoint)
    end
  end
end
