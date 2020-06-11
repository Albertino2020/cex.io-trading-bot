require_relative "../lib/cexio"
# docs
module Trade
  # docs
  class API < CEX::API
    def autotrade
      aux = []
      i = 0
      balance.each do |key, value|
        next unless value.is_a?(Hash)

        value.each do |key1, value1|
          if key1.to_s == "available"
            aux[i] = [key, value1]
            i += 1
          end
        end
      end
      2.upto(aux.length - 1) do |index|
        if aux[index][1].to_f.positive? && aux[index][0] != "BTC"
          amount = aux[index][1].to_f
          currency = aux[index][0]
          price = 1
          place_order("buy", amount, price, "#{currency}/BTC")
          puts "Order #{currency} sucessfully placed"
        else
          puts "You dont have enough fund in your account for this operation."
        end
      end
    end

    def demotrade
      balance.each do |key, val|
        next unless val.is_a?(Hash)

        val.each do |key1, _val1|
          if key1.to_s == "available"
            puts "place_order buy  0.5 BTC at 10_000 #{key}"
            puts "place_order sell  1 BTC at 10_500 #{key}"
          end
        end
      end
    end
  end
end
