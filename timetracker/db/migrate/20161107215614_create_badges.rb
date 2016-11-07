class CreateBadges < ActiveRecord::Migration[5.0]
  def change
    create_table :badges do |t|
      t.references :employee, foreign_key: true
      t.string :barcode

      t.timestamps
    end
  end
end
