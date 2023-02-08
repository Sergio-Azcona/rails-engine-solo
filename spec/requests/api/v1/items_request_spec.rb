require 'rails_helper'

describe "Items API" do
  it "sends a index/list" do
    create_list(:item, 4)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(4)
    
    items[:data].each do |item|
      # require 'pry';binding.pry
      require 'pry';binding.pry if item[:id] == false
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)
      
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end


end