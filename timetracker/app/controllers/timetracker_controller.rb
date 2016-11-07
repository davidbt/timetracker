class TimetrackerController < ApplicationController
  before_action :authenticate_user!
  def late
    @s = ''
    @e = ''
    @late_employees = Timetrack.where("time > '09:00:00'::time")
    # and array or arrays with the dates and the employees that didn't come
    @dates_not_come = []
    if params[:range]
      range = params[:range]
      @s = range[:start]
      @e = range[:end]

      # employees that get late
      @late_employees = Timetrack.where("date between ? and ? and time > '09:00:00'::time", @s, @e).order("date", "time").all
    end
  end
end
