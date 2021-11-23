# frozen_string_literal: true
module M2yFast
  class Eximia < Base
    def self.get_pdf_id(fast_account, due_date)
      xml = EximiaXmlBuilder.get_pdf_id_body(fast_account, due_date)
      response = M2yFast.configuration.eximia_client.call(:find_conta_dta_venc, xml: xml)
      full_response(EximiaXmlResponseParser.get_pdf_id_response(response.body), xml, response.body)
    end
  end
end
