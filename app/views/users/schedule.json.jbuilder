json.array!(@shifts) do |event|
  json.extract! event, :id, :external_location_name
  json.title 'Location: '+ event.external_location_name
  json.manager event.manager.fullname
  json.description 'asdasdasdasdasd'
  json.start event.start_time
  json.end event.end_time
  json.url shift_url(event)
end