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
        es = Employee.where("id not in (select b.employee_id from timetracks tt inner join badges b on b.id = tt.badge_id where date = ?)", d).order('name')
        @dates_not_come << [d, es]
        d += 1.days
      end
    end
  end
end
