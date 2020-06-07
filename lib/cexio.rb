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
    attr_reader :api_key, :api_secret, :username, :nonce_v
    attr_writer :api_key, :api_secret, :username, :nonce_v

    def initialize(username, api_key, api_secret)
      self.username = username
      self.api_key = api_key
      self.api_secret = api_secret
    end

    def api_call(method, param = {}, priv = false, action = "", is_json = true)
      url = "https://cex.io/api/#{method}/#{action}"
      if priv
        self.nonce
        param.merge!(:key => self.api_key, :signature => self.signature.to_s, :nonce => self.nonce_v)
      end
      answer = self.post(url, param)

      # unfortunately, the API does not always respond with JSON, so we must only
      # parse as JSON if is_json is true.
      if is_json
        JSON.parse(answer)
      else
        answer
      end
    end

    def ticker(couple = "GHS/BTC")
      self.api_call("ticker", {}, false, couple)
    end

    def convert(couple = "GHS/BTC", amount = 1)
      self.api_call("convert", { :amnt => amount }, false, couple)
    end

    def order_book(couple = "GHS/BTC")
      self.api_call("order_book", {}, false, couple)
    end

    def trade_history(since = 1, couple = "GHS/BTC")
      self.api_call("trade_history", { :since => since.to_s }, false, couple)
    end

    def balance
      self.api_call("balance", {}, true)
    end
  end
end
