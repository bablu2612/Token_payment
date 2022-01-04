class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.string :status
      t.string :amount
      t.string :response

      t.timestamps
    end
  end
end
