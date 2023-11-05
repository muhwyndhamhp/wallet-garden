class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.references :source_wallet, foreign_key: false
      t.references :target_wallet, foreign_key: false
      t.integer :operation

      t.timestamps
    end
    add_foreign_key :transactions, :wallets, column: :source_wallet_id
    add_foreign_key :transactions, :wallets, column: :target_wallet_id
  end
end
