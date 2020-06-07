# frozen_string_literal: true

require "cexio/version"
require "openssl"
require "net/http"
require "net/https"
require "uri"
require "json"
require "addressable/uri"

# docs
module CEX
  class API
    attr_accessor :api_key, :api_secret, :username, :nonce_v

    def initialize(username, api_key, api_secret)
      self.username = username
      self.api_key = api_key
      self.api_secret = api_secret
    end


  end
end
