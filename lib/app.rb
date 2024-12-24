require "sinatra"
require "json"

require_relative "recurring"
require_relative "./recurring/event"
require_relative "./recurring/schedule"
require_relative "./recurring/schedule_elem"

before do
  content_type :json
end

get "/evt" do
end

# 반복 이벤트를 추가한다
post "/evt" do
  req = JSON.parse request.body.read
  req_hash = {
    :desc => req['desc'],
    :recur_type => req['recur_type'],
    :day_idx => req['recur_params']['day_idx'],
    :cnt => req['recur_params']['cnt']
  }
  rec = Recurring.new
  scd = Recurring::Schedule.new
  scd.add_elem Recurring::ScheduleElem.new('', req_hash[:desc])
  rec.add_schedule scd

  p rec
end
