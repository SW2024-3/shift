class CreateShiftabcs < ActiveRecord::Migration[7.1]
  def change
    create_table :shiftabcs do |t|
      t.date :tdate
      t.integer :shift
      t.integer :user_id

      t.timestamps
    end
  end
end
