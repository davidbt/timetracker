class Employee < ApplicationRecord
  belongs_to :user

  def full_name
    "#{name} #{last_name}"
  end
end
