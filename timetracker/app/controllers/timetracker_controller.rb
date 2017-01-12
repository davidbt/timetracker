class TimetrackerController < ApplicationController
  before_action :authenticate_user!

  DAYS_BEFORE_PAYCHECK = 3

  def late
    @start = ''
    @end = ''

    # and array or arrays with the dates and the employees that didn't come
    @dates_not_come = []
    if params[:range]
      range = params[:range]
      @start = range[:start]
      @end = range[:end]

      @late_checkins = Timetrack.late_checkins_by_range(@start, @end)

      # employees that does not come
      date = Date.parse(@start)
      # TODO: make it a big query instead of many queries.
      while date <= Date.parse(@end)
        if is_weekend?(date)
          date += 1.days
          next
        end
        @dates_not_come << [date, Employee.absent_employees(date)]
        date += 1.days
      end
    else
      @late_checkins = Timetrack.late_checkins
    end

  end

  def review
    @next_payckeck_day = PaycheckDay.where("date >= now()::date").order(:date).first
    diff = (@next_payckeck_day.date - Date.today).to_i
    if diff <= DAYS_BEFORE_PAYCHECK
      @error = "Sorry, paycheck day is too soon. (#{@next_payckeck_day.date})"
    else
      # TODO: maybe replace all this with just one query with several joins
      @last_payckeck_day = PaycheckDay.where("date <= now()::date").order("date desc").first
      @employee = Employee.where("user_id = #{current_user.id}").first
      @badge = Badge.where("employee_id = ?", @employee.id).order("id desc").first
      @timetracks = Timetrack.where("date between ? and now()::date + '1 day'::interval and badge_id = ?", @last_payckeck_day.date, @badge.id)
    end
  end

  private

  def is_weekend?(day)
    day.saturday? || day.sunday?
  end
end
