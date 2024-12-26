require "sinatra"
require "json"
require "date"

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
  req = JSON.parse(request.body.read, symbolize_names: true)

  tmpr_expr = nil
  case req[:recur_type]
  when "DayInMonth"
    day_idx = req[:recur_params][:day_idx].to_i
    cnt = req[:recur_params][:cnt].to_i
    tmpr_expr = Recur::DayInMonth.new(day_idx, cnt)
  end

  scd = Recur::Schedule.new
  scd.add_elem Recur::ScheduleElem.new(
    Recur::Event.new("", req[:desc]),
    tmpr_expr
  )

  recur = session[:recur] || Recurring.new
  recur.add_schedule scd
  session[:recur] = Marshal.dump(recur)
end

get "/evts" do
  req_hash = {
    :evt_arg => Recur::Event.new('', params[:evt_arg]),
    :date => Date.new(*params[:date].split("-").map(&:to_i))
  }

  rec_in_session = Marshal.load(session[:recur])
  rec_in_session.schedules.each do |scd|
    if scd.is_occurring req_hash[:evt_arg], req_hash[:date]
      return {
        :desc => "#{req_hash[:evt_arg]} occurs on #{req_hash[:date].to_s}"
      }.to_json
    end
  end
  {
    :desc => "#{req_hash[:evt_arg].desc} not occurs on #{req_hash[:date].to_s}"
  }.to_json
end
