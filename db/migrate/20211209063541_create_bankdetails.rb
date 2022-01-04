class CreateBankdetails < ActiveRecord::Migration[6.1]
  def change
    create_table :bankdetails do |t|
      t.string :account_name
      t.string :country
      t.string :iban
      t.string :bic
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
