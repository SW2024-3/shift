class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uname
      t.string :pass
      t.string :name
      t.string :color
      t.integer :money

      t.timestamps
    end
  end
end
