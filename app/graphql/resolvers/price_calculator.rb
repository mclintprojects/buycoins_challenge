module Resolvers
  class PriceCalculator < GraphQL::Schema::Resolver
    type GraphQL::Types::Float, null: false

    argument :type, String, required: true
    argument :margin, GraphQL::Types::Float, required: true
    argument :exchange_rate, GraphQL::Types::Float, required: true

    def resolve(type:, margin:, exchange_rate:)
      bitcoin_price = Coindesk.bitcoin_price :usd
      
      case type
      when "buy"
      when "sell"
      end
    end

    private

    def margin_value
      puts context.arguments
    end
  end
end