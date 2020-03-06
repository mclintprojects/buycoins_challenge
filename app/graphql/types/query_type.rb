module Types
  class QueryType < Types::BaseObject
    field :calculate_price, resolver: Resolvers::PriceCalculator
  end
end
