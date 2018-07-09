json.array!(@shifts) do |event|
  json.title 'Location: '+ event.external_location_name if event.shift_status!="unavailable"
  json.title 'Unavailable' if event.shift_status=="unavailable"
  json.accepted ShiftUser.where(shift_id: event.id, user_id: @user.id).first.accepted if event.shift_status!="unavailable"
  json.manager event.manager.fullname if event.shift_status!="unavailable"
  json.description 'asdasdasdasdasd'
  json.start event.start_time
  json.end event.end_time
  json.url shift_url(event) if event.shift_status!="unavailable"
  json.url unavailability_show_path(event) if event.shift_status=="unavailable"
  json.color "red" if event.shift_status=="unavailable"
end