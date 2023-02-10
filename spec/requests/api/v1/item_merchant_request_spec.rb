require 'rails_helper'

describe "ItemMerchant API" do
  it 'returns all merchant info' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get("/api/v1/items/#{item.id}/merchant")
  
    expect(response).to be_successful
    expect(response.status).to eq(200)

    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:type]).to eq(merchant.class.to_s.downcase)
    expect(item[:data][:id].to_i).to eq(merchant.id)
    expect(item[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'returns an error status and message when item does not exist' do
    invalid_item_id = 1579
    merchant = create(:merchant)

    get("/api/v1/items/#{invalid_item_id}/merchant")
    # require 'pry';binding.pry
    error_response = JSON.parse(response.body, symbolize_names: true)
    # require 'pry';binding.pry
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    expect(error_response[:errors][0][:error_message]).to eq("Couldn't find Item with 'id'=#{invalid_item_id}")
    expect(error_response[:errors][0][:status]).to eq("404")
  end 


end