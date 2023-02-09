require 'rails_helper'

describe "ItemMerchants API" do
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
end