require 'rails_helper'

describe "Items API" do
  describe 'index functionality' do
    it 'always return an array of data, even if zero resources are found' do
      create_list(:item, 0)

      get '/api/v1/items'
      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
      # require 'pry';binding.pry
      expect(items[:data].count).to eq(0)
      expect(items[:data].class).to eq(Array)

      items[:data].each do |item|
        # require 'pry';binding.pry
        require 'pry';binding.pry if item[:id] == false
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end
    
    it "render a JSON representation of all records of the requested resource" do
      create_list(:item, 4)

      get '/api/v1/items'
      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].count).to eq(4)
      
      items[:data].each do |item|
        # require 'pry';binding.pry
        require 'pry';binding.pry if item[:id] == false
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end
  end

  describe '#show functionality' do
    it 'render a JSON representation of the corresponding record, if found' do
      item = create(:item)
      # require 'pry';binding.pry
      get "/api/v1/items/#{item.id}"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      item = JSON.parse(response.body, symbolize_names: true)
      # require 'pry';binding.pry
      require 'pry';binding.pry if item[:id] == false
      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_an(String)
      
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  describe '#create functionality' do
    it 'create a record and render a JSON representation of the new Item record' do
    merchant = create(:merchant)
    # item = create(:item, merchant_id: merchant.id)

    item_params = ({
                  "name": "value1",
                  "description": "value2",
                  "unit_price": 100.99,
                  "merchant_id": merchant.id
                })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers,  params: JSON.generate(item: item_params)
    created_item = Item.last
    # require 'pry';binding.pry
    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  
    expect(created_item.unit_price).to be_a(Float)
    expect(created_item.merchant_id).to be_a(Integer)
    end
  end

  describe 'sad path' do
    it 'return an error if any attribute is missing' do
      merchant = create(:merchant).id
      incorrect_item_params = ({
                    "name": "value1",
                    "description": "blue",
                    "unit_price": "",
                    "merchant_id": merchant
                  })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: incorrect_item_params)
      # require 'pry';binding.pry
      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      expect(Item.last).to_not eq(incorrect_item_params)
    end
  end

  describe '#update functionality' do
    it 'update the corresponding Item (if found) with whichever details are provided by the user' do
      merchant = create(:merchant)
      item = create(:item, unit_price: 49.01, merchant_id: merchant.id)
      
      item_params = ({
                    "name": "value1",
                    "description": "value2",
                    "unit_price": 100.99,
                    "merchant_id": merchant.id
    
                  })
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params, symbolize_names: true)
      
      updated_item = Item.find_by(id: item.id)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(updated_item.unit_price).to eq(100.99)
    end

    it 'DOES NOT update Item if params has incorrect datatypes' do
      merchant = create(:merchant)
      item = create(:item, unit_price: 49.01, merchant_id: merchant.id)
      
      bad_item_params = ({
                    "id": item.id,
                    "name": "value1",
                    "description": 5849,
                    "unit_price": 100.99,
                    "merchant_id": "merchant.id"
    
                  })
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: bad_item_params, symbolize_names: true)
      
      item_post_attempt = Item.find_by(id: item.id)
      # require 'pry';binding.pry
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(item).to eq(item_post_attempt)
      expect(item_post_attempt.description).to_not eq(bad_item_params[:description])
    end

    it 'DOES NOT update Item if params has missing information' do
      merchant = create(:merchant)
      item = create(:item, unit_price: 49.01, merchant_id: merchant.id)
      
      bad_item_params = ({
                    "id": item.id,
                    "name": "value1",
                    "description": "value2",
                    "unit_price": "",
                    "merchant_id": merchant.id
    
                  })
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: bad_item_params, symbolize_names: true)
      
      item_post_attempt = Item.find_by(id: item.id)
      # require 'pry';binding.pry
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(item).to eq(item_post_attempt)
      expect(item_post_attempt.unit_price).to_not eq(bad_item_params[:unit_price])
    end
  end

  describe '#destroy functionality' do
    it 'destroy the corresponding record (if found) and any associated data' do
      item = create(:item)
      expect(item).to be_a(Item)

      delete "/api/v1/items/#{item.id}"
      # require 'pry';binding.pry
      expect(response).to be_successful
      expect(response.status).to eq(204)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
    
    # it 'destroy any invoice if this was the only item on an invoice' do


    # end
  end

end