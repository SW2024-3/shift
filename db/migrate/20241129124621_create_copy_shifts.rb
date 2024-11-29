class CreateCopyShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :copy_shifts do |t|
      t.datetime :tdate
      t.integer :shift
      t.integer :user_id
      t.datetime :tcopy

      t.timestamps
    end
  end
end
