class ItemSerializer
  def self.index_serialize(items)
    {
      "data": items.map do |item|
            {
              "id": item.id.to_s,
              "type": item.class.to_s.downcase,
              "attributes": {
                            "name": item.name,
                            "description": item.description,
                            "unit_price": item.unit_price,
              # },
              # "relationships": {
              #               "type": item.merchant.class.to_s.downcase,
                            "merchant_id": item.merchant_id
              }
            }
        end
    }
  end

  def self.show_serialize(item)
    {
      "data": 
            {
              "id": item.id.to_s,
              "type": item.class.to_s.downcase,
              "attributes": {
                            "name": item.name,
                            "description": item.description,
                            "unit_price": item.unit_price,
                # },
              # "relationships": {
              #               "type": item.merchant.class.to_s.downcase,
              "merchant_id": item.merchant_id
              }
            }
    }
  end
end