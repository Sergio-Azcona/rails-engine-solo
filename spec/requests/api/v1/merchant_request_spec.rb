require 'rails_helper'

describe "Merchants API" do

  it "sends a index/list of Merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchant'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(5)

    merchants[:data].each do |merchant|
      # require 'pry';binding.pry
      require 'pry';binding.pry if merchant[:id] == false
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)
      
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end


end