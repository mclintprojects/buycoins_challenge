module Resolvers
  class PriceCalculator < GraphQL::Schema::Resolver
    type GraphQL::Types::Float, null: false

    argument :type, String, required: true
    argument :margin, GraphQL::Types::Float, required: true
    argument :exchange_rate, GraphQL::Types::Float, required: true

    def resolve(type:, margin:, exchange_rate:)
      @margin = margin
      @exchange_rate = exchange_rate
      @bitcoin_price = Coindesk.bitcoin_price :usd
      
      case type
      when "buy"
        calculate_buy_price
      when "sell"
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