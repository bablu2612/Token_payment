class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :tokens, :tranaction_id, :transfer_id

  end
end
