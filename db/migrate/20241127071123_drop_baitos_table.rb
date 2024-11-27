class DropBaitosTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :baitos
  end

end
