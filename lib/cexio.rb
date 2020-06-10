# require 'cexio/version'
require "openssl"
require "net/http"
require "net/https"
require "uri"
require "json"
require "addressable/uri"

# docs
module CEX
  # docs
  class API
    attr_reader :api_key, :api_secret, :username, :nonce_v
    attr_writer :api_key, :api_secret, :username, :nonce_v
    OPS = %w[balance autotrade get_myfee order_book current_orders cancel_order place_order convert].freeze

    def initialize(username, api_key, api_secret)
      self.username = username
      self.api_key = api_key
      self.api_secret = api_secret
    end

    def ops(option)
      send(OPS[option])
    end

    def api_call(method, param = {}, priv = false, action = "", is_json = true)
      url = "https://cex.io/api/#{method}/#{action}"
      if priv
        nonce
        param.merge!(key: api_key, signature: signature.to_s, nonce: nonce_v)
      end
      answer = post(url, param)
      if is_json
        JSON.parse(answer)
      else
        answer
      end
    end

    def ticker(couple = "GHS/BTC")
      api_call("ticker", {}, false, couple)
    end

    def convert(couple = "GHS/BTC", amount = 1)
      api_call("convert", { amnt: amount }, false, couple)
    end

    def order_book(couple = "GHS/BTC")
      api_call("order_book", {}, false, couple)
    end

    def trade_history(since = 1, couple = "GHS/BTC")
      api_call("trade_history", { since: since.to_s }, false, couple)
    end

    def balance
      api_call("balance", {}, true)
    end

    def open_orders(couple = "GHS/BTC")
      api_call("open_orders", {}, true, couple)
    end

    def cancel_order(order_id)
      api_call("cancel_order", { id: order_id.to_s }, true, "", false)
    end

    def place_order(ptype = "buy", amount = 1, price = 1, couple = "GHS/BTC")
      api_call("place_order", { type: ptype, amount: amount.to_s, price: price.to_s }, true, couple)
    end

    def archived_orders(couple = "GHS/BTC", options = {})
      api_call("archived_orders", options, true, couple)
    end

    def get_order(order_id)
      api_call("get_order", { id: order_id.to_s }, true, "", true)
    end

    def get_order_tx(order_id)
      api_call("get_order_tx", { id: order_id.to_s }, true, "", true)
    end

    def get_address(currency)
      api_call("get_address", { currency: currency }, true, "", true)
    end

    # rubocop: disable Naming/AccessorMethodName
    def get_myfee
      api_call("get_myfee", {}, true, "", true)
    end

    # rubocop: enable Naming/AccessorMethodName

    def hashrate
      api_call("ghash.io", {}, true, "hashrate")
    end

    def workers_hashrate
      api_call("ghash.io", {}, true, "workers")
    end

    def nonce
      self.nonce_v = (Time.now.to_f * 1_000_000).to_i.to_s
    end

    def signature
      str = nonce_v + username + api_key
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), api_secret, str)
    end

    def post(url, param)
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      params = Addressable::URI.new
      params.query_values = param
      https.post(uri.path, params.query).body
    end
  end
end
