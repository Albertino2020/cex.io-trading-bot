require_relative "../lib/cexio"

def autotrade
  aux = []
  i = 0
  self.balance.each do |key, value|
    if value.is_a?(Hash)
      value.each do |key1, value1|
        if key1.to_s == "available"
          aux[i] = [key, value1]
          i += 1
        end
      end
    end
  end
  0.upto(aux.length) do |i|
    if aux[i][1] > 0 && aux[i][0] != "BTC"
      amount = aux[i][1]
      currency = aux[i][0]
      price = 1
      self.place_order("buy", amount, price, "#{currency}/BTC")
    else
      puts "You don«t have enough fund in your account."
    end
  end
end


