# frozen_string_literal: true
module M2yFast
  class EximiaXmlResponseParser

    # findContaDtaVenc
    def self.get_pdf_id_response(json)
      if json[:find_conta_dta_venc_response][:return].present?
        json[:find_conta_dta_venc_response][:return].deep_symbolize_keys!.merge!({ error: false })
      else
        { error: false }
      end
    rescue
      { error: true }
    end

    # findPDF
    def self.get_pdf_response(json)
      {
        pdf: json[:find_pdf_response][:return],
        error: false
      }
    rescue
      { error: true }
    end
  end
end
