require "sinatra"
require "json"

require_relative "recurring"
require_relative "./recurring/event"
require_relative "./recurring/schedule"
require_relative "./recurring/schedule_elem"
require_relative "./recurring/tmpr_expr/temporal_expr"
require_relative "./recurring/tmpr_expr/day_in_month"

enable :sessions

before do
  content_type :json
end

# 반복 이벤트를 추가한다
post "/evts" do
  req = JSON.parse request.body.read
  req_hash = {
    :desc => req['desc'],
    :recur_type => req['recur_type'],
    :day_idx => req['recur_params']['day_idx'],
    :cnt => req['recur_params']['cnt']
  }
  scd = Recur::Schedule.new

  tmpr_expr = nil
  case req_hash[:recur_type]
  when "DayInMonth"
    day_idx = req_hash[:day_idx].to_i
    cnt = req_hash[:cnt].to_i
    tmpr_expr = Recur::DayInMonth.new(day_idx, cnt)
  end

  scd.add_elem Recur::ScheduleElem.new(
    Recur::Event.new("", req_hash[:desc]),
    tmpr_expr
  )
  rec = session[:rec] || Recurring.new
  rec.add_schedule scd
  session[:rec] = Marshal.dump(rec)
end

end
