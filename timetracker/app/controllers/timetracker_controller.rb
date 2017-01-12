class TimetrackerController < ApplicationController
  before_action :authenticate_user!
  def late
    @start = ''
    @end = ''
    @late_employees = Timetrack.where("inout_type = 'in' and time > '09:00:00'::time")
    # and array or arrays with the dates and the employees that didn't come
    @dates_not_come = []
    if params[:range]
      range = params[:range]
      @start = range[:start]
      @end = range[:end]

      # employees that get late
      @late_employees = Timetrack.where("date between ? and ? and inout_type = 'in' and time > '09:00:00'::time", @start, @end).order("date", "time").all

      # employees that does not come
      date = Date.parse(@start)
      # TODO: make it a big query instead of many queries.
      while date <= Date.parse(@end)
        if date.saturday? or date.sunday?
          date += 1.days
          next
        end
        employees = Employee.where("id not in (select b.employee_id from timetracks tt inner join badges b on b.id = tt.badge_id where date = ?)", date).order('name')
        @dates_not_come << [date, employees]
        date += 1.days
      end
    end
  end

  def review
    @next_payckeck_day = PaycheckDay.where("date >= now()::date").order(:date).first
    diff = (@next_payckeck_day.date - Date.today).to_i
    # TODO: make the 3 a configuration
    if diff <= 3
      @error = "Sorry, paycheck day is too soon. (#{@next_payckeck_day.date})"
    else
      # TODO: maybe replace all this with just one query with several joins
      @last_payckeck_day = PaycheckDay.where("date <= now()::date").order("date desc").first
      @employee = Employee.where("user_id = #{current_user.id}").first
      @badge = Badge.where("employee_id = ?", @employee.id).order("id desc").first
      @timetracks = Timetrack.where("date between ? and now()::date + '1 day'::interval and badge_id = ?", @last_payckeck_day.date, @badge.id)
    end
  end
end
