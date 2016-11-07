class CreateTimetracks < ActiveRecord::Migration[5.0]
  def change
    create_table :timetracks do |t|
      t.references :badge, foreign_key: true
      t.date :date
      t.time :time
      t.string :inout_type

      t.timestamps
    end
  end
end
