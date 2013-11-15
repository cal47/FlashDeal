json.array!(@deals) do |deal|
  json.extract! deal, :deal, :description, :start_time, :end_time
  json.url deal_url(deal, format: :json)
end
