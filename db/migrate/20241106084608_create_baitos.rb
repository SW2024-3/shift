class CreateBaitos < ActiveRecord::Migration[7.1]
  def change
    create_table :baitos do |t|
      t.datetime :tdate
      t.time :stime
      t.time :etime
      t.integer :user_id

      t.timestamps
    end
  end
end
