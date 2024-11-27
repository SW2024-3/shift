class CreateShiftabcs < ActiveRecord::Migration[7.1]
  def change
    create_table :shiftabcs do |t|
      t.datetime :tdate
      t.integer :shift
      t.integer :user_id

      t.timestamps
    end
  end
end
