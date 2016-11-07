class TimetrackerController < ApplicationController
  before_action :authenticate_user!
  def late
    @s = ''
    @e = ''
    @late_employees = Timetrack.where("inout_type = 'in' and time > '09:00:00'::time")
    # and array or arrays with the dates and the employees that didn't come
    @dates_not_come = []
    if params[:range]
      range = params[:range]
      @s = range[:start]
      @e = range[:end]

      # employees that get late
      @late_employees = Timetrack.where("date between ? and ? and inout_type = 'in' and time > '09:00:00'::time", @s, @e).order("date", "time").all

      # employees that does not come
      d = Date.parse(@s)
      # TODO: make it a big query instead of many queries.
      while d <= Date.parse(@e)
        if d.saturday? or d.sunday?
          d += 1.days
          next
        end
        es = Employee.where("id not in (select b.employee_id from timetracks tt inner join badges b on b.id = tt.badge_id where date = ?)", d).order('name')
        @dates_not_come << [d, es]
        d += 1.days
      end
    end
  end

  def review
    @next_payckeck_day = PaycheckDay.where("date >= now()::date").order(:date).first
    diff = (@next_payckeck_day.date - Date.today).to_i
    # TODO: maybe replace all this with just one query with several joins
    @last_payckeck_day = PaycheckDay.where("date <= now()::date").order("date desc").first
    @employee = Employee.where("user_id = #{current_user.id}").first
    @badge = Badge.where("employee_id = ?", @employee.id).order("id desc").first
    @tts = Timetrack.where("date between ? and now()::date + '1 day'::interval and badge_id = ?", @last_payckeck_day.date, @badge.id)
  end
end
