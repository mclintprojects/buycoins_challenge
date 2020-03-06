require "net/http"

class Coindesk
  class << self
    def bitcoin_price(currency)
      currency = currency.to_s.upcase # converts from symbol to currency format required by Coindesk
      response = Net::HTTP.get(URI.parse("https://api.coindesk.com/v1/bpi/currentprice/#{currency}.json"))
      JSON.parse(response)["bpi"][currency]["rate_float"]
    end
  end
end