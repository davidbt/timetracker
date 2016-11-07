class CreatePaycheckDays < ActiveRecord::Migration[5.0]
  def change
    create_table :paycheck_days do |t|
      t.date :date

      t.timestamps
    end
  end
end
