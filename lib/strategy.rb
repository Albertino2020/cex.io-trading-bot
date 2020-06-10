require_relative "../lib/cexio"
# docs
module Trade
  # docs
  class API < CEX::API
    def autotrade
      hash = self.balance
      hash.each do |key, value|
        print "#{key} : "
        value.each { |key1, value1| print "#{key1} : #{value1} " } if value.is_a?(Hash)
        puts ""
      end
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
      2.upto(aux.length - 1) do |i|
        if aux[i][1].to_f > 0 && aux[i][0] != "BTC"
          amount = aux[i][1].to_f
          currency = aux[i][0]
          price = 1
          place_order("buy", amount, price, "#{currency}/BTC")
          puts "Order #{currency} sucessfully placed"
        else
          puts "You don«t have enough fund in your account."
        end
      end
    end

    def demotrade
      balance.each do |key, val|
        next unless val.is_a?(Hash)
        val.each do |key1, val1|
          if key1.to_s == "available"
            puts "place_order buy  0.5 BTC at 10_000 #{key}"
            puts "place_order sell  1 BTC at 10_500 #{key}"
          end
        end
      end
    end
  end
end
