require 'rails_helper'

describe "Merchants API" do

  describe 'index' do
    it 'always return an array of data, even if zero resources are found' do
      create_list(:merchant, 0)

      get '/api/v1/merchants'
      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].count).to eq(0)
      expect( merchants[:data].class).to eq(Array)

      merchants[:data].each do |merchant|
        require 'pry';binding.pry if merchant[:id] == false
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(Integer)
        
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it "render a JSON representation of all records of the requested resource" do
      create_list(:merchant, 25)

      get '/api/v1/merchants'
      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].count).to eq(25)

      merchants[:data].each do |merchant|
        require 'pry';binding.pry if merchant[:id] == false
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
  end

  it 'render a JSON representation of the corresponding record, if found' do
    merchant = create_list(:merchant,1).first

    get "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful
    expect(response.status).to eq(200)

    merchant = JSON.parse(response.body, symbolize_names: true)
      # require 'pry';binding.pry
    require 'pry';binding.pry if merchant[:id] == false
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_an(String)
    
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end



end