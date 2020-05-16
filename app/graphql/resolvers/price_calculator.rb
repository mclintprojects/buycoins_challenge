module Resolvers
  class PriceCalculator < GraphQL::Schema::Resolver
    class Action < Types::BaseEnum
      value "BUY"
      value "SELL"
    end

    type Float, null: false

    argument :type, Action, required: true
    argument :margin, Float, required: true
    argument :exchange_rate, Float, required: true

    def resolve(type:, margin:, exchange_rate:)
      @margin = margin / 100
      @exchange_rate = exchange_rate
      @bitcoin_price = Coindesk.bitcoin_price :usd
      
      case type
      when "BUY"
        calculate_buy_price
      when "SELL"
        calculate_sell_price
      end
    end

    private

    def calculate_buy_price
      buy_price = @bitcoin_price + margin_value
      convert_to_naira buy_price
    end

    def calculate_sell_price
      sell_price = @bitcoin_price - margin_value
      convert_to_naira sell_price
    end

    def margin_value
      @margin * @bitcoin_price
    end

    def convert_to_naira(amount)
      amount * @exchange_rate
    end
  end
end