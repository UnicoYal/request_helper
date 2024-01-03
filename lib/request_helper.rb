# frozen_string_literal: true

require_relative 'request_helper/version'
require 'uri'
require 'net/http'

module RequestHelper
  def send_request(url, params, method)
    uri = URI(url)

    response = case method
               when :post
                 Net::HTTP.post_form(uri, params)
               when :get
                 uri.query = URI.encode_www_form(params)
                 Net::HTTP.get_response(uri)
               else
                 raise 'RequestHelper can send only post/get requests'
               end

    { code: response.code, body: response.body }
  end
end
