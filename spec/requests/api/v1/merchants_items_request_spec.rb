require 'rails_helper'

describe "MerchantItems API" do
  it 'returns all items and their info' do
    merchant = create(:merchant)
    merchant_items = create_list(:item, 7, merchant: merchant)
    
    get("/api/v1/merchants/#{merchant.id}/items")
    # require 'pry';binding.pry
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data]).to be_a(Array)
    expect(items[:data].count).to eq(7)
    expect(items[:data][0][:attributes][:merchant_id]).to eq(merchant_items.first.merchant_id)
  end

  it 'returns an error status and message when merchant does not exist' do
    invalid_merchant_id = 15854714
    items = create_list(:item, 7)

    get("/api/v1/merchants/#{invalid_merchant_id}/items")
    # require 'pry';binding.pry
    error_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    # require 'pry';binding.pry
    expect(error_response[:errors][0][:error_message]).to eq("Couldn't find Merchant with 'id'=#{invalid_merchant_id}")
    expect(error_response[:errors][0][:status]).to eq("404")
  end  
end