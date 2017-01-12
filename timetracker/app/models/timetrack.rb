class Timetrack < ApplicationRecord
  belongs_to :badge
  scope :late_checkins, -> { where("inout_type = 'in' and time > '09:00:00'::time") }
  scope :late_checkins_by_range, -> (range_start, range_end) {where("date between ? and ? and inout_type = 'in' and time > '09:00:00'::time", range_start, range_end).order("date", "time").all}
end
