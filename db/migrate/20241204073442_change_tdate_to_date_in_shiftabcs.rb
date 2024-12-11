class ChangeTdateToDateInShiftabcs < ActiveRecord::Migration[7.1]
  def change
    change_column :shiftabcs, :tdate, :date
  end
end
