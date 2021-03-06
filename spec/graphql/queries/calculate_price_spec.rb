require "rails_helper"

RSpec.describe GraphqlController, type: :controller do
  describe "calculatePrice query" do
    before do
      allow(Coindesk).to receive(:bitcoin_price).with(:usd).and_return(9000)
    end

    it "should correctly calculate buy price" do
      post :execute, params: {query: query("BUY", 0.2, 360)}
      response_json = JSON.parse(response.body)
      expect(response_json["data"]["calculatePrice"]).to eq(3246480.0)
    end

    it "should correctly calculate sell price" do
      post :execute, params: {query: query("SELL", 0.2, 360)}
      response_json = JSON.parse(response.body)
      expect(response_json["data"]["calculatePrice"]).to eq(3233520.0)
    end
  end

  def query(type, margin, exchange_rate)
    <<~GQL
      query{
        calculatePrice(type: #{type}, margin: #{margin}, exchangeRate: #{exchange_rate})
      }
    GQL
  end
end