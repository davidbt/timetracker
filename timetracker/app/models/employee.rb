class Employee < ApplicationRecord
  belongs_to :user
  scope :absent_employees, -> (date) { where("id not in (select b.employee_id from timetracks tt inner join badges b on b.id = tt.badge_id where date = ?)", date).order('name')}

  def full_name
    "#{name} #{last_name}"
  end
end
